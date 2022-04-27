//
//  ImagePicker.swift
//  TennisBuddy
//
//  Created by Yuheng Ding on 2022/4/27.
//

import Foundation
import UIKit
import SwiftUI
import FirebaseFirestore
import FirebaseStorage

// boilderplate code from https://swiftuirecipes.com/blog/swiftui-image-picker
struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) private var presentationMode // allows you to dismiss the image picker overlay
    @Binding var selectedImage: UIImage // selected image binding
    @Binding var didSet: Bool // tells if the view was set or cancelled
    var sourceType = UIImagePickerController.SourceType.photoLibrary

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.navigationBar.tintColor = .clear
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController,
                              context: UIViewControllerRepresentableContext<ImagePicker>) { }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let control: ImagePicker

        init(_ control: ImagePicker) {
            self.control = control
        }

        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                control.selectedImage = resizedImage(image: image, for: CGSize(width: 40, height: 40))
                control.didSet = true
                
                // upload to Firebase Storage
                uploadImage(str: createUniqueStr(), image: control.selectedImage)
    
            }
            control.presentationMode.wrappedValue.dismiss()
        }
    }
    
    static func resizedImage(image: UIImage, for size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { (context) in
            image.draw(in: CGRect(origin: .zero, size: size))
        }
    }
    
    static func uploadImage(str uniqueStr: String, image: UIImage) {
        let storageRef = globalStorage.reference()
        let imagesRef = storageRef.child("images")
        
        let currImageRef = imagesRef.child(uniqueStr)
        currImageRef.putData(image.pngData()!, metadata: nil) {
            url, error in
            guard error == nil else {
                print("failed to upload image \(error.debugDescription)")
                return
            }
            
            UserRepository.instance.updateImageUrl(uniqueStr)
            UserRepository.instance.refresh()
            GameRepository.instance.refresh()
            
        }
    }
}

// create a unique string for image reference on Firebase Storage
func createUniqueStr() -> String {
    let d = Date()
    let df = DateFormatter()
    df.dateFormat = "yMMdd_H:mm:ss_SSSS"
    let uniName = df.string(from: d)
    let uniqueStr = "\(globalUserViewModel.currUser!.uid)_\(uniName).png"
    return uniqueStr
}
