//
//  Coordinator.swift
//  TicMaster
//
//  Created by Chao Zeng on 2/9/20.
//  Copyright © 2020 livingston. All rights reserved.
//

import SwiftUI

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @Binding var isCoordinatorShown: Bool
    @Binding var picked: String?
    @Binding var inventory:[String:Int]
    init(isShown: Binding<Bool>, picked: Binding<String?>, inventory: Binding<[String:Int]>) {
        
        _isCoordinatorShown = isShown
        _picked = picked
        _inventory = inventory
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let unwrapImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        
        switch picked {
        case "A":
            //            imageA = Image(uiImage: unwrapImage)
            saveImage(image: unwrapImage, name: "haha.png")
            inventory["A"] = 10
        case "B":
            //            imageB = Image(uiImage: unwrapImage)
            inventory["B"] = 10
        case "C":
            //            imageC = Image(uiImage: unwrapImage)
            inventory["C"] = 10
        case "D":
            //            imageD = Image(uiImage: unwrapImage)
            inventory["D"] = 10
        default:
            print("wrong")
        }
        
        isCoordinatorShown = false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        isCoordinatorShown = false
    }
    
    func saveImage(image: UIImage, name: String) -> Bool {
        guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else {
            return false
        }
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
            return false
        }
        do {
            try data.write(to: directory.appendingPathComponent(name)!)
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    
}

