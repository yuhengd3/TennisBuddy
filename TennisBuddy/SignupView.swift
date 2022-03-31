//
//  SignupView.swift
//  TennisBuddy
//
//  Created by Yuheng Ding on 2022/3/31.
//

import SwiftUI

struct SignupView: View {
    @State var email = ""
    @State var password = ""
    @State var username = ""
    
    var body: some View {
        VStack {
            HStack {
                Text("Create Account")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer(minLength: 0)
            }
            .padding(.horizontal, 25)
            .padding(.top, 30)
            
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
                
                Text("Username")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                
                TextField("username", text: $username)
                    .padding()
                    .background(.white)
                    .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 5)
                    .shadow(color: .black.opacity(0.08), radius: 5, x: 0, y: -5)
                
            }
            .padding(.horizontal, 15)
            .padding(.top, 25)
            .padding(.bottom, 25)
            
            Button(action: {
                
            }, label: {
                Text("Sign Up")
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
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
