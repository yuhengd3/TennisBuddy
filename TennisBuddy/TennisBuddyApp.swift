//
//  TennisBuddyApp.swift
//  TennisBuddy
//
//  Created by Yuheng Ding on 2022/3/26.
//

import SwiftUI
import Firebase

var globalUserViewModel = UserViewModel()
let USERS = "users"

@main
struct TennisBuddyApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

// helpers
func getOwnername(of: Game) -> String {
    UserRepository.instance.fetchUser(uid: of.owner)!.username
}

func getOwnerAvatar(of: Game) -> String? {
    UserRepository.instance.fetchUser(uid: of.owner)?.avatar
}
