//
//  ContentView.swift
//  DownLoadFile
//
//  Created by Hanlin Chen on 1/13/21.
//

import SwiftUI


class DonwloadProgress:NSObject, ObservableObject, URLSessionDownloadDelegate, URLSessionTaskDelegate {
    @Published var data = Data()
    @Published var ratio: Float = 0
    private  var donwloadTask : URLSessionDownloadTask!
    override init(){
        super.init()
        let url = URL(string:"http://127.0.0.1:4000/test.png" )
        let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
        donwloadTask =  urlSession.downloadTask(with: url!)
        
    }
    
    func startDonwload(){
        donwloadTask.resume()
    }
    func urlSession(_ session: URLSession,
                    downloadTask: URLSessionDownloadTask,
                    didWriteData bytesWritten: Int64,
                    totalBytesWritten: Int64,
                    totalBytesExpectedToWrite: Int64){
      
            DispatchQueue.main.async {
                
                let ratio = Float(totalBytesWritten)/Float(totalBytesWritten)
                self.ratio = ratio
            
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        do {
            
            let documentURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask,appropriateFor: nil, create: false)
            let saveURL = documentURL.appendingPathComponent(location.lastPathComponent)
            
            try FileManager.default.moveItem(at: location, to: saveURL)
            
            print("file saved at \(saveURL.path)")
            DispatchQueue.main.async {
                self.data = try! Data(contentsOf: saveURL)
            }
        
            
        }
        catch {
            print(error)
        }
        
    }
    
    
    
}



struct ContentView: View {
    
    @ObservedObject var downloader =  DonwloadProgress()
    
    var body: some View {
        VStack{
            if downloader.data.count != 0 {
                Image(uiImage: UIImage(data: downloader.data)!).resizable().aspectRatio(contentMode: .fit).padding()
            }
            ProgressView("Donwload Progress", value: downloader.ratio, total: 1.0).accentColor(.primary).padding()
            Button(action: {
                print("downloading")
                downloader.startDonwload()
            }, label: {
                Text("Download").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).padding().background(Color.purple).foregroundColor(.white).cornerRadius(10).shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
