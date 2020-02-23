//
//  ContentView.swift
//  TicMaster
//
//  Created by Chao Zeng on 2/2/20.
//  Copyright © 2020 livingston. All rights reserved.
//

import SwiftUI
import Photos

struct TicketListView: View {
    
    @State var showCaptureImageView: Bool = false
    @State var inventory: [Item:TicketDetail] = [.A:TicketDetail(), .B:TicketDetail(), .C:TicketDetail(), .D:TicketDetail()]
    
    @State var picked: Item
    @State private var action: Int? = 0
    
    @State var showingAlert = false
    
    @State var isEditing = false
    @State var firstStop = ""
    @State var secondStop = ""
    @State var showPermission = false
    
    @State var isPreview = false
    
    var body: some View {
        NavigationView{
            
            ZStack{
                Color.white
                
                VStack(alignment: .leading) {
                    HStack {
                        if isEditing {
                            TextField("Enter bus stop...", text: $firstStop, onEditingChanged: { (changed) in
                                
                            }) {
                                DataIO().saveData(firstStop: self.firstStop, secondStop: self.secondStop)
                                self.isEditing = false
                            }.padding(.vertical, 20).textFieldStyle(RoundedBorderTextFieldStyle()).font(.headline)
                            
                        } else {
                            Text(self.firstStop).font(.headline).foregroundColor(Color.black).padding(.top, 10)
                        }
                        Spacer()
                    }
                    HStack(alignment: .top) {
                        NavigationLink(destination: TicketView(name: picked, tickets: inventory), tag: 1, selection: $action) {
                            EmptyView()
                        }
                        TicketIconView(inventory: $inventory, ticketNumber: Binding.constant(.A), isEditing: $isEditing, showingAlert: $showingAlert, picked: $picked, action: $action, showPermission: $showPermission, showCaptureImageView: $showCaptureImageView)
                        
                        
                        Spacer()
                        
                        if(self.inventory[.A]!.count == -1){
                            Image("no-ticket")
                                .renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .hidden()
                            
                        }else {
                            TicketIconView(inventory: $inventory, ticketNumber: Binding.constant(.B), isEditing: $isEditing, showingAlert: $showingAlert, picked: $picked, action: $action, showPermission: $showPermission, showCaptureImageView: $showCaptureImageView)
                        }
                        
                        
                    }
                    HStack{
                        if isEditing {
                            TextField("Enter bus stop...", text: $secondStop, onEditingChanged: { (changed) in
                                
                            }) {
                                DataIO().saveData(firstStop: self.firstStop, secondStop: self.secondStop)
                                self.isEditing = false
                            }.padding(.vertical, 20).textFieldStyle(RoundedBorderTextFieldStyle()).font(.headline)
                            
                        } else {
                            Text(self.secondStop).font(.headline).foregroundColor(Color.black).padding(.top, 10)
                        }
                        Spacer()
                    }
                    HStack(alignment: .top) {
                        
                        TicketIconView(inventory: $inventory, ticketNumber: Binding.constant(.C), isEditing: $isEditing, showingAlert: $showingAlert, picked: $picked, action: $action, showPermission: $showPermission, showCaptureImageView: $showCaptureImageView)
                        
                        
                        Spacer()
                        
                        if(self.inventory[.C]!.count == -1){
                            Image("no-ticket")
                                .renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .hidden()
                        }else {
                            TicketIconView(inventory: $inventory, ticketNumber: Binding.constant(.D), isEditing: $isEditing, showingAlert: $showingAlert, picked: $picked, action: $action, showPermission: $showPermission, showCaptureImageView: $showCaptureImageView)
                        }
                        
                        
                    }
                    
                    Spacer()
                        .alert(isPresented: $showingAlert) {
                            Alert(title: Text("Delete Ticket"), message: Text("Do you want to delete this ticket"), primaryButton: .default(Text("Delete"), action: {self.deleteTicket()}), secondaryButton: .default(Text("Cancel")))
                    }
                    if isEditing {
                        Button(action: {
                            DataIO().saveData(firstStop: self.firstStop, secondStop: self.secondStop)
                            self.isEditing = false
                        }) {
                            HStack {
                                Text("Finish").fontWeight(.semibold)
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.init(hex: "4ABC96"))
                            .cornerRadius(8)
                        }
                    }
                    
                    if showPermission {
                        Text("To use a ticket from photo library, please go to Settings -> Privacy -> Photos -> TicMaster to allow access")
                    }
                    
                }.padding()
                
                if (showCaptureImageView) {
                    CaptureImageView(isShown: $showCaptureImageView, picked: $picked, inventory: $inventory)
                }
            }
            .navigationBarHidden(self.showCaptureImageView)
            .navigationBarTitle("TicMaster", displayMode: .inline)
                .navigationBarItems(trailing:
                    Button(action: {
                        self.isEditing = true
                    }){
                        Image("edit-icon").resizable().aspectRatio(contentMode: .fit).frame(width: 25, height: 25)
                    }.buttonStyle(PlainButtonStyle())
            )
                .onAppear{self.loadData()}
            
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func loadData() {
        if(!self.isPreview){
            inventory = DataIO().loadData()
        }
        (firstStop, secondStop) = DataIO().loadData()
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
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TicketListView(inventory:[.A:TicketDetail(count: 8),.B:TicketDetail(count: 8),.C:TicketDetail(count: 8),.D:TicketDetail(count: 8)], picked: .A, isPreview: true)
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



