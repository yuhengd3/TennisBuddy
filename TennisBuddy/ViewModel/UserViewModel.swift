//
//  UserViewModel.swift
//  TennisBuddy
//
//  Created by Yuheng Ding on 2022/3/27.
//

import SwiftUI

class UserViewModel: ObservableObject {
    @Published private(set) var model = AuthModel()
    
    // MARK: - Intent(s)
    
    func updateUID(_ uid: String) {
        model.uid = uid;
    }
}
