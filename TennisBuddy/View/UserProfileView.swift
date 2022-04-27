//
//  UserProfileView.swift
//  TennisBuddy
//
//  Created by Yuheng Ding on 2022/4/24.
//

import SwiftUI

struct UserProfileView: View {
    var user : User
    var games: [Game]
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 50)
            
            Image("DefaultAvatar")
                .resizable()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .padding(.horizontal, 15)
            
            Spacer()
                .frame(height: 24)
            
            Text("\(user.username)")
                .font(.system(size: 25))
                .fontWeight(.bold)
            
            if let desc = user.description {
                Spacer()
                    .frame(height: 10)
                Text("\(desc)")
                    .foregroundColor(.gray)
                    .padding(.horizontal, 60)
            }
            
            Divider()
                .frame(height: 3)
                .background(Color("ListBackground"))
                .padding(.horizontal, 36)
            
            Spacer()
                .frame(height: 16)
            
            HStack {
                VStack(spacing:3) {
                    Text("345")
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                    
                    Text("Rating")
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 40)
                
                VStack(spacing:3) {
                    Text("34")
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                    
                    Text("Games")
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 40)
            }
            
            List {
                ForEach(games) { game in
                    ProfileGameItemView(user: user, game: game)
                }
            }
            .background(Color.gray)
            
            
            Spacer(minLength: 0)
        }
        .navigationTitle("User Profile")
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(user: user, games: finishedGames)
    }
}
