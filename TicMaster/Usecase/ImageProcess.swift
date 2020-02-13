//
//  Coordinator.swift
//  TicMaster
//
//  Created by Chao Zeng on 2/9/20.
//  Copyright © 2020 livingston. All rights reserved.
//

import SwiftUI

class ImageProcess: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @Binding var isCoordinatorShown: Bool
    @Binding var picked: Item
    @Binding var inventory:Tickets
    init(isShown: Binding<Bool>, picked: Binding<Item>, inventory: Binding<Tickets>) {
        
        _isCoordinatorShown = isShown
        _picked = picked
        _inventory = inventory
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let unwrapImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        
        switch picked {
        case Item.A:
            
            let imageName = UUID().uuidString
            if(saveImage(image: unwrapImage, name: imageName)){
                inventory.A.image = imageName
                inventory.A.count = 10
            }
        case Item.B:
            inventory.B.count = 10
        case Item.C:
            inventory.C.count = 10
        case Item.D:
            inventory.D.count = 10
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

