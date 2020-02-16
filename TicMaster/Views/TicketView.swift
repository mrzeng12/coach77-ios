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
            Text("Livingston").font(.headline).foregroundColor(Color.black)
            Text("9 Left").font(.body).foregroundColor(Color.black)
            Image(uiImage: getSavedImage(named: getImageName(name: name))! )
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Button(action: {
//                self.showDetails.toggle()
            }) {
                HStack {
                    
                    Text("USE")
                        .fontWeight(.semibold)
//                        .font(.title)
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
//                .background(
//                    LinearGradient(gradient: Gradient(colors: [.green, .blue]), startPoint: .leading, endPoint: .trailing))
                    .background(Color.green)
                .cornerRadius(8)
                .padding(.horizontal, 20)
            }
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
