//
//  TypingLoaderView.swift
//  AIChatbotDemo
//
//  Created by Maxim Brishten on 7.02.24.
//

import SwiftUI

struct TypingLoaderView: View {
    @State private var isAnimating = false
    
    var body: some View {
        HStack(spacing: 4) {
            Circle()
                .frame(width: 8, height: 8)
                .foregroundColor(Color.gray)
                .opacity(isAnimating ? 0.5 : 1)
                .scaleEffect(isAnimating ? 0.5 : 1)
                .animation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true))
            Circle()
                .frame(width: 8, height: 8)
                .foregroundColor(Color.gray)
                .opacity(isAnimating ? 0.5 : 1)
                .scaleEffect(isAnimating ? 0.5 : 1)
                .animation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true).delay(0.2))
            Circle()
                .frame(width: 8, height: 8)
                .foregroundColor(Color.gray)
                .opacity(isAnimating ? 0.5 : 1)
                .scaleEffect(isAnimating ? 0.5 : 1)
                .animation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true).delay(0.4))
        }
        .onAppear {
            self.isAnimating = true
        }
    }
}

#Preview {
    TypingLoaderView()
}
