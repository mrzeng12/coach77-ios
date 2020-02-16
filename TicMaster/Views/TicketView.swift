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
    let tickets: [Item:TicketDetail]
    var body: some View {
        VStack(alignment: .leading) {
            Text("Livingston").font(.title).foregroundColor(Color.black)
                .padding(.vertical, 10).padding(.horizontal, 20).padding(.top, 20)
            
            Text("9 Left").font(.headline).foregroundColor(Color.black)
                .padding(.vertical, 5).padding(.horizontal, 20)
            Spacer()
            Image(uiImage: getSavedImage(named: getImageName(name: name))! )
                
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Spacer()
            Button(action: {
                //                self.showDetails.toggle()
            }) {
                HStack {
                    Text("USE").fontWeight(.semibold)
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(Color.init(hex: "4ABC96"))
                .cornerRadius(8)
            }.padding(.horizontal, 20).padding(.bottom, 20)
        }
        
    }
    
    func getImageName(name: Item) ->String{
        return tickets[name]!.image
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
        TicketView(name: Item.A, tickets: [.A:TicketDetail()])
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        
        self.init(red: Double(r) / 0xff, green: Double(g) / 0xff, blue: Double(b) / 0xff)
        
    }
}
