//
//  LoginModel.swift
//  TennisBuddy
//
//  Created by Yuheng Ding on 2022/4/2.
//

import Foundation
import FirebaseAuth

class LoginModel: ObservableObject {
    var showingAlert = false
    var alertContent: String = ""
    var userViewModel: UserViewModel = globalUserViewModel
    
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let err = error {
                self.alertContent = err.localizedDescription
                self.showingAlert = true
            } else {
                let uid = Auth.auth().currentUser!.uid
                self.userViewModel.updateUID(uid)
            }
        }
    }
}
