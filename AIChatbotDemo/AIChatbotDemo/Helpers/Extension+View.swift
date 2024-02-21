//
//  Extension+View.swift
//  AIChatbotDemo
//
//  Created by Maxim Brishten on 29.01.24.
//

import Foundation
import SwiftUI

extension View {
    func endEditing(_ force: Bool) {
        UIApplication.shared.windows.forEach { $0.endEditing(force)}
    }
}
