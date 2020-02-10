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
    //    @Binding
    @Binding var imageA: Image?
    @Binding var imageB: Image?
    @Binding var imageC: Image?
    @Binding var imageD: Image?
    @Binding var picked: String?
    init(isShown: Binding<Bool>, imageA: Binding<Image?>,
         imageB: Binding<Image?>, imageC: Binding<Image?>, imageD: Binding<Image?>, picked: Binding<String?>) {
        //        init(isShown: Binding<Bool>) {
        _isCoordinatorShown = isShown
        //        _imageInCoordinator = image
        _imageA = imageA
        _imageB = imageB
        _imageC = imageC
        _imageD = imageD
        _picked = picked
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let unwrapImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        //        imageInCoordinator = Image(uiImage: unwrapImage)
        switch picked {
        case "A":
            imageA = Image(uiImage: unwrapImage)
        case "B":
            imageB = Image(uiImage: unwrapImage)
        case "C":
            imageC = Image(uiImage: unwrapImage)
        case "D":
            imageD = Image(uiImage: unwrapImage)
        default:
            print("wrong")
        }
        
        
        isCoordinatorShown = false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        isCoordinatorShown = false
    }
}

