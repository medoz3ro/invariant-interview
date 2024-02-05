import SwiftUI

struct ConfirmView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showLoginView = false
    
    var body: some View {
        ZStack {
            Image("logo")
                .resizable()
                .scaledToFill()
                .frame(width: 300, height: 300)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Confirm your e-mail!")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .shadow(color: .black, radius: 2, x: 0, y: 2)
                
                Text("Go to Login")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .onTapGesture {
                        showLoginView = true
                    }
                    .fullScreenCover(isPresented: $showLoginView) {
                        SwiftUI.NavigationView {
                            LoginView()
                                .navigationBarHidden(true)
                        }
                    }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
