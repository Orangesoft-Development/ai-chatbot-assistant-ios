//
//  AssistantRow.swift
//  AIChatbotDemo
//
//  Created by Maxim Brishten on 26.01.24.
//

import SwiftUI

struct AssistantRow: View {
    var assistant: Assistant
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Name: \(assistant.name)")
                .font(.headline)
                .foregroundStyle(.blue)
            Text("ID: \(assistant.id)")
                .font(.headline)
                .foregroundStyle(.green)
            Text("Instruction: \(assistant.instruction)")
                .foregroundStyle(.gray)
        }
    }
}

#Preview {
    let assistant = Assistant(name: "assistant name", assistantId: "assistant id", instruction: "assistant instruction")
    return AssistantRow(assistant: assistant)
}
