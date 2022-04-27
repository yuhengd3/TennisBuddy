//
//  User.swift
//  TennisBuddy
//
//  Created by Yuheng Ding on 2022/4/23.
//

import Foundation

struct User {
    var username: String
    var uid: String
    var avatar: String?
    var rating: Double?
    var numGames = 0
    var description: String?
    
    var documentId: String?
    var id = UUID()
}
