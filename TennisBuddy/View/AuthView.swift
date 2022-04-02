//
//  AuthView.swift
//  TennisBuddy
//
//  Created by Yuheng Ding on 2022/3/31.
//

import SwiftUI

struct AuthView: View {
    
    @State var index = 0
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    withAnimation(.spring(), {
                        index = 0
                    })

                }, label: {
                    VStack {
                        Text("Login")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(index == 0 ? .black : .gray)
                        Capsule()
                            .fill(index == 0 ? Color("CarolinaBlue") : .gray)
                            .frame(height: 4)
                    }
                })
                
                Button(action: {
                    withAnimation(.spring(), {
                        index = 1
                    })
                    
                }, label: {
                    VStack {
                        Text("Sign Up")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(index == 1 ? .black : .gray)
                        Capsule()
                            .fill(index == 1 ? Color("CarolinaBlue") : .gray)
                            .frame(height: 4)
                    }
                })
            }
            .padding(.top, 10)
            
            if index == 0 {
                LoginView()
            } else {
                SignupView()
            }
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
