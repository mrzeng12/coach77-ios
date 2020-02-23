//
//  TicketIconView.swift
//  TicMaster
//
//  Created by Chao Zeng on 2/22/20.
//  Copyright © 2020 livingston. All rights reserved.
//

import SwiftUI
import Photos

struct TicketIconView: View {
    @Binding var inventory: [Item:TicketDetail]
    @Binding var ticketNumber: Item
    @Binding var isEditing: Bool
    @Binding var showingAlert: Bool
    @Binding var picked: Item
    @Binding var action: Int?
    @Binding var showPermission: Bool
    @Binding var showCaptureImageView: Bool
    
    
    init(inventory: Binding<[Item:TicketDetail]>, ticketNumber: Binding<Item>, isEditing: Binding<Bool>, showingAlert: Binding<Bool>, picked: Binding<Item>, action: Binding<Int?>, showPermission: Binding<Bool>, showCaptureImageView: Binding<Bool>) {
        _inventory = inventory
        _ticketNumber = ticketNumber
        _isEditing = isEditing
        _showingAlert = showingAlert
        _picked = picked
        _action = action
        _showPermission = showPermission
        _showCaptureImageView = showCaptureImageView
    }
    
    var body: some View {
        VStack(){
            GeometryReader { geo in
                Image(self.getImage(num: self.inventory[self.ticketNumber]!.count))
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .overlay(
                        Text((self.inventory[self.ticketNumber]!.count != -1) ? String(self.inventory[self.ticketNumber]!.count) : "")
                            .foregroundColor(self.inventory[self.ticketNumber]!.count>2 ? Color.white: Color.red)
                            .font(.body)
                            .padding(.bottom, geo.size.height/5.5)
                        ,alignment: .bottom)
                    .onTapGesture {
                        self.picked = self.ticketNumber
                        self.touchAction(self.ticketNumber)
                }.onLongPressGesture {
                    self.picked = self.ticketNumber
                    self.showingAlert = true
                }
            }.aspectRatio(contentMode: .fit)
            if isEditing && inventory[self.ticketNumber]!.count != -1 {
                Button(action: {
                    self.picked = self.ticketNumber
                    self.showingAlert = true
                }){
                    Text("delete").foregroundColor(.red)
                }
            }
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
    private func touchAction(_ btn: Item) {
        
        if self.isEditing {
            return
        }
        
        let detail:TicketDetail = inventory[btn]!
        
        
        if(detail.count >= 0){
            self.action = 1
        } else {
            self.authorizeAndShowAlbum()
        }
        
    }
    private func authorizeAndShowAlbum(){
        let photos = PHPhotoLibrary.authorizationStatus()
        if photos == .notDetermined {
            PHPhotoLibrary.requestAuthorization({status in
                if status == .authorized{
                    self.showCaptureImageView.toggle()
                }
            })
        } else if photos == .authorized {
            self.showCaptureImageView.toggle()
        } else {
            self.showPermission = true
        }
    }
}

struct TicketIconView_Previews: PreviewProvider {
    static var previews: some View {
        TicketIconView(inventory: Binding.constant([.A:TicketDetail(count: 8),.B:TicketDetail(count: 8),.C:TicketDetail(count: 8),.D:TicketDetail(count: 8)]), ticketNumber: Binding.constant(.A), isEditing: Binding.constant(false), showingAlert: Binding.constant(false) , picked: Binding.constant(.A), action: Binding.constant(0), showPermission: Binding.constant(false), showCaptureImageView: Binding.constant(false))
    }
}
