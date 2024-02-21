//
//  AssistantsListView.swift
//  AIChatbotDemo
//
//  Created by Maxim Brishten on 26.01.24.
//

import SwiftUI

struct AssistantsListView: View {
    @ObservedObject var viewModel: AssistantsListViewModel
    
    var body: some View {
        BaseStateView(viewModel: viewModel,
                      successView: AnyView(content))
        .navigationTitle("Assistants")
        .onAppear(perform: {
            viewModel.getAssistants()
        })
    }
    
    var content: some View {
        List {
            ForEach(viewModel.assistants) { assistant in
                AssistantRow(assistant: assistant)
            }
        }
    }
}

#Preview {
    AssistantsListView(viewModel: AssistantsListViewModel())
}
