//
//  TicketView.swift
//  TicMaster
//
//  Created by Zeng, Charles on 2/13/20.
//  Copyright © 2020 livingston. All rights reserved.
//

import SwiftUI

struct TicketView: View {
    let name: Item
    let tickets: Tickets
    var body: some View {
        
        Image(uiImage: getSavedImage(named: getImageName(name: name))! )
            .resizable()
            .scaledToFit()
            .frame(width: 200.0,height:200)
        
    }
    
    func getImageName(name: Item) ->String{
        switch name {
        case .A:
            return tickets.A.image
        case .B:
            return tickets.B.image
        case .C:
            return tickets.C.image
        case .D:
            return tickets.D.image
        }
    }
    
    func getSavedImage(named: String) -> UIImage? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
        }
        return nil
    }
}

struct TicketView_Previews: PreviewProvider {
    static var previews: some View {
        TicketView(name: Item.A, tickets: Tickets())
    }
}
