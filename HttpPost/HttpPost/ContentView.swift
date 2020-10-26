//
//  ContentView.swift
//  HttpPost
//
//  Created by Hanlin Chen on 10/26/20.
//

import SwiftUI

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    let parent:ImageLoader
    init(parent: ImageLoader){
        self.parent = parent
        super.init()
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let uiImage = info[.originalImage] as? UIImage {
              parent.image = uiImage
          }
        parent.imagePickerShowing.toggle()
        parent.presentationMode.wrappedValue.dismiss()
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        parent.imagePickerShowing.toggle()
        parent.presentationMode.wrappedValue.dismiss()
    }
}


struct ImageLoader: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage
    @Binding var imagePickerShowing: Bool
    func makeUIViewController(context: Context) ->  UIImagePickerController {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        picker.delegate = context.coordinator
        return  picker
    }
    func makeCoordinator() -> Coordinator {
        let coordinator = Coordinator(parent: self)
        return coordinator
    }
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
}


struct ContentView: View {
    @State var firstName: String = ""
    @State var lastName:String = ""
    @State var image:UIImage = UIImage(named: "default")!
    @State var imagePickerShowing = false
    var body: some View {
        VStack(spacing:30){
            VStack{
                Button(action: {
                    self.imagePickerShowing.toggle()
                }, label: {
                    Image(uiImage: image).resizable().frame(width: 200, height: 200).clipShape(Circle())
                }).sheet(isPresented: $imagePickerShowing, content: {
                    ImageLoader(image: $image, imagePickerShowing: $imagePickerShowing)
                })
            Text("Select A Picture")
            }
            
            TextField("First Name", text: $firstName).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.horizontal, 30)
            TextField("Last Name", text:$lastName).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.horizontal, 30)
            
            HStack {Button(action: {
                self.postJson()
            }, label: {
                
                Text("POST JSON").font(.body).fontWeight(.bold).foregroundColor(.white).padding().background(Color.blue).cornerRadius(15)
            })
            
            Button(action: {
                self.postMultiPartFormData()
            }, label: {
                
                Text("POST multipart/form-data").font(.body).fontWeight(.bold).foregroundColor(.white).padding().background(Color.yellow).cornerRadius(15)
            })
            }
        }
    }
    
    func postJson(){
        let url = URL(string: "http://localhost:8000/")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let parameters = ["firstName": firstName, "lastName": lastName]
        request.httpBody =  try! JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        URLSession.shared.dataTask(with: request){
            data, response, error in
            if error != nil {
                print(error!)
            }
        }.resume()
    }
    
    func postMultiPartFormData(){
        let url = URL(string: "http://localhost:8000/")
        var request = URLRequest(url: url!)
        let boundary = "Boundary-\(UUID().uuidString)"
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        var data = Data()
        data.append(convertFormData(boundary: boundary, name: "firstName", value: firstName).data(using: .utf8)!)
        data.append(convertFormData(boundary: boundary, name: "lastName", value: lastName).data(using: .utf8)!)
        data.append(convertFileData(boundary: boundary, name: "image", fileName: "profileimage.png", mimeType: "image/png", image: image.pngData()!))
        data.append("--\(boundary)--".data(using: .utf8)!)
        request.httpBody = data
        URLSession.shared.dataTask(with: request){
            data, response, error in
            if error != nil {
                print(error!)
            }
        }.resume()
    }
    func convertFormData(boundary: String , name:String, value:String)->String{
        var fieldString = "--\(boundary)\r\n"
        fieldString += "Content-Disposition: form-data; name=\"\(name)\"\r\n"
        fieldString += "\r\n"
        fieldString += "\(value)\r\n"
        return fieldString
    }
    func convertFileData(boundary:String, name:String, fileName:String, mimeType:String, image:Data)->Data{
        var data = Data()
        data.append("--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"\(name)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: \(mimeType)\r\n\r\n".data(using: .utf8)!)
        data.append(image)
        data.append("\r\n".data(using: .utf8)!)
        
        
        return data
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
