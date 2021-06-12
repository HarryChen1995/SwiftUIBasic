//
//  VisualEffectView.swift
//  SwiftUI3Basic
//
//  Created by Hanlin Chen on 6/11/21.
//

import SwiftUI

struct VisualEffectView: View {
    var body: some View {
        ZStack {
            Image("applecampus")
            if #available(iOS 15.0, *) {
                Text("Apple Campus").padding().background(.ultraThinMaterial).foregroundColor(.secondary)
            } else {
                // Fallback on earlier versions
            }
        }
    }
}

struct VisualEffectView_Previews: PreviewProvider {
    static var previews: some View {
        VisualEffectView()
    }
}
