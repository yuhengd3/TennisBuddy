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
    @State private var listSelected = 0
    
    init(games: [Game]) {
        self.games = games
        //Use this if NavigationBarTitle is with Large Font
        //UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "SF Mono", size: 20)!]
        // UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont.systemFont(ofSize: 20)]

        //Use this if NavigationBarTitle is with displayMode = .inline
        //UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "Georgia-Bold", size: 20)!]
    }
    
    var body: some View {
        NavigationView {
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
                    
                    ZStack {
                        
                        
                        List {
                            ForEach(listSelected == 0 ? games[..<5] : games[5...]) { game in
                                NavigationLink {
                                    GameDetailView(game: game)
                                } label: {
                                    GameListRowView(game: game)
                                        .mask(Color.black.opacity(game.opponent != nil ? 0.4 : 1))
                                }
                                .navigationTitle("")
                                .toolbar {
                                    ToolbarItem(placement: .principal) {
                                        Text("Hello")
                                    }
                                }
                            }
                        }
                        .padding(.top, 20)
                        
                        VStack {
//                            HStack(spacing: 0) {
//                                Button(action: {
//                                    listSelected = 0
//                                }, label: {
//                                    Text("All Games")
//                                        .frame(width: 140, height: 40)
//                                        .background(Color.gray)
//                                        .border(Color.green)
//                                        .foregroundColor(.black)
//                                        .cornerRadius(10)
//                                })
//
//                                Button(action: {
//                                    listSelected = 1
//                                }, label: {
//                                    Text("My Games")
//                                        .frame(width: 140, height: 40)
//                                        .border(Color.green)
//                                        .foregroundColor(.black)
//                                })
//                            }
//                            .padding(6)
                            Picker("Favorite Color", selection: $listSelected) {
                                Text("Upcoming Games").tag(0)
                                Text("My Games").tag(1)
                            }
                            .pickerStyle(.segmented)
                            .background(Color("ListBackground")) // Why does this make the segmented control opaque?
                            .opacity(1)
                            .padding(6)
                            
                            Spacer()
                        }
                        
                    }
                    
                }
                .background(Color("ListBackground"))
                
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
            .navigationTitle("Games")
            .navigationBarHidden(true)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        let user1 = User(username: "Ben4234", uid: "random_uid", avatar: nil)
        let user2 = User(username: "Jack1", uid: "random", avatar: nil)
        let games: [Game] = [
            Game(date: Date(timeIntervalSinceNow: 10), location: "Tao's Tennis Center", description: "Fun!", owner: user1),
            Game(date: Date(timeIntervalSinceNow: 10), location: "Tao's Tennis Center", description: "Fun!", owner: user1, opponent: user2),
            Game(date: Date(timeIntervalSinceNow: 100), location: "Tao's Tennis Center", description: disc, owner: user1),
            Game(date: Date(timeIntervalSinceNow: 300), location: "Tao's Tennis Center", description: disc, owner: user1, opponent: user2),
            Game(date: Date(timeIntervalSinceNow: 400), location: "Tao's Tennis Center", description: "Fun!", owner: user1),
            Game(date: Date(timeIntervalSinceNow: 10), location: "Tao's Tennis Center", description: "Fun!", owner: user1, opponent: user2),
            Game(date: Date(timeIntervalSinceNow: 10), location: "Tao's Tennis Center", description: "Fun!", owner: user1),
            Game(date: Date(timeIntervalSinceNow: 10), location: "Tao's Tennis Center", description: "Fun!", owner: user1, opponent: user2),
            Game(date: Date(timeIntervalSinceNow: 400), location: "Tao's Tennis Center", description: "Fun!", owner: user1),
            Game(date: Date(timeIntervalSinceNow: 10), location: "Tao's Tennis Center", description: "Fun!", owner: user1, opponent: user2),
            Game(date: Date(timeIntervalSinceNow: 10), location: "Tao's Tennis Center", description: "Fun!", owner: user1),
            Game(date: Date(timeIntervalSinceNow: 10), location: "Tao's Tennis Center", description: "Fun!", owner: user1, opponent: user2)
        ]
        return GameView(games: games)
            .previewInterfaceOrientation(.portrait)
    }
}
