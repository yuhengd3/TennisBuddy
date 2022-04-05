//
//  GameView.swift
//  TennisBuddy
//
//  Created by Yuheng Ding on 2022/4/4.
//

import SwiftUI

struct GameView: View {
    var games: [Game]
    var body: some View {
        ZStack {
            VStack {
                // Header
                ZStack {
                    Rectangle()
                        .foregroundColor(Color("PrincetonOrange"))
                        .ignoresSafeArea()
                        .frame(height: 80)
                        
                    HStack {
                        Spacer()
                        Text("Tennis Buddy")
                            .font(.largeTitle)
                        .foregroundColor(.white)
                        
                        Spacer()
                        
                        Button(action: {
                            
                        }, label: {
                            VStack(spacing: 0) {
                                Image("MatchIcon")
                                Text("Play Now!")
                                    .foregroundColor(.white)
                                    .font(.system(size: 14))
                                    .padding(5)
                            }
                        })
                            .padding(.trailing)
                    }
                }
                
                HStack {
                    Text("Scheduled Games")
                        .padding(.horizontal)
                    
                    Spacer()
                }
                
                
                
                Spacer()

            }
            
            // Floating Button
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(Color("PrincetonOrange"))
                            .font(.system(size: 56))
                            .padding()
                    })
                }
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static let games = [
        Game(date: Date(), owner: "Jack Ma", ownerAvatar: nil, location: "Tao Tennis Center", maxNumPlayers: 4, players: ["Yuheng", "Joe"], note: "All ages are welcome", status: .toStart),
        Game(date: Date(), owner: "Jack Ma", ownerAvatar: nil, location: "Tao Tennis Center", maxNumPlayers: 4, players: ["Yuheng", "Joe"], note: "All ages are welcome", status: .toStart),
        Game(date: Date(), owner: "Jack Ma", ownerAvatar: nil, location: "Tao Tennis Center", maxNumPlayers: 4, players: ["Yuheng", "Joe"], note: "All ages are welcome", status: .toStart),
        Game(date: Date(), owner: "Jack Ma", ownerAvatar: nil, location: "Tao Tennis Center", maxNumPlayers: 4, players: ["Yuheng", "Joe"], note: "All ages are welcome", status: .toStart),
        Game(date: Date(), owner: "Jack Ma", ownerAvatar: nil, location: "Tao Tennis Center", maxNumPlayers: 4, players: ["Yuheng", "Joe"], note: "All ages are welcome", status: .toStart),
        Game(date: Date(), owner: "Jack Ma", ownerAvatar: nil, location: "Tao Tennis Center", maxNumPlayers: 4, players: ["Yuheng", "Joe"], note: "All ages are welcome", status: .toStart)
    ]
    static var previews: some View {
        GameView(games: games)
    }
}
