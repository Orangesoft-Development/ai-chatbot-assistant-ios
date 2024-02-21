//
//  WebView.swift
//  AIChatbotDemo
//
//  Created by Maxim Brishten on 26.01.24.
//

import SwiftUI

struct WebView: View {
    @ObservedObject var viewModel: WebViewModel
    
    var body: some View {
        AIWebView()
    }
}

#Preview {
    WebView(viewModel: WebViewModel())
}
