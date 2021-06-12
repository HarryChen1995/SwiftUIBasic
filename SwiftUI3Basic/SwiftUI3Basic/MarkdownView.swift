//
//  MarkdownView.swift
//  SwiftUI3Basic
//
//  Created by Hanlin Chen on 6/11/21.
//

import SwiftUI

struct MarkdownView: View {
    var body: some View {
        VStack {
      
            Text("This is regular text")
            Text("This is **bold text**")
            Text("This is *italic* text")
            Text("~~A stikethrough example~~")
            Text("`Monospaced` works too")
            Text("Vist Apple: [click here](https://apple.com)")

        }
    }
}

struct MarkdownView_Previews: PreviewProvider {
    static var previews: some View {
        MarkdownView()
    }
}
