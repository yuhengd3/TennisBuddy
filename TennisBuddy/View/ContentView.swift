//
//  ContentView.swift
//  TennisBuddy
//
//  Created by Yuheng Ding on 2022/3/26.
//

import SwiftUI

let fakeGames = [
    Game(date: Date(timeIntervalSinceNow: 100), owner: "Jack Ma", ownerAvatar: nil, location: "Tao Tennis Center", maxNumPlayers: 4, players: ["Yuheng", "Joe"], note: "All ages are welcome", status: .toStart),
    Game(date: Date(timeIntervalSinceNow: 200), owner: "Jack Ma", ownerAvatar: nil, location: "Tao Tennis Center", maxNumPlayers: 4, players: ["Yuheng", "Joe"], note: "All ages are welcome", status: .toStart),
    Game(date: Date(timeIntervalSinceNow: 300), owner: "Jack Ma", ownerAvatar: nil, location: "Tao Tennis Center", maxNumPlayers: 2, players: ["Yuheng", "Joe"], note: "All ages are welcome", status: .toStart),
    Game(date: Date(timeIntervalSinceNow: 400), owner: "Jack Ma", ownerAvatar: nil, location: "Tao Tennis Center", maxNumPlayers: 4, players: ["Yuheng", "Joe"], note: "All ages are welcome", status: .toStart),
    Game(date: Date(timeIntervalSinceNow: 500), owner: "Jack Ma", ownerAvatar: nil, location: "Tao Tennis Center", maxNumPlayers: 2, players: ["Yuheng", "Joe"], note: "All ages are welcome", status: .toStart),
    Game(date: Date(timeIntervalSinceNow: 1101), owner: "Jack Ma", ownerAvatar: nil, location: "Tao Tennis Center", maxNumPlayers: 4, players: ["Yuheng", "Joe"], note: "All ages are welcome", status: .toStart),
    Game(date: Date(timeIntervalSinceNow: 1000), owner: "Jack Ma", ownerAvatar: nil, location: "Tao Tennis Center", maxNumPlayers: 2, players: ["Yuheng", "Joe"], note: "All ages are welcome", status: .toStart),
    Game(date: Date(timeIntervalSinceNow: 1200), owner: "Jack Ma", ownerAvatar: nil, location: "Tao Tennis Center", maxNumPlayers: 4, players: ["Yuheng", "Joe"], note: "All ages are welcome", status: .toStart)
]

struct ContentView: View {
    @State private var selection = 0
    
    let scrollEdgeAppearance =  UITabBarAppearance()
    
    init() {
        UITabBar.appearance().backgroundColor = .lightGray
        UITabBar.appearance().scrollEdgeAppearance = scrollEdgeAppearance
    }
    
    // TODO: resize icons
    var body: some View {
        TabView(selection: $selection) {
            GameView(games: fakeGames)
                .tabItem {
                    Image(systemName: "calendar.circle.fill")
                    Text("Game")
                }
                .tag(0)
            
            Text("Ranking")
                .font(.system(size: 30))
                .tabItem {
                    Image(systemName: "line.3.horizontal.circle.fill") // placeholder until a better icon is found
                    Text("Ranking")
                }
                .tag(1)
            
            Text("Message")
                .font(.system(size: 30))
                .tabItem {
                    Image(systemName: "message.circle.fill")
                    Text("Message")
                }
                .tag(2)
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.circle.fill")
                    Text("Profile")
                }
                .tag(3)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
