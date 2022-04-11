//
//  GameView.swift
//  TennisBuddy
//
//  Created by Yuheng Ding on 2022/4/4.
//

import SwiftUI

struct GameView: View {
    var games: [Game]
    @State private var showingAddGame = false
    
    init(games: [Game]) {
        self.games = games
        //Use this if NavigationBarTitle is with Large Font
        //UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "SF Mono", size: 20)!]
        // UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont.systemFont(ofSize: 20)]

        //Use this if NavigationBarTitle is with displayMode = .inline
        //UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "Georgia-Bold", size: 20)!]
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
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
                
                List {
                    ForEach(games) { game in
                        NavigationLink {
                            
                        } label: {
                            GameListRowView(game: game)
                                .mask(Color.black.opacity(game.players.count == game.maxNumPlayers ? 0.4 : 1))
                        }
                    }
                    .navigationTitle("Scheduled Games")
                    .navigationBarHidden(true)
                    .navigationBarTitleDisplayMode(.inline)
    
                }

                
                


            }
            
            // Floating Button
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        showingAddGame.toggle()
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(Color("PrincetonOrange"))
                            .font(.system(size: 56))
                            .padding()
                    })
                        .sheet(isPresented: $showingAddGame) {
                            AddGameView(showSheet: $showingAddGame)
                        }
                        
                }
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static let games = [
        Game(date: Date(timeIntervalSinceNow: 100), owner: "Jack Ma", ownerAvatar: nil, location: "Tao Tennis Center", maxNumPlayers: 4, players: ["Yuheng", "Joe"], description: "All ages are welcome", status: .toStart),
        Game(date: Date(timeIntervalSinceNow: 200), owner: "Jack Ma", ownerAvatar: nil, location: "Tao Tennis Center", maxNumPlayers: 2, players: ["Yuheng", "Joe"], description: "All ages are welcome", status: .toStart),
        Game(date: Date(timeIntervalSinceNow: 300), owner: "Jack Ma", ownerAvatar: nil, location: "Tao Tennis Center", maxNumPlayers: 4, players: ["Yuheng", "Joe"], description: "All ages are welcome", status: .toStart),
        Game(date: Date(timeIntervalSinceNow: 400), owner: "Jack Ma", ownerAvatar: nil, location: "Tao Tennis Center", maxNumPlayers: 2, players: ["Yuheng", "Joe"], description: "All ages are welcome", status: .toStart),
        Game(date: Date(timeIntervalSinceNow: 500), owner: "Jack Ma", ownerAvatar: nil, location: "Tao Tennis Center", maxNumPlayers: 4, players: ["Yuheng", "Joe"], description: "All ages are welcome", status: .toStart),
        Game(date: Date(timeIntervalSinceNow: 600), owner: "Jack Ma", ownerAvatar: nil, location: "Tao Tennis Center", maxNumPlayers: 4, players: ["Yuheng", "Joe"], description: "All ages are welcome", status: .toStart)
    ]
    static var previews: some View {
        GameView(games: games)
.previewInterfaceOrientation(.portrait)
    }
}
