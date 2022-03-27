//
//  LoginView.swift
//  TennisBuddy
//
//  Created by Yuheng Ding on 2022/3/26.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @ObservedObject var viewModel: globalUserViewModel
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State private var showingSignupAlert = false
    @State private var alertState = SignUpAlertState.success
    @State private var errorContent: String = ""
    
    @State private var showingLoginAlert = false
    
    enum SignUpAlertState {
        case success, failure
    }
    
    var body: some View {
        VStack {
            Text("Log In")
                .font(.largeTitle)
            TextField("Email", text: $email)
                .padding()
                .background(.gray)
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            SecureField("Password", text: $password)
                .padding()
                .background(.gray)
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            
            HStack {
                Button(action: {
                    login()
                }, label: {
                    Text("Submit")
                        .padding()
                        .border(.gray)
                })
                    .alert(isPresented: $showingLoginAlert) {
                        Alert(title: Text("Log In Failed"), message: Text(errorContent), dismissButton: .default(Text("Try again")))
                    }
                
                Spacer()
                    .fixedSize(horizontal: true, vertical: true)
                    .frame(width: 20)
                
                Button(action: {
                    signUp()
                }, label: {
                    Text("Sign Up")
                        .padding()
                        .border(.gray)
                })
                    .alert(isPresented: $showingSignupAlert) {
                        switch alertState {
                        case .success:
                            return Alert(title: Text("Success"), message: Text("You can log in with username and password"), dismissButton: .default(Text("Great!")))
                        case .failure:
                            return Alert(title: Text("Congrats"), message: Text(errorContent), dismissButton: .default(Text("Let me try again!")))
                        }
                }
            }
        }
        .padding()
    }
    
    private func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let err = error {
                errorContent = err.localizedDescription
                showingLoginAlert = true
            } else {
                let uid = Auth.auth().currentUser!.uid
                viewModel.updateUID(uid)
            }
        }
    }
    
    private func signUp() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let err = error {
                errorContent = err.localizedDescription
                alertState = .failure
            } else {
                alertState = .success
            }
            showingSignupAlert = true
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
