//
//  LoginModel.swift
//  TennisBuddy
//
//  Created by Yuheng Ding on 2022/4/2.
//

import Foundation
import FirebaseAuth

class LoginViewModel: ObservableObject {
    @Published var showingAlert = false
    @Published var alertContent: String = ""
    let userViewModel: UserViewModel = globalUserViewModel
    let userRepo = UserRepository.instance
    
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let err = error {
                self.alertContent = err.localizedDescription
                self.showingAlert = true
                print("login failed")
            } else {
                let uid = Auth.auth().currentUser!.uid
                self.userViewModel.currUser = self.userRepo.fetchUser(uid: uid)!
            }
        }
    }
}
