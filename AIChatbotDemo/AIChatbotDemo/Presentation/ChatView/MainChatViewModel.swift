//
//  MainChatViewModel.swift
//  AIChatbotDemo
//
//  Created by Maxim Brishten on 26.01.24.
//

import Foundation
import AISwiftAssist
import ExyteChat

@MainActor
final class MainChatViewModel: ViewModel {
    private let waitingTime: Double = 2
    private let assistantService = AssistantsService.shared
    private let weatherService = WeatherService.shared
    private let user = "user"
    private var threadId = ""

    @Published var messages: [Message] = []
    
    func sendMessage(text: String) {
        state = .loading
        Task {
            do {
                if threadId.isEmpty {
                    // Step 1: Create a Thread
                    let threadResponse = try await assistantService.aiSwiftAssistClient.threadsApi.create(by: nil)
                    threadId = threadResponse.id
                }
                
                // Step 2: Add a Message to a Thread
                let createMessage = ASACreateMessageRequest(role: user, content: text)
                let createMessageResponse = try await assistantService.aiSwiftAssistClient.messagesApi.create(by: threadId, createMessage: createMessage)
                mapMessage(from: createMessageResponse)
                
                // Step 3: Run the Assistant
                let createRun = ASACreateRunRequest(assistantId: AppConstants.assistantId)
                let run = try await assistantService.aiSwiftAssistClient.runsApi.create(by: threadId, createRun: createRun)
                
                // Step 4: Check the Run status
                try await checkRunStatus(by: run.id)
                
                // Step 5: Display the Assistant's Response
                let getMessagesResponse = try await assistantService.aiSwiftAssistClient.messagesApi.getMessages(by: threadId, parameters: nil)
                getMessagesResponse.data.forEach { mapMessage(from: $0) }
                state = .success
            } catch let error as HTTPRequestError {
                state = .error(error.localizedDescription)
            }
        }
    }
    
    func resetMessages() {
        messages = []
        threadId = ""
    }
    
    private func checkRunStatus(by runId: String) async throws {
        do {
            var isCompleted = false
            while !isCompleted {
                let run = try await assistantService.aiSwiftAssistClient.runsApi.retrieve(by: threadId, runId: runId)
                let runStatus = run.status
                
                if runStatus == "requires_action" {
                    try await makeFunctionCall(with: run)
                }
                
                isCompleted = runStatus == "completed"
                
                if !isCompleted {
                    try await Task.sleep(seconds: waitingTime)
                }
            }
        } catch {
            state = .error("Cannot get Run status")
        }
    }
    
    private func makeFunctionCall(with run: ASARun) async throws {
        let toolCallId = run.requiredAction?.submitToolOutputs.toolCalls.first?.id ?? ""
        let arguments = run.requiredAction?.submitToolOutputs.toolCalls.first?.function.arguments ?? ""
        
        let city = mapArgumentsToLocation(arguments) // "arguments": "{\"location\":\"Warsaw\"}"
        
        // make request to openweather service
        let temperature = await getTemperature(for: city)
        
        // Submitting function outputs
        let toolOutput = ASAToolOutput(toolCallId: toolCallId, output: String(temperature))
        try await assistantService.aiSwiftAssistClient.runsApi.submitToolOutputs(by: threadId, runId: run.id, toolOutputs: [toolOutput])
    }
    
    private func getTemperature(for city: String) async -> Double {
        do {
            let temperature = try await weatherService.getCurrentWeatherTemp(for: city)
            return temperature
        } catch {
            print("Cannot get weather status")
            return 0
        }
    }
    
    private func mapArgumentsToLocation(_ arguments: String) -> String {
        guard !arguments.isEmpty else { return "" }
        
        do {
            guard let jsonData = arguments.data(using: .utf8) else { return "" }
            let location = try JSONDecoder().decode(Location.self, from: jsonData).location
            return location
        } catch {
            print("Error decoding JSON location: \(error)")
            return ""
        }
    }
    
    private func mapMessage(from asaMessage: ASAMessage) {
        for content in asaMessage.content {
            let messageText = getMessageText(from: content)
            let role = Role(rawValue: asaMessage.role) ?? .user
            let date = Date(timeIntervalSince1970: TimeInterval(asaMessage.createdAt))
            let message = Message(id: asaMessage.id,
                                  user: User(id: "", name: "", avatarURL: nil, isCurrentUser: role == .user),
                                  status: nil,
                                  createdAt: date,
                                  text: messageText,
                                  attachments: [],
                                  recording: nil,
                                  replyMessage: nil)
            if !messages.contains(where: { $0.id == message.id }) {
                messages.append(message)
            }
        }
    }
    
    private func getMessageText(from content: ASAMessageContent) -> String {
        switch content {
        case .image(let aSAImageContent):
            return aSAImageContent.file_id
        case .text(let aSATextContent):
            return aSATextContent.value
        }
    }
}
