//
//  ViewModel.swift
//  AIChatbotDemo
//
//  Created by Maxim Brishten on 29.01.24.
//

import Foundation

@MainActor
class ViewModel: ObservableObject {
    @Published var state: ViewState = .initial
}

enum ViewState: Equatable {
    case initial, loading, error(String), success, empty
}

