//
//  ImageRepository.swift
//  TennisBuddy
//
//  Created by Yuheng Ding on 2022/4/27.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseStorage
import UIKit

class ImageRepository: ObservableObject {
    static let instance = ImageRepository()
    let storage = Storage.storage()
    @Published var imageDict = [String: UIImage]()
    
    func fetchCurrUserImage(_ url: String) {
        let storageRef = self.storage.reference().child("images/\(url)")
        storageRef.getData(maxSize: 10 * 1024 * 1024) { (data, err) in
            if let err = err {
                print("\(err.localizedDescription) oh loading image issue (exceeds max size?)")
            } else {
                globalUserViewModel.avatar = UIImage(data: data!)!
                globalUserViewModel.avatarReady = true
            }
        }
    }
    
    func addImageToDict(_ url: String) {
        if imageDict[url] == nil {
            let storageRef = self.storage.reference().child("images/\(url)")
            storageRef.getData(maxSize: 10 * 1024 * 1024) { (data, err) in
                if let err = err {
                    print("\(err.localizedDescription) oh loading image issue (exceeds max size?)")
                } else {
                    self.imageDict[url] = UIImage(data: data!)!
                }
            }
        }
    }
    
    
}

