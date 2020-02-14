//
//  CaptureImageView.swift
//  TicMaster
//
//  Created by Zeng, Charles on 2/13/20.
//  Copyright © 2020 livingston. All rights reserved.
//

import SwiftUI

struct CaptureImageView {
    
    /// MARK: - Properties
    @Binding var isShown: Bool
    @Binding var picked: Item
    @Binding var inventory: [Item:TicketDetail]
    
    func makeCoordinator() -> ImageProcess {
        return ImageProcess(isShown: $isShown, picked: $picked, inventory: $inventory)
    }
}

extension CaptureImageView: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<CaptureImageView>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        /// Default is images gallery. Un-comment the next line of code if you would like to test camera
        //    picker.sourceType = .camera
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<CaptureImageView>) {
        
    }
}
