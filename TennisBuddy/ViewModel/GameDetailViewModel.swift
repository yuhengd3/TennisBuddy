//
//  GameDetailViewModel.swift
//  TennisBuddy
//
//  Created by Yuheng Ding on 2022/4/26.
//

import Foundation
import FirebaseFirestore

class GameDetailViewModel: ObservableObject {
    @Published var game: Game
    @Published var owner: User
    @Published var opponent: User?
    
    let userRepo = UserRepository.instance
    let gameRepo = GameRepository.instance
    var listener: ListenerRegistration? = nil

    init(game: Game) {
        self.game = game
        self.owner = userRepo.fetchUser(uid: game.owner)!
        if let oppoId = game.opponent {
            self.opponent = userRepo.fetchUser(uid: oppoId)!
        } else {
            self.opponent = nil
        }
        
        
        // Firestore realtime updates
        listener = GameRepository.instance.db.collection("games").document(game.documentId!).addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            guard let data = document.data() else {
                print("Document data was empty.")
                return
            }
            
            let date: Date = (data["date"] as! Timestamp).dateValue()
            let location: String = data["location"] as! String
            let description: String = data["description"] as! String
            let owner: String = data["owner"] as! String
            let opponent: String? = data["opponent"] as? String
            let numSets: Int = data["numSets"] as! Int
            let status: Game.GameStatus = Game.GameStatus(rawValue: data["status"] as! Int)!
            
            self.game = Game(date: date, location: location, description: description, owner: owner, opponent: opponent, numSets: numSets, status: status, documentId: document.documentID)
    
            self.owner = self.userRepo.fetchUser(uid: self.game.owner)!
            if let oppoId = self.game.opponent {
                self.opponent = self.userRepo.fetchUser(uid: oppoId)!
            } else {
                self.opponent = nil
            }
        }
    }
    
    deinit {
        // detach a listener
        listener?.remove()
    }
    
    func showJoinButton() -> Bool {
        globalUserViewModel.currUser != nil && self.game.opponent == nil && game.owner != globalUserViewModel.currUser!.uid
    }
    
    func joinGame() {
        if opponent == nil {
            self.gameRepo.joinGame(game: self.game, oppo: globalUserViewModel.currUser!.uid)
        }
    }
    
}
