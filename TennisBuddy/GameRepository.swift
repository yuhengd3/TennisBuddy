//
//  GameRepository.swift
//  TennisBuddy
//
//  Created by Yuheng Ding on 2022/4/26.
//

import Foundation
import Firebase
import FirebaseFirestore

class GameRepository {
    static let instance = GameRepository()
    let db = Firestore.firestore()
    @Published var games = [Game]()
    
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
                    print("\(document.documentID) => \(document.data())")
                    
                }
            }
        }
    }
    
    
    func fetchGamesByUserId(uid: String) -> [Game] {
        return games.filter {
            $0.owner.uid == uid || $0.opponent?.uid == uid
        }
    }
}
