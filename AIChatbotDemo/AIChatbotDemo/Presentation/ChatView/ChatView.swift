//
//  MainChatView.swift
//  AIChatbotDemo
//
//  Created by Maxim Brishten on 26.01.24.
//

import SwiftUI
import ExyteChat

struct MainChatView: View {
    @ObservedObject var viewModel: MainChatViewModel
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            BaseStateView(viewModel: viewModel,
                          successView: AnyView(chatView))
            .onTapGesture(perform: {
                self.endEditing(true)
            })
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        viewModel.resetMessages()
                    } label: {
                        Image(systemName: "arrow.counterclockwise")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        path.append("AssistantsListView")
                    } label: {
                        Image(systemName: "cpu")
                    }
                }
            }
            .navigationDestination(for: String.self) { view in
                if view == "AssistantsListView" {
                    AssistantsListView(viewModel: AssistantsListViewModel())
                        .toolbar(.hidden, for: .tabBar)
                }
            }
        }
    }
    
    var chatView: some View {
        ChatView(messages: viewModel.messages,
                 didSendMessage: { draftMessage in
            viewModel.sendMessage(text: draftMessage.text)
            self.endEditing(true)
        })
    }
}

#Preview {
    MainChatView(viewModel: MainChatViewModel())
}
