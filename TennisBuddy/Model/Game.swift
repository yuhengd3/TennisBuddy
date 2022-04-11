//
//  Game.swift
//  TennisBuddy
//
//  Created by Yuheng Ding on 2022/4/4.
//

import Foundation

struct Game : Identifiable {
    init(date: Date = Date(), owner: String = "", ownerAvatar: String? = nil, location: String = "", maxNumPlayers: Int = 2, players: [String] = [String](), description: String = "", status: Game.GameStatus = .toStart) {
        self.id = date
        self.date = date
        self.owner = owner
        self.ownerAvatar = ownerAvatar
        self.location = location
        self.maxNumPlayers = maxNumPlayers
        self.players = players
        self.description = description
        self.status = status
    }
    
    init() {
        self.id = self.date
    }
    
    var id: Date
    
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
    var description: String = ""
    var status: GameStatus = .toStart
}
