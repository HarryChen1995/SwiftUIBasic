//
//  RecordingView.swift
//  BarCodeScanner
//
//  Created by Hanlin Chen on 5/5/21.
//

import SwiftUI
import AVFoundation
import Vision
import SafariServices



class ViewController: UIViewController {
  // MARK: - Private Variables
  var captureSession = AVCaptureSession()

  // TODO: Make VNDetectBarcodesRequest variable
    lazy var detetBarcodeRequest = VNDetectBarcodesRequest {
        request, error in
        guard error == nil else {
            self.showAlert(withTitle: "Barcode Error", message: error?.localizedDescription ?? "error")
            return
        }
        self.processClassification(request)
    }
  // MARK: - Override Functions
  override func viewDidLoad() {
    super.viewDidLoad()
    checkPermissions()
    setupCameraLiveView()
  }
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    // TODO: Stop Session
    captureSession.stopRunning()

  }
}


extension ViewController {
  // MARK: - Camera
  private func checkPermissions() {
    // TODO: Checking permissions
    switch AVCaptureDevice.authorizationStatus(for: .video) {
    // 1
    case .notDetermined:
      AVCaptureDevice.requestAccess(for: .video) { [self] granted in
        if !granted {
          showPermissionsAlert()
        }
      }

    // 2
    case .denied, .restricted:
      showPermissionsAlert()

    // 3
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
    captureOutput.setSampleBufferDelegate(self, queue: DispatchQueue.global(qos: DispatchQoS.QoSClass.default))
    captureSession.addOutput(captureOutput)

    configurePreviewLayer()

    // TODO: Run session
    captureSession.startRunning()

  }

  // MARK: - Vision
  func processClassification(_ request: VNRequest) {
    // TODO: Main logic
    // 1
    guard let barcodes = request.results else { return }
    DispatchQueue.main.async { [self] in
      if captureSession.isRunning {
        view.layer.sublayers?.removeSubrange(1...)

        // 2
        for barcode in barcodes {
        
            
            guard
              // TODO: Check for QR Code symbology and confidence score
              let potentialQRCode = barcode as? VNBarcodeObservation,
              potentialQRCode.confidence > 0.9
              else { return }


          // 3
            //   showAlert(
           // withTitle: potentialQRCode.symbology.rawValue,
            // TODO: Check the confidence score
          //  message: String(potentialQRCode.confidence) )
            observationHandler(payload: potentialQRCode.payloadStringValue)

        }
      }
    }

  }

  // MARK: - Handler
  func observationHandler(payload: String?) {
    // TODO: Open it in Safari
    // 1
    guard
      let payloadString = payload,
      let url = URL(string: payloadString),
      ["http", "https"].contains(url.scheme?.lowercased())
      else { return }

    // 2
    let config = SFSafariViewController.Configuration()
    config.entersReaderIfAvailable = true

    // 3
    let safariVC = SFSafariViewController(url: url, configuration: config)
    safariVC.delegate = self
    present(safariVC, animated: true)

  }
}


// MARK: - AVCaptureDelegation
extension ViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
  func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
    // 1
    guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
      return
    }

    // 2
    let imageRequestHandler = VNImageRequestHandler(
      cvPixelBuffer: pixelBuffer,
      orientation: .right)

    // 3
    do {
        try imageRequestHandler.perform([self.detetBarcodeRequest])
    } catch {
      print(error)
    }

  }
}


// MARK: - Helper
extension ViewController {
  private func configurePreviewLayer() {
    let cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    cameraPreviewLayer.videoGravity = .resizeAspectFill
    cameraPreviewLayer.connection?.videoOrientation = .portrait
    cameraPreviewLayer.frame = view.frame
    view.layer.insertSublayer(cameraPreviewLayer, at: 0)
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


// MARK: - SafariViewControllerDelegate
extension ViewController: SFSafariViewControllerDelegate {
  func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
    captureSession.startRunning()
  }
}


struct RecordingView : UIViewControllerRepresentable {
    typealias UIViewControllerType = ViewController
    func makeUIViewController(context: Context) -> ViewController{
        let recordCV = ViewController()
        return recordCV
    }
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
    }
}

struct RecordingView_Previews: PreviewProvider {
    static var previews: some View {
        RecordingView()
    }
}
