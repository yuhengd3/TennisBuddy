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
                    GameItemView(user: user, game: game)
                }
            }
            .background(Color.gray)
            
            
            Spacer(minLength: 0)
        }
    }
}

struct GameItemView : View {
    var user: User
    var game: Game
    let dateFormatter = DateFormatter()
    
    var body: some View {
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        let oppo = user.uid != game.owner.uid ? game.owner : game.opponent!
        var status = -1
        switch game.status {
        case .ownerWin:
            status = game.owner.uid == user.uid ? 0 : 1
        case .oppoWin:
            status = game.owner.uid == user.uid ? 1 : 0
        default:
            status = 2
        }
        
        return HStack {
            Spacer()
            VStack {
                Spacer()
                Text(dateFormatter.string(from: game.date))
                Spacer()
                switch status {
                case 0:
                    Text("Won")
                        .padding(.horizontal, 10)
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(10)
                case 1:
                    Text("Lost")
                        .padding(.horizontal, 10)
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(10)
                default:
                    Text("Missing")
                        .padding(.horizontal, 10)
                        .foregroundColor(.white)
                        .background(Color.gray)
                        .cornerRadius(10)
                }
                Spacer()
            }
            Spacer()
            
            Text("V.S.")
            
            VStack(spacing: 4) {
                Image("DefaultAvatar")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    .padding(.horizontal)
                Text(oppo.username)
                    .font(.system(size: 14))
            }
        }
        .frame(height: 70)
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(user: user, games: finishedGames)
    }
}
