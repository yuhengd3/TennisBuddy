//
//  LoginView.swift
//  TennisBuddy
//
//  Created by Yuheng Ding on 2022/3/26.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @ObservedObject var loginModel = LoginModel()
    
    @State private var email: String = ""
    @State private var password: String = ""
    
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
                    // .background(.white) // ios 15
                    .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 5)
                    .shadow(color: .black.opacity(0.08), radius: 5, x: 0, y: -5)

                Text("Password")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)

                SecureField("password", text: $password)
                    .padding()
                    // .background(.white) // ios 15
                    .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 5)
                    .shadow(color: .black.opacity(0.08), radius: 5, x: 0, y: -5)

                Button(action: {
                    // TODO: add forget password functionality
                }, label: {
                    Text("Forget Password")
                        .font(.system(size: 14))
                        .fontWeight(.bold)
                })
                    .alert(isPresented: $loginModel.showingAlert) {
                        Alert(title: Text("Login Failed"), message: Text(loginModel.alertContent), dismissButton: .default(Text("Okay")))
                    }
            }
            .padding(.horizontal, 15)
            .padding(.top, 25)

            Button(action: {
                loginModel.login(email: email, password: password)
            }, label: {
                Text("Login")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 50)
                    .background(
                        Color("PrincetonOrange")
                    )
                    .cornerRadius(8)
            })
        }
        
        
    }
    
//    private func signUp() {
//        Auth.auth().createUser(withEmail: email, password: password) { result, error in
//            if let err = error {
//                errorContent = err.localizedDescription
//                alertState = .failure
//            } else {
//                alertState = .success
//            }
//            showingSignupAlert = true
//        }
//    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
