//
//  NewTextField.swift
//  SwiftUI3Basic
//
//  Created by Hanlin Chen on 6/11/21.
//

import SwiftUI

struct NewTextField: View {
    @State private var name = "Time"
    var body: some View {
        VStack(alignment: .leading){
            if #available(iOS 15.0, *) {
                TextField("Enter your name", text: $name)
                    .textFieldStyle(.roundedBorder)
                    .submitLabel(.join)
            } else {
                // Fallback on earlier versions
                TextField("Enter your name", text: $name)
                    .textFieldStyle(.roundedBorder)
            }
        }
    }
}

struct NewTextField_Previews: PreviewProvider {
    static var previews: some View {
        NewTextField()
    }
}
