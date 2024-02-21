//
//  AssistantsService.swift
//  AIChatbotDemo
//
//  Created by Maxim Brishten on 26.01.24.
//

import Foundation
import AISwiftAssist

final class AssistantsService {
    let aiSwiftAssistClient = AISwiftAssistClient(config: AISwiftAssistConfig(apiKey: AppConstants.apiKey,
                                                                              organizationId: AppConstants.organizationId))
    
    static let shared = AssistantsService()
    private init() { }
}
