import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isShowingPassword = false
    @ObservedObject var viewModel: UserViewModel = UserViewModel()
    @EnvironmentObject var userStore: UserStore
    @State private var showErrorAlert = false
    
    var isFormComplete: Bool {
        return !username.isEmpty && !password.isEmpty
        
    }
    
    var body: some View {
        SwiftUI.NavigationView {
            VStack {
                Text("Hello there 👋").padding(.top, 20)
                    .modifier(HeaderTextViewModifier())
                    .modifier(MarginViewModifier())
                Text("Username")
                    .modifier(FormTextViewModifier())
                    .padding(.top, 32)
                    .modifier(MarginViewModifier())
                TextField("Enter username", text: $username)
                    .autocapitalization(.none)
                    .modifier(MarginViewModifier())
                    .modifier(MarginViewModifier())
                Divider()
                    .foregroundColor(Color("primary500"))
                    .modifier(MarginViewModifier())
                
                Text("Password")
                    .modifier(FormTextViewModifier())
                    .padding(.top, 32)
                    .modifier(MarginViewModifier())
                HStack {
                    if isShowingPassword {
                        TextField("Enter password", text: $password)
                            .autocapitalization(.none)
                    } else {
                        SecureField("Enter password", text: $password)
                    }
                    Button(action: {
                        self.isShowingPassword.toggle()
                    }) {
                        Image(systemName: self.isShowingPassword ? "eye.slash.fill" : "eye.fill")
                            .foregroundColor(Color("blackWhite"))
                    }
                }
                .modifier(MarginViewModifier())
                .modifier(MarginViewModifier())
                
                Divider()
                    .foregroundColor(Color("primary500"))
                    .modifier(MarginViewModifier())
                Spacer()
                
                Button {
                    viewModel.loginUser(username: username, password: password) { success in
                        if success {
                            print("Login successful")
                            userStore.setMainUser()
                            userStore.isLogged = true
                            
                            
                            let contentView = NavigationView()
                                .environmentObject(userStore)
                            UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: contentView)
                            UIApplication.shared.windows.first?.makeKeyAndVisible()
                        } else {
                            print("Login failed")
                            showErrorAlert = true
                        }
                    }
                }label: {
                    Text("LOGIN")
                        .frame(maxWidth: .infinity)
                }
                .modifier(ButtonLoginRegisterModifier(isFormComplete: isFormComplete))
                .alert(isPresented: $showErrorAlert) {
                    Alert(
                        title: Text("Try again."),
                        message: Text("Wrong username or password"),
                        dismissButton: .default(Text("OK"))
                    )
                }
                .frame(maxWidth: .infinity)
                .disabled(!isFormComplete)
                .modifier(MarginViewModifier())
            }
        }
    }
}
