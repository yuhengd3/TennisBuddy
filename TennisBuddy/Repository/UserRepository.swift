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
    @Published var sortedUsers = [User]()
    
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
                    if avatar != nil {
                        ImageRepository.instance.addImageToDict(avatar!)
                    }
                }
                self.users = updatedUsers
                self.sortedUsers = updatedUsers.sorted(by: {
                    if $0.rating! > $1.rating! {
                        return true
                    } else if $0.rating! < $1.rating! {
                        return false
                    } else {
                        return $0.numGames >= $1.numGames
                    }
                })
            }
        }
    }
    
    
    func fetchUser(uid: String) -> User? {
        return users.first {
            $0.uid == uid
        }
    }
    
    func updateImageUrl(_ url: String) {
        db.collection("users").document(globalUserViewModel.currUser!.documentId!).setData([ "avatar": url ], merge: true)
    }
    
}
