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
    @Binding var inventory:[Item:TicketDetail]
    init(isShown: Binding<Bool>, picked: Binding<Item>, inventory: Binding<[Item:TicketDetail]>) {
        
        _isCoordinatorShown = isShown
        _picked = picked
        _inventory = inventory
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let unwrapImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        let imageName = UUID().uuidString
        
        
        if(FileManager.default.saveImage(image: unwrapImage, fileName: imageName)){
            
            inventory[picked]!.image = imageName
            inventory[picked]!.count = 10
            DataIO().saveData(inventory: inventory)
        }
        
        isCoordinatorShown = false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        isCoordinatorShown = false
    }
    
    
}

