import SwiftUI

struct LandingView: View {
    @EnvironmentObject var userStore: UserStore
    
    var body: some View {
        SwiftUI.NavigationView {
            if !userStore.isLogged {
                VStack {
                    Image("log_img")
                        .padding(.top, 16)
                    
                    Text("Challenge yourself wherever you are!")
                        .modifier(HeaderTextViewModifier())
                        .padding(.top, 50)
                        .padding(.bottom, 120)
                    
                    VStack {
                        NavigationLink(destination: RegisterView()) {
                            Text("GET STARTED")
                                .modifier(ButtonViewModifier())
                                .padding(.bottom, 15)
                        }
                        
                        NavigationLink(destination: LoginView()) {
                            Text("I ALREADY HAVE AN ACCOUNT")
                                .modifier(ButtonWhiteViewModifier())
                                .padding(.bottom, 15)
                        }
                        
                    }
                }
                .navigationBarTitle("")
                .navigationBarHidden(true)
            } else {
                Text("Welcome back!")
            }
        }
    }
}
