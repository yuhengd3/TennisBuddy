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

func getOpponame(of: Game) -> String? {
    if let oppoId = of.opponent {
        return UserRepository.instance.fetchUser(uid: oppoId)!.username
    }
    return nil
}

func getOppoAvatar(of: Game) -> String? {
    if let oppoId = of.opponent {
        return UserRepository.instance.fetchUser(uid: oppoId)!.avatar
    }
    return nil
}
