//
//  FormView.swift
//  SwiftUI3Basic
//
//  Created by Hanlin Chen on 6/11/21.
//

import SwiftUI

struct FormView: View {
    @State private var username = ""
    @State private var password = ""
    var body: some View {
        if #available(iOS 15.0, *) {
            Form  {
                TextField("username", text: $username)
                SecureField("password", text:$password)
            }.onSubmit {
                guard username.isEmpty == false && password.isEmpty == false else {
                    return
                }
                print("Authenticating....")
            }
        } else {
            // Fallback on earlier versions
        }
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        FormView()
    }
}
