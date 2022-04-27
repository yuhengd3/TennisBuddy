//
//  Game.swift
//  TennisBuddy
//
//  Created by Yuheng Ding on 2022/4/4.
//

import Foundation

struct Game : Identifiable, Equatable {
    
    enum GameStatus: Int {
        case toStart = 0
        case ongoing
        case completed
        case missResult
        case ownerWin
        case oppoWin
    }

    var date: Date
    var location: String // TODO: change to map?
    var description: String
    var owner: String
    var opponent: String?
    var numSets: Int = 3
    var status: GameStatus = .toStart
    
    var documentId: String?
    
    var id = UUID()
    
    static func == (lhs: Game, rhs: Game) -> Bool {
        if lhs.id == rhs.id {
            return true
        }
        return
            lhs.documentId == rhs.documentId &&
            lhs.date == rhs.date &&
            lhs.location == rhs.location &&
            lhs.owner == rhs.owner &&
            lhs.opponent == rhs.opponent &&
            lhs.numSets == rhs.numSets &&
            lhs.status == rhs.status &&
            lhs.description == rhs.description
    }
}
