//
//  ContentView.swift
//  TennisBuddy
//
//  Created by Yuheng Ding on 2022/3/26.
//

import SwiftUI

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
            GameView()
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
