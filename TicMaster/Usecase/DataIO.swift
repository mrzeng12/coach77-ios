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
//        print("save data")
//        print(inventory)
        do {
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(inventory)
            let json = String(data: jsonData, encoding: String.Encoding.utf8)
            
            let defaults = UserDefaults.standard
            defaults.set(json, forKey: "inventory")
            print(defaults.synchronize())
        } catch  let error as NSError {
            print("Error: \(error)")
        }
    }
    func loadData() -> [Item:TicketDetail] {
//        print("load data")
        do {
            let defaults = UserDefaults.standard
            let json = defaults.object(forKey: "inventory") as? String
            if json == nil {
                return [.A:TicketDetail(), .B:TicketDetail(), .C:TicketDetail(), .D:TicketDetail()]
            }
            // Decode
            let jsonDecoder = JSONDecoder()
            let jsonData = json!.data(using: .utf8)!
            let res = try jsonDecoder.decode([Item:TicketDetail].self, from: jsonData)
//            print(res)
            return res
        } catch  let error as NSError {
            print("Error: \(error)")
        }
        return [.A:TicketDetail(), .B:TicketDetail(), .C:TicketDetail(), .D:TicketDetail()]
    }
}
