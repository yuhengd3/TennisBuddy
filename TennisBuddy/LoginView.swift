//
//  LoginView.swift
//  TennisBuddy
//
//  Created by Yuheng Ding on 2022/3/26.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @ObservedObject var viewModel = globalUserViewModel
    
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
            VStack(alignment: .leading, spacing: 15) {
                Text("Email")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)

                TextField("email", text: $email)
                    .padding()
                    .background(.white)
                    .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 5)
                    .shadow(color: .black.opacity(0.08), radius: 5, x: 0, y: -5)

                Text("Password")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)

                SecureField("password", text: $password)
                    .padding()
                    .background(.white)
                    .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 5)
                    .shadow(color: .black.opacity(0.08), radius: 5, x: 0, y: -5)

                Button(action: {
                    // TODO: add forget password functionality
                }, label: {
                    Text("Forget Password")
                        .font(.system(size: 14))
                        .fontWeight(.bold)
                })
            }
            .padding(.horizontal, 15)
            .padding(.top, 25)

            Button(action: {

            }, label: {
                Text("Login")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 50)
                    .background(
                        Color("PrincetonOrange")
                        // LinearGradient(gradient: .init(colors: [Color("PrincetonOrange"), .gray]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .cornerRadius(8)
            })
                //.padding(.horizontal, 25)
                //.padding(.top, 20)
        }
        
        
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
