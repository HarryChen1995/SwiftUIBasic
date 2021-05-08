//
//  TextScannerView.swift
//  TextScanner
//
//  Created by Hanlin Chen on 5/8/21.
//

import AVFoundation
import Vision
import ImageIO

import SwiftUI
class CreditCardController: UIViewController {
    var captureSession = AVCaptureSession()
    var maskLayer = CAShapeLayer()
    var delegate:ContentView?
    private var isTapped = false
    var cameraPreviewLayer:AVCaptureVideoPreviewLayer?
    override func viewDidLoad() {
        super.viewDidLoad()
        checkPermissions()
        setupCameraLiveView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        captureSession.stopRunning()
    }
    private func checkPermissions(){
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video){
                [self] granted in
                if !granted {
                    self.showPermissionsAlert()
                }
            }
        case .denied, .restricted :
            self.showPermissionsAlert()
        default:
            return
        }
    }
    
    private func setupCameraLiveView() {
        // TODO: Setup captureSession
        captureSession.sessionPreset = .hd1280x720
        // TODO: Add input
        // 1
        let videoDevice = AVCaptureDevice
            .default(.builtInWideAngleCamera, for: .video, position: .back)
        
        // 2
        guard
            let device = videoDevice,
            let videoDeviceInput = try? AVCaptureDeviceInput(device: device),
            captureSession.canAddInput(videoDeviceInput)
        else {
            // 3
            showAlert(
                withTitle: "Cannot Find Camera",
                message: "There seems to be a problem with the camera on your device.")
            return
        }
        
        // 4
        captureSession.addInput(videoDeviceInput)
        
        // TODO: Add output
        let captureOutput = AVCaptureVideoDataOutput()
        // TODO: Set video sample rate
        captureOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_32BGRA)]
        captureOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "camera_frame_processing_queue"))
        captureSession.addOutput(captureOutput)
        guard let connection = captureOutput.connection(with: AVMediaType.video),
              connection.isVideoOrientationSupported else { return }
        
        connection.videoOrientation = .portrait
        configurePreviewLayer()
        
        // TODO: Run session
        captureSession.startRunning()
        
    }
    
}
extension CreditCardController: AVCaptureVideoDataOutputSampleBufferDelegate  {
    
    func drawBoundingBox(rect : VNRectangleObservation) {
        
        
        let transform = CGAffineTransform(scaleX: 1, y: -1).translatedBy(x: 0, y: -self.cameraPreviewLayer!.frame.height)
        
        let scale = CGAffineTransform.identity.scaledBy(x: self.cameraPreviewLayer!.frame.width, y: self.cameraPreviewLayer!.frame.height)
        
        let bounds = rect.boundingBox.applying(scale).applying(transform)
        createLayer(in: bounds)
    }
    private func createLayer(in rect: CGRect) {
        maskLayer = CAShapeLayer()
        maskLayer.frame = rect
        maskLayer.cornerRadius = 10
        maskLayer.opacity = 0.75
        maskLayer.borderColor = UIColor.gray.cgColor
        maskLayer.borderWidth = 5.0
        
        cameraPreviewLayer!.insertSublayer(maskLayer, at: 1)
    }
    
    private func  detectRectangle(in image:CVPixelBuffer) {
        let request = VNDetectRectanglesRequest(completionHandler: { (request: VNRequest, error: Error?) in
            DispatchQueue.main.async {
                
                guard let results = request.results as? [VNRectangleObservation] else { return }
                self.removeMask()
                
                guard let rect = results.first else{return}
                self.drawBoundingBox(rect: rect)
                
                if self.delegate!.isTappped{
                    self.doPerspectiveCorrection(rect, from: image)
                    self.delegate!.isTappped = false
                }
            }
        })
        
        request.minimumAspectRatio = VNAspectRatio(1.3)
        request.maximumAspectRatio = VNAspectRatio(1.6)
        request.minimumSize = Float(0.5)
        request.maximumObservations = 1
        
        
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: image, options: [:])
        try? imageRequestHandler.perform([request])
    }
    
    func doPerspectiveCorrection(_ observation: VNRectangleObservation, from buffer: CVImageBuffer) {
        
        var ciImage = CIImage(cvImageBuffer: buffer)
        
        let topLeft = observation.topLeft.scaled(to: ciImage.extent.size)
        let topRight = observation.topRight.scaled(to: ciImage.extent.size)
        let bottomLeft = observation.bottomLeft.scaled(to: ciImage.extent.size)
        let bottomRight = observation.bottomRight.scaled(to: ciImage.extent.size)
        
        ciImage = ciImage.applyingFilter("CIPerspectiveCorrection", parameters: [
            "inputTopLeft": CIVector(cgPoint: topLeft),
            "inputTopRight": CIVector(cgPoint: topRight),
            "inputBottomLeft": CIVector(cgPoint: bottomLeft),
            "inputBottomRight": CIVector(cgPoint: bottomRight),
        ])
        
        let context = CIContext()
        self.delegate!.text = ""
        let cgImage = context.createCGImage(ciImage, from: ciImage.extent)
        self.recognizeText(image: cgImage!)
        self.delegate!.uiImage = UIImage(cgImage: cgImage!)
        self.delegate!.showDetectionResult = true
        
    }
    
    
    func recognizeText(image: CGImage){
        var text = ""
        let recognizeTextRequest = VNRecognizeTextRequest {
            (request, error) in
            guard let observations = request.results as? [VNRecognizedTextObservation] else {
                return
            }
        let maxObservationCandidates = 1
            for observation in observations {
                guard  let candidate = observation.topCandidates(maxObservationCandidates).first else {
                    return
                }
                text += "\(candidate.string)\n"
                
            }
            DispatchQueue.main.async {
                self.delegate!.text = text
            }
        }
        recognizeTextRequest.recognitionLevel = .accurate
        let requstHandler = VNImageRequestHandler(cgImage: image, options: [:])
        try? requstHandler.perform([recognizeTextRequest])
    }
    func removeMask() {
        maskLayer.removeFromSuperlayer()
        
    }
    
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let frame = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            debugPrint("unable to get image from sample buffer")
            return
        }
        
        self.detectRectangle(in: frame)
    }
}

extension CreditCardController {
    
    private func configurePreviewLayer() {
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewLayer!.videoGravity = .resizeAspectFill
        cameraPreviewLayer!.connection?.videoOrientation = .portrait
        cameraPreviewLayer!.frame = view.frame
        view.layer.insertSublayer(cameraPreviewLayer!, at: 0)
    }
    
    
    private func showAlert(withTitle title: String, message: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alertController, animated: true)
        }
    }
    
    private func showPermissionsAlert() {
        showAlert(
            withTitle: "Camera Permissions",
            message: "Please open Settings and grant permission for this app to use your camera.")
    }
}


struct TectScannerView: UIViewControllerRepresentable{
    var delegate:ContentView
    func makeUIViewController(context: Context) -> CreditCardController {
        let vc = CreditCardController()
        vc.delegate = delegate
        return vc
    }
    func updateUIViewController(_ uiViewController: CreditCardController, context: Context) {
        
    }
}


extension CGPoint {
    func scaled(to size: CGSize) -> CGPoint {
        return CGPoint(x: self.x * size.width,
                       y: self.y * size.height)
    }
}
