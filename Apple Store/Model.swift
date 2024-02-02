//
//  Data.swift
//  Apple Store
//
//  Created by Gamid Gapizov on 24.01.2024.
//

import SnapKit
import Foundation


// MARK: Checking first run with UserDefaults
class DataModel {
    let firstRun = UserDefaults.standard.bool(forKey: "firstRun") as Bool
}


// MARK: Pick image for profile picture
class ImagePicker: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var imagePickerController: UIImagePickerController?
    var completion: ((UIImage) -> ())?
    
    func showImagePicker(in viewController: UIViewController, completion: ((UIImage) -> ())?) {
        self.completion = completion
        imagePickerController = UIImagePickerController()
        imagePickerController?.sourceType = .photoLibrary
        imagePickerController?.delegate = self
        viewController.present(imagePickerController!, animated: true)
    }
    
    func openImageCamera(in viewController: UIViewController, completion: ((UIImage) -> ())?) {
        self.completion = completion
        imagePickerController = UIImagePickerController()
        imagePickerController?.sourceType = .camera
        imagePickerController?.delegate = self
        viewController.present(imagePickerController!, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            self.completion?(image)
            picker.dismiss(animated: true)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
