//
//  Game.swift
//  TennisBuddy
//
//  Created by Yuheng Ding on 2022/4/4.
//

import Foundation

struct Game : Identifiable {
    
    enum GameStatus {
        case toStart
        case ongoing
        case completed
    }

    var date: Date
    var location: String // TODO: change to map?
    var description: String
    var owner: User
    var opponent: User?
    var numSets: Int = 3
    var status: GameStatus = .toStart
    
    var id = UUID()
}
