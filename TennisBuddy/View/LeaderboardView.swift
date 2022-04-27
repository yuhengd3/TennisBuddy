//
//  LeaderboardView.swift
//  TennisBuddy
//
//  Created by Yuheng Ding on 2022/4/24.
//

import SwiftUI

struct LeaderboardView: View {
    @ObservedObject var userRepo = UserRepository.instance
    @ObservedObject var imageRepo = ImageRepository.instance
    
    var body: some View {
        if userRepo.users.count < 4 {
            Text("Too Few Players")
                .padding()
        } else {
            let sortedUsers = userRepo.users.sorted {
                $0.rating! > $1.rating! || $0.numGames > $1.numGames
            }
            VStack(spacing: 0) {
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
                                UserBlockView(user: sortedUsers[1], radius: 60, idx: 2)
                                
                                Spacer()
                                    .frame(width: 50)
                                
                                UserBlockView(user: sortedUsers[2], radius: 60, idx: 3)
                            }
                        }
                        
                        VStack {
                            UserBlockView(user: sortedUsers[0], radius: 70, idx: 1)
                            
                            Spacer()
                        }
                    }
                    
                    VStack(spacing: 0) {
                        // https://stackoverflow.com/questions/57244713/get-index-in-foreach-in-swiftui
                        ForEach(Array(sortedUsers[3..<sortedUsers.count].enumerated()), id: \.offset) { index, element in
                            UserRowView(user: element, idx: index + 4)
                        }
                    }
                    
                    
                    
                    Spacer()
                }
            }
            .onAppear {
                userRepo.refresh()
            }
        }
        
    }
}

struct UserBlockView: View {
    var user: User
    var radius: CGFloat
    var idx: Int
    
    var body: some View {
        VStack {
            Text("\(idx)")
                .font(.system(size: 24))
                .fontWeight(.semibold)
            if user.avatar != nil && ImageRepository.instance.imageDict[user.avatar!] != nil {
                Image(uiImage: ImageRepository.instance.imageDict[user.avatar!]!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: radius * 2, height: radius * 2)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color("CarolinaBlue"), lineWidth: 4))
                    .padding(.horizontal)
            } else {
                Image("DefaultAvatar")
                    .resizable()
                    .scaledToFill()
                    .frame(width: radius * 2, height: radius * 2)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color("CarolinaBlue"), lineWidth: 4))
                    .padding(.horizontal)
            }

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
                if user.avatar != nil && ImageRepository.instance.imageDict[user.avatar!] != nil {
                    Image(uiImage: ImageRepository.instance.imageDict[user.avatar!]!)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                } else {
                    Image("DefaultAvatar")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                }
                
                Spacer()
                Text("\(user.username)")
                Spacer()
                
                Text("\(Int(user.rating!))")
                    .foregroundColor(Color("CarolinaBlue"))
                
                Spacer()
                    .frame(width: 20)

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
