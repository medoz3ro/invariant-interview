import SwiftUI

struct ItemCardEdit: View {
    // Use this property to dismiss the current view
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    // Back button
                    Button(action: {
                        // Action to dismiss the current view
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image("back") // Your back button image
                            .resizable()
                            .scaledToFit()
                            .frame(height: geometry.size.height * 0.05)
                            .padding(.leading)
                    }
                    
                    Spacer()
                    
                    Text("Edit")
                    
                    Spacer()
                    
                    Image("bin") // Your bin button image
                        .resizable()
                        .scaledToFit()
                        .frame(height: geometry.size.height * 0.05)
                        .padding(.trailing)
                }
                .padding(.top, geometry.safeAreaInsets.top + 20)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .edgesIgnoringSafeArea(.top)
    }
}

