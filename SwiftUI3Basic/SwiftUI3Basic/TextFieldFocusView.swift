//
//  TextFieldFocusView.swift
//  SwiftUI3Basic
//
//  Created by Hanlin Chen on 6/11/21.
//

import SwiftUI

@available(iOS 15.0, *)
struct TextFieldFocusView: View {
    enum Field {
        case firstName
        case lastName
        case emailAddress
    }
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var emailAddress = ""
    @FocusState private var focusedFields: Field?
    
    var body: some View {
        VStack {
            TextField("Enter your first name", text: $firstName).focused($focusedFields, equals: .firstName)
                .textContentType(.givenName)
                .submitLabel(.next)
            TextField("Enter your last name", text: $lastName).focused($focusedFields, equals: .lastName)
                .textContentType(.familyName)
                .submitLabel(.next)
            TextField("Enter your email", text: $emailAddress).focused($focusedFields, equals: .emailAddress)
                .textContentType(.emailAddress)
                .submitLabel(.join)
                      }.onSubmit {
                switch focusedFields {
                case .firstName :
                    focusedFields = .lastName
                case .lastName:
                    focusedFields = .emailAddress
                case .emailAddress:
                    print("join chat room...")
                default:
                    return 
                }
            }
        
    }
}
