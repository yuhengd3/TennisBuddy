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
    
    init(game: Game) {
        self.game = game
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
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
                    
                    let owner = game.owner
                    HStack {
                        Spacer(minLength: 0)
                        VStack {
                            Image("DefaultAvatar")
                                .resizable()
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                                .padding(.horizontal, 15)
                            Text("\(owner.username)")
                        }
                        
                        Spacer(minLength: 0)
                        
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
                        VStack {
                            if let oppo = game.opponent {
                                Image("DefaultAvatar")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .clipShape(Circle())
                                    .padding(.horizontal, 15)
                                Text("\(oppo.username)")
                            } else {
                                Image("QuestionMark")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40, height: 60)
                                    .clipShape(Circle())
                                    .padding(.horizontal, 25)
                            }
                        }
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

struct GameDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let user = User(username: "yuheng", uid: "134A8B23", avatar: nil)
        let disc = "At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga."
        let game = Game(date: Date.now, location: "WashU", description: disc, owner: user, opponent: nil)
        GameDetailView(game: game)
    }
}
