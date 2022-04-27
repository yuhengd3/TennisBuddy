//
//  GameRepository.swift
//  TennisBuddy
//
//  Created by Yuheng Ding on 2022/4/26.
//

import Foundation
import Firebase
import FirebaseFirestore

class GameRepository: ObservableObject {
    static let instance = GameRepository()
    let db = Firestore.firestore()
    @Published var games = [Game]()
    @Published var futureGames = [Game]()
    
    private init() {
        refresh()
    }
    
    func refresh() {
        db.collection("games").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var updatedGames = [Game]()
                
                for document in querySnapshot!.documents {
                    // print("\(document.documentID) => \(document.data())")
                    let date: Date = (document.data()["date"] as! Timestamp).dateValue()
                    let location: String = document.data()["location"] as! String
                    let description: String = document.data()["description"] as! String
                    let owner: String = document.data()["owner"] as! String
                    let opponent: String? = document.data()["opponent"] as? String
                    let numSets: Int = document.data()["numSets"] as! Int
                    let status: Game.GameStatus = Game.GameStatus(rawValue: document.data()["status"] as! Int)!
                    
                    let game = Game(date: date, location: location, description: description, owner: owner, opponent: opponent, numSets: numSets, status: status, documentId: document.documentID)
                    updatedGames.append(game)
                }
                
                updatedGames.sort {
                    $0.date < $1.date
                }
                
                self.games = updatedGames
                self.futureGames = updatedGames.filter {
                    $0.date > Date.now
                }
            }
        }
    }
    
    
    func fetchGamesByUserId(uid: String) -> [Game] {
        return games.filter {
            $0.owner == uid || $0.opponent == uid
        }
    }
    
    func createGame(_ game: Game) {
        var ref: DocumentReference? = nil
        ref = self.db.collection("games").addDocument(data: [
            "date": Timestamp(date: game.date),
            "location": game.location,
            "description": game.description,
            "owner": game.owner,
            "numSets": game.numSets,
            "status": game.status.rawValue
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document Game added with ID: \(ref!.documentID)")
                self.refresh()
            }

        }
    }
    
    func joinGame(game: Game, oppo: String) {
        db.collection("games").document(game.documentId!).setData(["opponent": oppo], merge: true) { err in
            if let err = err {
                print("Error updating game (add opponent): \(err)")
            } else {
                print("Opponent added to Game: \(game.documentId!)")
                // self.refresh()
            }
        }
    }
}
