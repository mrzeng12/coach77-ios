//
//  FileManager.swift
//  TicMaster
//
//  Created by Zeng, Charles on 2/15/20.
//  Copyright © 2020 livingston. All rights reserved.
//

import SwiftUI

extension FileManager {
    func clearTmpDirectory() {
        do {
            let tmpDirectory = try contentsOfDirectory(atPath: NSTemporaryDirectory())
            try tmpDirectory.forEach {[unowned self] file in
                let path = String.init(format: "%@%@", NSTemporaryDirectory(), file)
                try self.removeItem(atPath: path)
            }
        } catch {
            print(error)
        }
    }
    func removeExistingImage(fileName: String) {
        if fileName.isEmpty {
            return
        }
        do {
            guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
                return
            }
            try FileManager.default.removeItem(at: directory.appendingPathComponent(fileName)!)
            
        } catch let error as NSError {
            print("Error: \(error)")
        }
    }
    func saveImage(image: UIImage, fileName: String) -> Bool {
        guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else {
            return false
        }
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
            return false
        }
        do {
            try data.write(to: directory.appendingPathComponent(fileName)!)
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
}

