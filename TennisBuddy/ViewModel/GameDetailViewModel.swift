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
    
    func update() {
        self.owner = userRepo.fetchUser(uid: game.owner)!
        if let oppoId = game.opponent {
            self.opponent = userRepo.fetchUser(uid: oppoId)!
        } else {
            self.opponent = nil
        }
    }
    
    deinit {
        // detach a listener
        listener?.remove()
    }
    
    func joinGame() {
        if opponent == nil {
            self.gameRepo.joinGame(game: self.game, oppo: globalUserViewModel.currUser!.uid)
        }
    }
    
    var showJoinButton: Bool {
        globalUserViewModel.currUser != nil && self.game.opponent == nil && game.owner != globalUserViewModel.currUser!.uid
    }

    
    var showPasscode: Bool {
        if Date.now < game.date {
            return false
        }
        
        if game.status != .toStart || opponent == nil {
            return false
        }
        
        guard let currUserId = globalUserViewModel.currUser?.uid else {
            return false
        }
        
        return currUserId == owner.uid
    }
    
    var passcode: String {
        let docId = game.documentId!.uppercased()
        let idx = docId.index(docId.endIndex, offsetBy: -4)
        return String(docId[idx...])
    }
    
    var showSubmitResult: Bool {
        if Date.now < game.date {
            return false
        }
        
        if game.status != .toStart || opponent == nil {
            return false
        }
        
        guard let currUserId = globalUserViewModel.currUser?.uid else {
            return false
        }
        
        return currUserId == opponent!.uid
    }
    
    var showStatus: Bool {
        if Date.now < game.date {
            return false
        }
        
        if opponent == nil {
            return false
        }
        
        return true
    }
    
    func getStatusString() -> String {
        switch game.status {
        case .ownerWin:
            return "\(owner.username) won!"
        case .oppoWin:
            return "\(opponent!.username) won!"
        default:
            return "Missing Results"
        }
    }
    func updateGameStatus(_ status: Game.GameStatus) {
        let Sa: Double = status == .ownerWin ? 1 : 0
        let Sb: Double = status == .ownerWin ? 0 : 1
        
        let Ra: Double = owner.rating!
        let Rb = opponent!.rating!
        
        let K = 30.0
        // Elo rating algorithm
        let Ea = 1.0 / (1 + pow(10.0, (Rb - Ra) / 400.0))
        let Eb = 1.0 / (1 + pow(10.0, (Ra - Rb) / 400.0))
        
        let Ra_ = Ra + K * (Sa - Ea)
        let Rb_ = Rb + K * (Sb - Eb)
        
        game.status = status
        
        owner.numGames += 1
        owner.rating! = Ra_
        opponent!.numGames += 1
        opponent!.rating! = Rb_
        self.owner = owner
        self.opponent = opponent
        
        gameRepo.db.collection("games").document(game.documentId!).setData(["status": status.rawValue], merge: true) { err in
            if let err = err {
                print("Error updating game (add opponent): \(err)")
            } else {
                print("Updated Game Status: \(self.game.documentId!)")
                // self.refresh()
            }
        }
        
        
        userRepo.db.collection("users").document(owner.documentId!).setData(["numGames": owner.numGames, "rating": Ra_], merge: true)
        userRepo.db.collection("users").document(opponent!.documentId!).setData(["numGames": opponent!.numGames, "rating": Rb_], merge: true)
        
        
    }
    
    
    
}
