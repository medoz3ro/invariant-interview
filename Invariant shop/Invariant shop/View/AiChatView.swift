//
//  AiChatView.swift
//  Invariant shop
//
//  Created by Benjamin Sabo on 17.02.2024..
//

import SwiftUI

struct AiChatView: View {
    @State private var inputText: String = ""
    
    var body: some View {
        VStack {
            TextField("Enter text here", text: $inputText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Process") {
                ChatController.shared.processInput(inputText)
            }
            .padding()
            
            // Displaying a simple message for demonstration
            Text("Enter items like '3 bananas' or notes like 'kupiti u Spar'")
                .padding()
        }
    }
}

struct AiChatView_Previews: PreviewProvider {
    static var previews: some View {
        AiChatView()
    }
}
