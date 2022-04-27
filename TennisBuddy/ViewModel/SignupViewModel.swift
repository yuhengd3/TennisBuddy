//
//  SignupViewModel.swift
//  TennisBuddy
//
//  Created by Yuheng Ding on 2022/4/3.
//

import Foundation
import FirebaseAuth
import Firebase


class SignupViewModel: ObservableObject {
    @Published var showingAlert = false
    @Published var alertContent: String = ""
    var userViewModel: UserViewModel = globalUserViewModel
    let db = Firestore.firestore()
    let userRepo = UserRepository.instance
    
    func signup(email: String, password: String, username: String) {
        
        // TODO: set up firebase to verify email
        if email.count <= 10 || !email.hasSuffix("@wustl.edu") {
            showingAlert = true
            alertContent = "Please use a valid WashU email"
            return
        } else if username.isEmpty {
            showingAlert = true
            alertContent = "Please enter a username"
            return
        } else if username.rangeOfCharacter(from: .whitespacesAndNewlines) != nil {
            showingAlert = true
            alertContent = "Username can't contain spaces"
            return
        }
        
        db.collection(USERS).whereField("username", isEqualTo: username).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                if !querySnapshot!.documents.isEmpty {
                    self.alertContent = "Username already exists"
                    self.showingAlert = true
                    return
                }
                // print("unique username")
                Auth.auth().createUser(withEmail: email, password: password) { result, signupErr in
                    if let signupErr = signupErr {
                        self.alertContent = signupErr.localizedDescription
                        self.showingAlert = true
                        return
                    }
                    self.db.collection(USERS).addDocument(data: [
                        "username": username,
                        "uid": result!.user.uid,
                        "rating": 1000.0,
                        "numGames": 0,
                        "email": email
                    ])
                    
                    let user = User(username: username, uid: result!.user.uid, avatar: nil, rating: 1000.0, numGames: 0, description: nil)
                    self.userRepo.refresh()
                    self.userViewModel.currUser = user
                }
            }
        }
    }
}
