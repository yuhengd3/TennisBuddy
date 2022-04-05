//
//  Game.swift
//  TennisBuddy
//
//  Created by Yuheng Ding on 2022/4/4.
//

import Foundation

struct Game {
    enum GameStatus {
        case toStart
        case ongoing
        case completed
    }
    var date: Date = Date()
    var owner: String = ""
    var ownerAvatar: String?
    var location: String = "" // TODO: change to map?
    var maxNumPlayers = 2
    var players = [String]()
    var note: String = ""
    var status: GameStatus = .toStart
}
