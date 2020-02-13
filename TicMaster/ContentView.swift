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
    @State var inventory: [String:Int] = ["A":-1, "B":-1, "C":-1, "D":-1]
    
    @State var picked: String? = ""
    @State private var action: Int? = 0
    
    var body: some View {
        NavigationView{
            ZStack
                {
                    Color.white
                    
                    VStack(alignment: .leading) {
                        HStack {                Text("Livingston").font(.headline).foregroundColor(Color.black)
                            Spacer()
                        }
                        HStack {
                            NavigationLink(destination: TicketView(), tag: 1, selection: $action) {
                                EmptyView()
                            }
                            
                            Button(action: {
                                self.touchAction("A")
                                
                            }) {
                                Image(self.inventory["A"] == -1 ? "add":
                                    self.inventory["A"] == 0 ? "no-ticket" : "ticket")
                                    .renderingMode(.original)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            }
                            //                            }
                            
                            Spacer()
                            Button(action: {
                                self.touchAction("B")
                                
                            }) {
                                Image(self.inventory["A"] == -1 ? "":
                                    self.inventory["B"] == -1 ? "add":
                                    self.inventory["B"] == 0 ? "no-ticket":"ticket")
                                    .renderingMode(.original)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            }
                            
                        }
                        HStack{
                            Text("Arena").font(.headline).foregroundColor(Color.black)
                            Spacer()
                        }
                        HStack {
                            Button(action: {
                                self.touchAction("C")
                                
                            }) {
                                Image(self.inventory["C"] == -1 ? "add":
                                    self.inventory["C"] == 0 ? "no-ticket" : "ticket")
                                    .renderingMode(.original)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            }
                            
                            Spacer()
                            Button(action: {
                                self.touchAction("D")
                                
                            }) {
                                Image(self.inventory["C"] == -1 ? "":
                                    self.inventory["D"] == -1 ? "add":
                                    self.inventory["D"] == 0 ? "no-ticket":"ticket")
                                    .renderingMode(.original)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
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
    private func touchAction(_ btn: String) {
        print(btn)
        
        if(self.inventory[btn]! >= 0){
            self.action = 1
        } else {
            self.picked = btn
            self.showCaptureImageView.toggle()
        }
        
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct CaptureImageView {
    
    /// MARK: - Properties
    @Binding var isShown: Bool
    @Binding var picked: String?
    @Binding var inventory:[String:Int]
    //    var result: Bool = false
    
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
