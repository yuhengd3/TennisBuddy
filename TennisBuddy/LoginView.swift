//
//  LoginView.swift
//  TennisBuddy
//
//  Created by Yuheng Ding on 2022/3/26.
//

import SwiftUI

struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    
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
                Button {
                    login()
                } label: {
                    Text("Submit")
                        .padding()
                        .border(.gray)
                }
                
                Spacer()
                    .fixedSize(horizontal: true, vertical: true)
                    .frame(width: 20)
                
                Button {
                    signUp()
                } label: {
                    Text("Sign Up")
                        .padding()
                        .border(.gray)
                }
            }
        }
        .padding()
    }
    
    private func login() -> Bool {
        return false
    }
    
    private func signUp() -> Bool {
        return false
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
