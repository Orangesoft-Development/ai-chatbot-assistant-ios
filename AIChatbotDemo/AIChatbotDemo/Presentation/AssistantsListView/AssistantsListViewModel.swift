//
//  AssistantsListViewModel.swift
//  AIChatbotDemo
//
//  Created by Maxim Brishten on 26.01.24.
//

import Foundation
import AISwiftAssist

@MainActor
final class AssistantsListViewModel: ViewModel {
    
    private let service = AssistantsService.shared
    
    @Published var assistants: [Assistant] = []
    
    func getAssistants() {
        state = .loading
        Task {
            do {
                try await getAssistantsResponse()
            } catch let error as HTTPRequestError {
                state = .error(error.localizedDescription)
            }
        }
    }
    
    private func getAssistantsResponse() async throws {
        let assistantsResponse = try await service.aiSwiftAssistClient.assistantsApi.get(with: nil).data
        self.assistants = assistantsResponse.map { asAssistant in
            return Assistant(name: asAssistant.name ?? "", assistantId: asAssistant.id, instruction: asAssistant.instructions ?? "")
        }
        state = .success
    }
}
