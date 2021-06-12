//
//  RefreshableView.swift
//  SwiftUI3Basic
//
//  Created by Hanlin Chen on 6/11/21.
//

import SwiftUI
struct NewsItem: Decodable, Identifiable {
    let id:Int
    let title:String
    let strap:String
}
struct RefreshableView: View {
    @State private var news = [
        NewsItem(id: 0, title: "Want the latest news?", strap: "Pull to refresh!")
    ]
    var body: some View {
        NavigationView {
            if #available(iOS 15.0, *) {
                List(news){ item in
                    VStack(alignment:.leading){
                        Text(item.title).font(.headline)
                        Text(item.strap).foregroundColor(.secondary)
                    }
                }.refreshable {
                    do {
                        let url = URL(string: "https://www.hackingwithswift.com/samples/news-1.json")!
                        let (data, _) = try await URLSession.shared.data(from: url)
                        
                        news = try JSONDecoder().decode([NewsItem].self, from: data)
                    }
                    catch {
                        news = []
                    }
                    
                }
            } else {
                // Fallback on earlier versions
            }
        }
    }
}

struct RefreshableView_Previews: PreviewProvider {
    static var previews: some View {
        RefreshableView()
    }
}
