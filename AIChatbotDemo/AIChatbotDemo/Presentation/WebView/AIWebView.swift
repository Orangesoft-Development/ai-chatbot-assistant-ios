//
//  AIWebView.swift
//  AIChatbotDemo
//
//  Created by Maxim Brishten on 30.01.24.
//

import SwiftUI
import WebKit

struct AIWebView: UIViewRepresentable {
    
    let webView: WKWebView
    
    init() {
        webView = WKWebView(frame: .zero)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        return webView
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        webView.load(URLRequest(url: URL(string: AppConstants.botpressShareableURL)!))
    }
}
