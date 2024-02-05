import SwiftUI

struct RegisterView: View {
    @State private var fullName: String = ""
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var isPasswordValid: Bool = true
    @State private var showErrorAlert = false
    @State private var showConfirmView = false
    @State private var isEmailValid: Bool = true
    @State private var keyboardHeight: CGFloat = 0 // Track the keyboard height
    
    @ObservedObject var viewModel: UserViewModel = UserViewModel()
    @EnvironmentObject var userStore: UserStore
    
    var isFormComplete: Bool {
        return !fullName.isEmpty && !username.isEmpty && !email.isEmpty && !password.isEmpty && !confirmPassword.isEmpty
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        let isValid = emailPredicate.evaluate(with: email)
        isEmailValid = isValid // Update the isEmailValid state
        return isValid
    }
    
    var body: some View {
        SwiftUI.NavigationView {
            ScrollView {
                VStack {
                    Text("Create an account ✏️")
                        .padding(.top, 24)
                        .modifier(HeaderTextViewModifier())
                    
                    Text("Please enter your full name, username, email address, and password. If you forget it, then you have to do forgot password.")
                        .modifier(MarginViewModifier())
                        .padding(.top, 20)
                        .font(.system(size: 18))
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    // MARK: - Full Name
                    Group {
                        Text("Full Name")
                            .modifier(FormTextViewModifier())
                            .padding(.top, 32)
                        TextField("Enter your full name", text: $fullName)
                            .modifier(MarginViewModifier())
                        Divider()
                            .foregroundColor(Color("primary500"))
                            .modifier(MarginViewModifier())
                    }
                    
                    // MARK: - Username
                    Group {
                        Text("Username")
                            .modifier(FormTextViewModifier())
                            .padding(.top, 32)
                        TextField("Enter your username", text: $username)
                            .modifier(MarginViewModifier())
                            .autocapitalization(.none)
                        Divider()
                            .foregroundColor(Color("primary500"))
                            .modifier(MarginViewModifier())
                    }
                    
                    // MARK: - Email
                    Group {
                        Text("Email")
                            .foregroundColor(isEmailValid ? .primary : .red)
                            .modifier(FormTextViewModifier())
                            .padding(.top, 32)
                        TextField("Enter your email", text: $email)
                            .modifier(MarginViewModifier())
                            .autocapitalization(.none)
                        Divider()
                            .foregroundColor(Color("primary500"))
                            .modifier(MarginViewModifier())
                    }
                    
                    // MARK: - Password
                    Group {
                        Text("Password")
                            .foregroundColor(isPasswordValid ? .primary : .red) // Set password text color based on validity
                            .modifier(FormTextViewModifier())
                            .padding(.top, 32)
                        SecureField("Enter your password", text: $password)
                            .modifier(MarginViewModifier())
                        Divider()
                            .foregroundColor(Color("primary500"))
                            .modifier(MarginViewModifier())
                    }
                    
                    // MARK: - Confirm Password
                    Group {
                        Text("Confirm Password")
                            .foregroundColor(isPasswordValid ? .primary : .red) // Set confirm password text color based on validity
                            .modifier(FormTextViewModifier())
                            .padding(.top, 32)
                        SecureField("Confirm your password", text: $confirmPassword)
                            .modifier(MarginViewModifier())
                        Divider()
                            .foregroundColor(Color("primary500"))
                            .modifier(MarginViewModifier())
                    }
                    
                    Spacer()
                    
                    // MARK: - Sign In Button
                    NavigationLink(destination: ConfirmView(), isActive: $showConfirmView) {
                        Button {
                            if password == confirmPassword && isValidEmail(email) {
                                viewModel.registerUser(fullName: fullName, username: username, email: email, password: password, confirmPassword: confirmPassword) { success in
                                    if success {
                                        print("Register successful")
                                        showConfirmView = true // Navigate to ConfirmView
                                    } else {
                                        if email != confirmPassword {
                                            isEmailValid = false // Set email text color to red
                                        }
                                        isPasswordValid = false // Set password and confirm password text color to red
                                    }
                                }
                            } else {
                                // Handle invalid form or email
                            }
                        } label: {
                            Text("SIGN IN")
                                .frame(maxWidth: .infinity)
                        }
                        .modifier(ButtonLoginRegisterModifier(isFormComplete: isFormComplete))
                        .frame(maxWidth: .infinity)
                    }
                    .disabled(!isFormComplete) // Disable button if the form is incomplete or email is not valid
                }
                .padding(.bottom, keyboardHeight) // Adjust bottom padding based on keyboard height
            }
            .navigationBarHidden(true)
            .padding(.horizontal)
            .navigationBarBackButtonHidden(true)
            .onTapGesture {
                // Dismiss the keyboard when tapped anywhere on the screen
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            .onAppear {
                // Observe keyboard notifications to adjust the keyboard height
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
                    if let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                        keyboardHeight = keyboardSize.height
                    }
                }
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                    keyboardHeight = 0
                }
            }
            .onDisappear {
                // Stop observing keyboard notifications
                NotificationCenter.default.removeObserver(self)
            }
        }
    }
}
