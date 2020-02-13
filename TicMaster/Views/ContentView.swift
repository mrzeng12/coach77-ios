//
//  ContentView.swift
//  TicMaster
//
//  Created by Chao Zeng on 2/2/20.
//  Copyright © 2020 livingston. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var showCaptureImageView: Bool = false
    @State var inventory = Tickets()
    
    @State var picked: Item
    @State private var action: Int? = 0
    
    
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.white
                
                VStack(alignment: .leading) {
                    HStack {                Text("Livingston").font(.headline).foregroundColor(Color.black)
                        Spacer()
                    }
                    HStack {
                        NavigationLink(destination: TicketView(name: picked, tickets: inventory), tag: 1, selection: $action) {
                            EmptyView()
                        }
                        
                        Button(action: {
                            self.touchAction(.A)
                            
                        }) {
                            Image(getImage(num: inventory.A.count))
                                .renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                        
                        
                        Spacer()
                        Button(action: {
                            self.touchAction(.B)
                            
                        }) {
                            if(self.inventory.A.count == -1){
                                Spacer()
                            }else {
                                Image(getImage(num: inventory.B.count))
                                    .renderingMode(.original)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            }
                        }
                        
                    }
                    HStack{
                        Text("Arena").font(.headline).foregroundColor(Color.black)
                        Spacer()
                    }
                    HStack {
                        Button(action: {
                            self.touchAction(.C)
                            
                        }) {
                            Image(getImage(num: inventory.C.count))
                                .renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                        
                        Spacer()
                        Button(action: {
                            self.touchAction(.D)
                            
                        }) {
                            if(self.inventory.C.count == -1){
                                Spacer()
                            }else {
                                Image(getImage(num: inventory.D.count))
                                    .renderingMode(.original)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            }
                        }
                        
                    }
                    Spacer()
                }.padding()
                
                if (showCaptureImageView) {
                    CaptureImageView(isShown: $showCaptureImageView, picked: $picked, inventory: $inventory)
                }
            }.navigationBarTitle("TicMaster", displayMode: .inline)
            //                .navigationBarHidden(true)
            
            
        }
    }
    private func touchAction(_ btn: Item) {

        var detail:TicketDetail? = nil
        switch btn {
        case .A:
            detail = inventory.A
        case .B:
            detail = inventory.B
        case .C:
            detail = inventory.C
        case .D:
            detail = inventory.D
        }
        self.picked = btn
        if(detail!.count >= 0){
            self.action = 1
        } else {
            self.showCaptureImageView.toggle()
        }
        
    }
    
    private func getImage(num: Int) -> String {
        if num == -1 {
            return "add"
        } else if num == 0 {
            return "no-ticket"
        } else {
            return "ticket"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(picked: .A)
    }
}


