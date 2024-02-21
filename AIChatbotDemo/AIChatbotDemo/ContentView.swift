//
//  ContentView.swift
//  AIChatbotDemo
//
//  Created by Maxim Brishten on 26.01.24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MainChatView(viewModel: MainChatViewModel())
                .tabItem {
                    Label {
                        Text("ChatView")
                    } icon: {
                        Image(systemName: "iphone.gen2")
                    }
                    .font(.headline)
                }
            WebView(viewModel: WebViewModel())
                .tabItem {
                    Label {
                        Text("WebView")
                    } icon: {
                        Image(systemName: "display")
                    }
                    .font(.headline)
                }
        }
    }
}

#Preview {
    ContentView()
}
