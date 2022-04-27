//
//  GameDetailView.swift
//  TennisBuddy
//
//  Created by Yuheng Ding on 2022/4/23.
//

import SwiftUI

struct GameDetailView: View {
    var game: Game
    let dateFormatter = DateFormatter()
    let userRepo = UserRepository.instance
    let owner: User
    let opponent: User?
    
    init(game: Game) {
        self.game = game
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        owner = userRepo.fetchUser(uid: game.owner)!
        if let o = game.opponent {
            opponent = userRepo.fetchUser(uid: o)
        } else {
            opponent = nil
        }
    }
    
    var body: some View {
        HStack {
            VStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Time: \(dateFormatter.string(from: game.date))")
                    Text("Location: \(game.location)")
                    HStack {
                        Text("Number of Sets: \(game.numSets)")
                            .padding(.trailing)
                        if game.numSets == 3 {
                            Text("(90 min)")
                        } else {
                            Text("(2 h 45 min)")
                        }
                        
                    }
                    Text("Description:")
                    Text(game.description)
                        .padding(.bottom, 50)
                    
                    HStack {
                        Spacer(minLength: 0)
                        VStack(spacing: 6) {
                            Image("DefaultAvatar")
                                .resizable()
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                                .padding(.horizontal, 15)
                            Text("\(owner.username)")
                            if let rating = owner.rating {
                                Text("Rating: \(Int(rating))")
                            } else {
                                Text("Rating: N/A")
                            }
                            Spacer(minLength: 0)
                        }
                        .frame(height: 200)
                        
                        Spacer(minLength: 0)
                        
                        VStack {
                            Spacer()
                                .frame(height: 12)
                            ZStack {
                                Rectangle()
                                    .fill(.black)
                                    .frame(width: 90, height: 4)
                                    .mask(LinearGradient(gradient: Gradient(colors: [.clear, .black, .black, .clear]), startPoint: .leading, endPoint: .trailing))
                                
                                Circle()
                                    .fill(.black)
                                    .frame(width: 40, height: 40)
                                
                                Text("VS")
                                    .foregroundColor(.white)
                            }
                            Spacer(minLength: 0)
                        }
                        .frame(height: 200)
                        Spacer(minLength: 0)
                        VStack(spacing: 6) {
                            if let oppo = opponent {
                                Image("DefaultAvatar")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .clipShape(Circle())
                                    .padding(.horizontal, 15)
                                Text("\(oppo.username)")
                                if let rating = oppo.rating {
                                    Text("Rating: \(Int(rating))")
                                } else {
                                    Text("Rating: N/A")
                                }
                            } else {
                                Image("QuestionMark")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40, height: 60)
                                    .clipShape(Circle())
                                    .padding(.horizontal, 25)
                            }
                            Spacer(minLength: 0)
                        }
                        .frame(height: 200)
                        Spacer(minLength: 0)
                    }
                    
                    Spacer(minLength: 0)
                    
                    
                }
                .padding(26)
                
                if game.opponent == nil {
                    Button {
                        // TODO
                    } label: {
                        HStack {
                            Spacer()
                            Text("Join Game")
                            Spacer()
                        }
                        .foregroundColor(.white)
                        .padding()
                        .font(Font.headline.smallCaps())
                        .background(Color("PrincetonOrange"))
                    }
                }
                
            }
            //.padding()
            
            Spacer(minLength: 0)
        }
        .navigationTitle("Game Detail")
    }
}

//struct GameDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        // let user = User(username: "yuheng", uid: "134A8B23", avatar: nil)
//        // let user2 = User(username: "yuheng", uid: "134A8B23", avatar: nil, rating: 300)
//        let game = Game(date: Date.now, location: "WashU", description: disc, owner: "user", opponent: "user2")
//        GameDetailView(game: game)
//    }
//}
