//
//  ProfileView.swift
//  TennisBuddy
//
//  Created by Yuheng Ding on 2022/3/27.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var userViewModel = globalUserViewModel
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .foregroundColor(Color("PrincetonOrange"))
                    .ignoresSafeArea()
                    .frame(height: 80)
                    
                Text("Profile")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
            if userViewModel.model.uid == nil {
                AuthView()
            } else {
                Text("loggedIn")
            }
            
            
            Spacer()
        }
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
