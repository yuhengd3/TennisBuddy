//
//  LeaderboardView.swift
//  TennisBuddy
//
//  Created by Yuheng Ding on 2022/4/24.
//

import SwiftUI

struct LeaderboardView: View {
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .foregroundColor(Color("PrincetonOrange"))
                    .ignoresSafeArea()
                    .frame(height: 80)
                    
                Text("Leaderboard")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
            
            ScrollView(showsIndicators: false) {
                Spacer()
                    .frame(height: 20)
                
                
                ZStack {
                    
                    
                    VStack {
                        Spacer()
                            .frame(height: 70)
                        HStack {
                            UserBlockView(user: user1, radius: 60, idx: 2, img: "Stock2")
                            
                            Spacer()
                                .frame(width: 50)
                            
                            UserBlockView(user: user2, radius: 60, idx: 3, img: "Stock3")
                        }
                    }
                    
                    VStack {
                        UserBlockView(user: user, radius: 70, idx: 1, img: "Stock1")
                        
                        Spacer()
                    }
                }
                
                VStack(spacing: 0) {
                    UserRowView(user: user1, idx: 4)
                    
                    UserRowView(user: user, idx: 5)
                    
                    UserRowView(user: user2, idx: 6)
                    
                    UserRowView(user: user1, idx: 7)
                    
                    UserRowView(user: user1, idx: 8)
                    
                    UserRowView(user: user, idx: 9)
                    
                    UserRowView(user: user2, idx: 10)
                }
                
                
                
                Spacer()
            }
        }
    }
}

struct UserBlockView: View {
    var user: User
    var radius: CGFloat
    var idx: Int
    var img: String
    
    var body: some View {
        VStack(spacing: 0) {
            Text("\(idx)")
                .font(.system(size: 24))
                .fontWeight(.semibold)
            Image(img)
                .resizable()
                .scaledToFill()
                .frame(width: radius * 2, height: radius * 2)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color("CarolinaBlue"), lineWidth: 4))
                .padding(.horizontal)
            
            Spacer()
                .frame(height: 30)
            
            Text("\(user.username)")
            
            Spacer()
                .frame(height: 10)
            Text("\(Int(user.rating!))")
                .foregroundColor(Color("CarolinaBlue"))
        }
    }
}

struct UserRowView: View {
    var user: User
    var idx: Int
    
    var body: some View {
        HStack {

            Text("\(idx)")
                .padding(.horizontal, 10)
            
            HStack {
                Image("DefaultAvatar")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                
                Spacer()
                Text("\(user.username)")
                Spacer()
                
                Text("\(Int(user.rating!))")
                    .foregroundColor(Color("CarolinaBlue"))
                
                Spacer()

            }
            .frame(width: 260)
            .background(Color("ListBackground"))
            .cornerRadius(25)
            
            
            Spacer()
                .frame(width: 20)
            
        }
        .frame(height: 70)
    }
}

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView()
    }
}
