//
//  InfoMessageView.swift
//  AIChatbotDemo
//
//  Created by Maxim Brishten on 29.01.24.
//

import SwiftUI

struct InfoMessageView: View {
    let message: String

    var body: some View {
        VStack {
            Spacer()
            Text(message)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.gray)
            Spacer()
        }
    }
}

struct InfoMessageView_Previews: PreviewProvider {
    static var previews: some View {
        InfoMessageView(message: "Hello World!")
    }
}

