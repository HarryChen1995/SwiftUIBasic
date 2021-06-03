//
//  ContentView.swift
//  WebViewBasic
//
//  Created by Hanlin Chen on 6/2/21.
//

import SwiftUI
import WebKit

class Coordinator:NSObject, WKNavigationDelegate, WKUIDelegate {
    
    let parent: WebUIView
    
    init(_ parent: WebUIView){
        self.parent = parent
    }
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
       // let ac = UIAlertController(title: "Hey, listen!", message: message, preferredStyle: .alert)
       // ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
       // present(ac, animated: true)
        completionHandler()
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            var action: WKNavigationActionPolicy?

            defer {
                decisionHandler(action ?? .allow)
            }

            guard let url = navigationAction.request.url else { return }
            print("decidePolicyFor - url: \(url)")
        }

        //Equivalent of webViewDidStartLoad:
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            print("didStartProvisionalNavigation - webView.url: \(String(describing: webView.url?.description))")
        }

        //Equivalent of didFailLoadWithError:
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            let nserror = error as NSError
            if nserror.code != NSURLErrorCancelled {
                webView.loadHTMLString("Page Not Found", baseURL: URL(string: "https://developer.apple.com/"))
            }
        }

        //Equivalent of webViewDidFinishLoad:
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            print("didFinish - webView.url: \(String(describing: webView.url?.description))")
        }
    
}

struct WebUIView: UIViewRepresentable {
    let url:URL?
    func makeUIView(context: Context) -> WKWebView {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.navigationDelegate = context.coordinator
        webView.uiDelegate = context.coordinator
        return webView
        
    }
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let loadUrl = url else {
            return
        }
        
        let request = URLRequest(url: loadUrl)
        uiView.load(request)
        
    }
}


struct ContentView: View {
    var body: some View {
        NavigationView {
            WebUIView(url: URL(string: "https://www.apple.com/")).navigationTitle("WebView")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
