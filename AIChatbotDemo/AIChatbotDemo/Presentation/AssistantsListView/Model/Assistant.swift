//
//  Assistant.swift
//  AIChatbotDemo
//
//  Created by Maxim Brishten on 26.01.24.
//

import Foundation

struct Assistant {
    let name: String
    let assistantId: String
    let instruction: String
}

extension Assistant: Identifiable {
    var id: String {
        assistantId
    }
}
