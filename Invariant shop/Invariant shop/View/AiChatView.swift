//
//  AiChatView.swift
//  Invariant shop
//
//  Created by Benjamin Sabo on 17.02.2024..
//

import SwiftUI

struct AiChatView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var inputText: String = ""
    @State private var keyboardHeight: CGFloat = 0
    var chatController: ChatController?
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack {
            Spacer()
            TextField("Enter text here", text: $inputText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .background(Color.white) // Enhance visibility
                .cornerRadius(10)
                .shadow(radius: 5) // Optional styling
                .padding(.bottom, keyboardHeight) // Adjust for keyboard
            
            Button("Process") {
                chatController?.processInputWithAI(inputText) { success, message in
                    alertMessage = message
                    showAlert = true
                    if success {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            
            Text("Enter where you need to buy your items, what items and the quantity of the items and it will automatically add it to the notes and items list")
                .padding()
        }
        .onAppear {
            self.registerKeyboardNotifications()
        }
        .onDisappear {
            NotificationCenter.default.removeObserver(self)
        }
    }
    
    private func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
            let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect ?? .zero
            self.keyboardHeight = keyboardFrame.height
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
            self.keyboardHeight = 0
        }
    }
}

struct AiChatView_Previews: PreviewProvider {
    static var previews: some View {
        AiChatView(chatController: ChatController.shared)
    }
}
