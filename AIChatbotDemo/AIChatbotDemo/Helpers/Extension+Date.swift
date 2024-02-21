//
//  Extension+Date.swift
//  AIChatbotDemo
//
//  Created by Maxim Brishten on 29.01.24.
//

import Foundation

extension Date {
    var toString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy HH:mm"
        return dateFormatter.string(from: self)
    }
}
