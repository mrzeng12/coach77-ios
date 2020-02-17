//
//  ContentView.swift
//  TicMaster
//
//  Created by Chao Zeng on 2/2/20.
//  Copyright © 2020 livingston. All rights reserved.
//

import SwiftUI

struct TicketListView: View {
    
    @State var showCaptureImageView: Bool = false
    @State var inventory: [Item:TicketDetail] = [.A:TicketDetail(), .B:TicketDetail(), .C:TicketDetail(), .D:TicketDetail()]
    
    @State var picked: Item
    @State private var action: Int? = 0
    
    @State var showingAlert = false
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.white
                
                VStack(alignment: .leading) {
                    HStack {                Text("Livingston").font(.headline).foregroundColor(Color.black).padding(.top, 10)
                        Spacer()
                    }
                    HStack {
                        NavigationLink(destination: TicketView(name: picked, tickets: inventory), tag: 1, selection: $action) {
                            EmptyView()
                        }
                        Image(getImage(num: inventory[.A]!.count))
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .overlay(
                                Text((inventory[.A]!.count != -1) ? String(inventory[.A]!.count) : "")
                                    .foregroundColor(inventory[.A]!.count>2 ? Color.white: Color.red)
                                    .font(.body)
                                    .padding(.bottom, 35)
                                ,alignment: .bottom)
                            .onTapGesture {
                                self.picked = .A
                                self.touchAction(.A)
                        }
                            
                        .onLongPressGesture {
                            self.picked = .A
                            self.showingAlert = true
                        }
                        
                        Spacer()
                        
                        if(self.inventory[.A]!.count == -1){
                            Image("no-ticket")
                                .renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .hidden()
                            
                        }else {
                            Image(getImage(num: inventory[.B]!.count))
                                .renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .overlay(
                                    Text((inventory[.B]!.count != -1) ? String(inventory[.B]!.count) : "")
                                        .foregroundColor(inventory[.B]!.count>2 ? Color.white: Color.red)
                                        .font(.body)
                                        .padding(.bottom, 35)
                                    ,alignment: .bottom)
                                .onTapGesture {
                                    self.picked = .B
                                    self.touchAction(.B)
                            }
                            .onLongPressGesture {
                                self.picked = .B
                                self.showingAlert = true
                            }
                        }
                        
                        
                    }
                    HStack{
                        Text("Arena").font(.headline).foregroundColor(Color.black).padding(.top, 10)
                        Spacer()
                    }
                    HStack {
                        
                        Image(getImage(num: inventory[.C]!.count))
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .overlay(
                                Text((inventory[.C]!.count != -1) ? String(inventory[.C]!.count) : "")
                                    .foregroundColor(inventory[.C]!.count>2 ? Color.white: Color.red)
                                    .font(.body)
                                    .padding(.bottom, 35)
                                ,alignment: .bottom)
                            .onTapGesture {
                                self.picked = .C
                                self.touchAction(.C)
                        }
                        .onLongPressGesture {
                            self.picked = .C
                            self.showingAlert = true
                        }
                        
                        
                        Spacer()
                        
                        if(self.inventory[.C]!.count == -1){
                            Image("no-ticket")
                                .renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .hidden()
                        }else {
                            Image(getImage(num: inventory[.D]!.count))
                                .renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .overlay(
                                    
                                    Text((inventory[.D]!.count != -1) ? String(inventory[.D]!.count) : "")
                                        .foregroundColor(inventory[.D]!.count>2 ? Color.white: Color.red)
                                        .font(.body)
                                        .padding(.bottom, 35)
                                    
                                    ,alignment: .bottom)
                                .onTapGesture {
                                    self.picked = .D
                                    self.touchAction(.D)
                            }
                            .onLongPressGesture {
                                self.picked = .D
                                self.showingAlert = true
                            }
                        }
                        
                        
                    }
                    
                    Spacer()
                        .alert(isPresented: $showingAlert) {
                            Alert(title: Text("Delete Ticket"), message: Text("Do you want to delete this ticket"), primaryButton: .default(Text("Delete"), action: {self.deleteTicket()}), secondaryButton: .default(Text("Cancel")))
                    }
                }.padding()
                
                if (showCaptureImageView) {
                    CaptureImageView(isShown: $showCaptureImageView, picked: $picked, inventory: $inventory)
                }
            }.navigationBarTitle("TicMaster", displayMode: .inline)
                .onAppear{self.loadData()}
            
        }
    }
    
    private func loadData() {
        inventory = DataIO().loadData()
    }
    
    private func touchAction(_ btn: Item) {
        
        let detail:TicketDetail = inventory[btn]!
        
        
        if(detail.count >= 0){
            self.action = 1
        } else {
            self.showCaptureImageView.toggle()
        }
        
    }
    
    private func deleteTicket() {
        
        if picked == .A {
            delete(item: .A)
            transfer(to: .A, from: .B)
            reset(item: .B)
        } else if picked == .C {
            delete(item: .C)
            transfer(to: .C, from: .D)
            reset(item: .D)
        } else {
            delete(item: picked)
        }
        
        DataIO().saveData(inventory: inventory)
        FileManager.default.clearTmpDirectory()
    }
    
    private func transfer(to:Item, from:Item){
        inventory[to]!.image = inventory[from]!.image
        inventory[to]!.count = inventory[from]!.count
        inventory[to]!.usage = inventory[from]!.usage
    }
    
    private func delete(item:Item){
        FileManager.default.removeExistingImage(fileName: inventory[item]!.image)
        inventory[item]!.count = -1
        inventory[item]!.image = ""
        inventory[item]!.usage = []
    }
    
    private func reset(item:Item){
        inventory[item]!.count = -1
        inventory[item]!.image = ""
        inventory[item]!.usage = []
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
        TicketListView(picked: .A)
    }
}

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
        
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}


