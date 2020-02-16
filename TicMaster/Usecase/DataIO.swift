//
//  DataIO.swift
//  TicMaster
//
//  Created by Zeng, Charles on 2/15/20.
//  Copyright © 2020 livingston. All rights reserved.
//

import SwiftUI

struct DataIO {
    func saveData(inventory: [Item:TicketDetail]){
        do {
            let defaults = UserDefaults.standard
            var encodedData = try NSKeyedArchiver.archivedData(withRootObject: inventory[.A]!, requiringSecureCoding: false)
            defaults.set(encodedData, forKey: "inventoryA")
            encodedData = try NSKeyedArchiver.archivedData(withRootObject: inventory[.B]!, requiringSecureCoding: false)
            defaults.set(encodedData, forKey: "inventoryB")
            encodedData = try NSKeyedArchiver.archivedData(withRootObject: inventory[.C]!, requiringSecureCoding: false)
            defaults.set(encodedData, forKey: "inventoryC")
            encodedData = try NSKeyedArchiver.archivedData(withRootObject: inventory[.D]!, requiringSecureCoding: false)
            defaults.set(encodedData, forKey: "inventoryD")
            
        } catch  let error as NSError {
            print("Error: \(error)")
        }
    }
    func loadData() -> [Item:TicketDetail] {
        do {
            let defaults = UserDefaults.standard
            var decodedData = defaults.object(forKey: "inventoryA") as? Data;
            let itemA:TicketDetail = decodedData == nil ? TicketDetail(): try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decodedData!) as! TicketDetail
          
            decodedData = defaults.object(forKey: "inventoryB") as? Data;
            let itemB:TicketDetail = decodedData == nil ? TicketDetail(): try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decodedData!) as! TicketDetail
            
            decodedData = defaults.object(forKey: "inventoryC") as? Data;
            let itemC:TicketDetail = decodedData == nil ? TicketDetail(): try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decodedData!) as! TicketDetail
            
            decodedData = defaults.object(forKey: "inventoryD") as? Data;
            let itemD:TicketDetail = decodedData == nil ? TicketDetail(): try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decodedData!) as! TicketDetail
            
            return [.A:itemA, .B:itemB, .C:itemC, .D:itemD]
        }catch  let error as NSError {
            print("Error: \(error)")
            return [.A:TicketDetail(), .B:TicketDetail(), .C:TicketDetail(), .D:TicketDetail()]
        }
    }
}
