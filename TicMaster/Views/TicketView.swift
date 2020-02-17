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
    @State var brightness: CGFloat
    @State var tickets: [Item:TicketDetail]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Livingston").font(.title).foregroundColor(Color.black)
                .padding(.vertical, 10).padding(.horizontal, 20).padding(.top, 20)
            HStack(){
                Text(self.getTicketCount()).font(.headline).bold()
                    .foregroundColor(tickets[name]!.count > 2 ? Color.black: Color.red)
                    .padding(.top, 10).padding(.horizontal, 20)
                Spacer()
                if(tickets[name]!.count < 10){
                    Button(action: {
                        self.unuseBtnTapped()
                    }) {
                        Text("UNUSE").font(.subheadline).padding(.top, 10).padding(.horizontal, 20)
                    }
                }
            }
            Spacer()
            Image(uiImage: getSavedImage(named: getImageName())! )
                
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Spacer()
            Button(action: {
                self.useBtnTapped()
            }) {
                HStack {
                    Text("USE").fontWeight(.semibold)
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(Color.init(hex: tickets[name]!.count > 0 ?"4ABC96":"DDDDDD"))
                .cornerRadius(8)
            }.padding(.horizontal, 20).padding(.bottom, 20)
        }
        .onAppear(perform: {
            print("ticket appear")
            self.brightness = UIScreen.main.brightness
            UIScreen.main.brightness = CGFloat(1.0)
        })
            
            .onDisappear(perform: {
                print("ticket disappear")
                UIScreen.main.brightness = self.brightness
            })
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                print("Moving to background!")
                UIScreen.main.brightness = self.brightness
        }
        
    }
    
    func getImageName() ->String{
        return tickets[name]!.image
    }
    
    func getTicketCount()->String{
        return String(tickets[name]!.count) + " Left"
    }
    
    func getSavedImage(named: String) -> UIImage? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
        }
        return nil
    }
    
    func unuseBtnTapped() {
        if tickets[name]!.count < 10 {
            tickets[name]!.count += 1
            DataIO().saveData(inventory: self.tickets)
        }
    }
    
    func useBtnTapped() {
        if tickets[name]!.count > 0 {
            tickets[name]!.count -= 1
            DataIO().saveData(inventory: self.tickets)
        }
    }
    
}

struct TicketView_Previews: PreviewProvider {
    static var previews: some View {
        TicketView(name: Item.A, brightness: 1.0, tickets: [.A:TicketDetail()])
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
