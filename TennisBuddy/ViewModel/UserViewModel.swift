//
//  UserViewModel.swift
//  TennisBuddy
//
//  Created by Yuheng Ding on 2022/3/27.
//

import SwiftUI

class UserViewModel: ObservableObject {
    @Published var currUser: User?
    @Published var avatar: UIImage = UIImage()
    @Published var avatarReady: Bool = false
    
    // MARK: - Intent(s)
    
//    func updateUID(_ uid: String) {
//        model.uid = uid;
//    }
}
