//
//  UserRepository.swift
//  TennisBuddy
//
//  Created by Yuheng Ding on 2022/4/26.
//

import Foundation
import Firebase
import FirebaseFirestore

class UserRepository: ObservableObject {
    static let instance = UserRepository()
    let db = Firestore.firestore()
    @Published var users = [User]()
    
    private init() {
        refresh()
    }
    
    func refresh() {
        db.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var updatedUsers = [User]()
                for document in querySnapshot!.documents {
                    // print("\(document.documentID) => \(document.data())")
                    let username: String = document.data()["username"] as! String
                    let uid: String = document.data()["uid"] as! String
                    let avatar: String? = document.data()["avatar"] as? String
                    let rating: Double? = document.data()["rating"] as? Double
                    let numGames = document.data()["numGames"] as? Int ?? 0
                    let description: String? = document.data()["description"] as? String
                    let user = User(username: username, uid: uid, avatar: avatar, rating: rating, numGames: numGames, description: description, documentId: document.documentID)
                    updatedUsers.append(user)
                }
                self.users = updatedUsers
            }
        }
    }
    
    
    func fetchUser(uid: String) -> User? {
        return users.first {
            $0.uid == uid
        }
    }
    
}
