//
//  LoginView.swift
//  TennisBuddy
//
//  Created by Yuheng Ding on 2022/3/26.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @ObservedObject var loginViewModel = LoginViewModel()
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 15) {
                Text("Email")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)

                TextField("email", text: $email)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                    .padding()
                    .background(.white)
                    .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 5)
                    .shadow(color: .black.opacity(0.08), radius: 5, x: 0, y: -5)

                Text("Password")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)

                SecureField("password", text: $password)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
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
                loginViewModel.login(email: email, password: password)
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
                .alert(isPresented: $loginViewModel.showingAlert) {
                    Alert(title: Text("Login Failed"), message: Text(loginViewModel.alertContent), dismissButton: .default(Text("Okay")))
                }
        }
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
