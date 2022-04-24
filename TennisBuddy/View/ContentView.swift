//
//  ContentView.swift
//  TennisBuddy
//
//  Created by Yuheng Ding on 2022/3/26.
//

import SwiftUI

let disc = "At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga."
let desc1 = "At vero eos et accusamus  mollitia animi, id est laborum et dolorum fuga."
let user = User(username: "Yuheng Ding", uid: "qwerqewrwq", avatar: nil, rating: 123, description: desc1)
let user1 = User(username: "Ben4234", uid: "random_uid", avatar: nil)
let user2 = User(username: "Jack1", uid: "random", avatar: nil, rating: 4020)

let fgames: [Game] = [
    Game(date: Date(timeIntervalSinceNow: 10), location: "Tao's Tennis Center", description: "Fun!", owner: user1),
    Game(date: Date(timeIntervalSinceNow: 20), location: "Tao's Tennis Center", description: "Fun!", owner: user1, opponent: user2),
    Game(date: Date(timeIntervalSinceNow: 100), location: "Tao's Tennis Center", description: disc, owner: user1),
    Game(date: Date(timeIntervalSinceNow: 300), location: "Tao's Tennis Center", description: disc, owner: user1, opponent: user2),
    Game(date: Date(timeIntervalSinceNow: 400), location: "Tao's Tennis Center", description: "Fun!", owner: user1),
    Game(date: Date(timeIntervalSinceNow: 10), location: "Tao's Tennis Center", description: "Fun!", owner: user1, opponent: user2),
    Game(date: Date(timeIntervalSinceNow: 10), location: "Tao's Tennis Center", description: "Fun!", owner: user1),
    Game(date: Date(timeIntervalSinceNow: 10), location: "Tao's Tennis Center", description: "Fun!", owner: user1, opponent: user2)
]

let finishedGames: [Game] = [
    Game(date: Date(timeIntervalSinceNow: 10), location: "Tao's Tennis Center", description: "Fun!", owner: user, opponent: user1, status: .ownerWin),
    Game(date: Date(timeIntervalSinceNow: 20), location: "Tao's Tennis Center", description: "Fun!", owner: user, opponent: user2, status: .oppoWin),
    Game(date: Date(timeIntervalSinceNow: 100), location: "Tao's Tennis Center", description: disc, owner: user, opponent: user2, status: .ownerWin),
    Game(date: Date(timeIntervalSinceNow: 300), location: "Tao's Tennis Center", description: disc, owner: user, opponent: user2),
    Game(date: Date(timeIntervalSinceNow: 400), location: "Tao's Tennis Center", description: "Fun!", owner: user, opponent: user1, status: .oppoWin),
    Game(date: Date(timeIntervalSinceNow: 10), location: "Tao's Tennis Center", description: "Fun!", owner: user, opponent: user2),
    Game(date: Date(timeIntervalSinceNow: 10), location: "Tao's Tennis Center", description: "Fun!", owner: user, opponent: user2, status: .oppoWin),
    Game(date: Date(timeIntervalSinceNow: 10), location: "Tao's Tennis Center", description: "Fun!", owner: user, opponent: user2)
]

struct ContentView: View {
    @State private var tabSelected = 0
    
    let scrollEdgeAppearance =  UITabBarAppearance()
    
    init() {
        UITabBar.appearance().backgroundColor = .lightGray
        UITabBar.appearance().scrollEdgeAppearance = scrollEdgeAppearance
    }
    
    var body: some View {
        
        TabView(selection: $tabSelected) {
            GameView(games: fgames)
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
