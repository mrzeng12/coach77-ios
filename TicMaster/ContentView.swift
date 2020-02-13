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
    
    enum Item: String {
        case A
        case B
        case C
        case D
    }
    
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
                            Image(self.inventory.A.count == -1 ? "add":
                                self.inventory.A.count == 0 ? "no-ticket" : "ticket")
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
                                Image(self.inventory.B.count == -1 ? "add":
                                    self.inventory.B.count == 0 ? "no-ticket":"ticket")
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
                            Image(self.inventory.C.count == -1 ? "add":
                                self.inventory.C.count == 0 ? "no-ticket" : "ticket")
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
                                Image(self.inventory.D.count == -1 ? "add":
                                    self.inventory.D.count == 0 ? "no-ticket":"ticket")
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
//        print(btn)
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
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(picked: .A)
    }
}


struct CaptureImageView {
    
    /// MARK: - Properties
    @Binding var isShown: Bool
    @Binding var picked: ContentView.Item
    @Binding var inventory:Tickets
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(isShown: $isShown, picked: $picked, inventory: $inventory)
    }
}

extension CaptureImageView: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<CaptureImageView>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        /// Default is images gallery. Un-comment the next line of code if you would like to test camera
        //    picker.sourceType = .camera
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<CaptureImageView>) {
        
    }
}

struct Tickets {
    var A: TicketDetail = TicketDetail()
    var B: TicketDetail = TicketDetail()
    var C: TicketDetail = TicketDetail()
    var D: TicketDetail = TicketDetail()
}

struct TicketDetail {
    var count: Int = -1
    var image: String = ""
}

