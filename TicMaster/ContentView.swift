//
//  ContentView.swift
//  TicMaster
//
//  Created by Chao Zeng on 2/2/20.
//  Copyright © 2020 livingston. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var imageA: Image? = Image("ticket")
    @State var imageB: Image? = Image("ticket")
    @State var imageC: Image? = Image("ticket")
    @State var imageD: Image? = Image("ticket")
    @State var showCaptureImageView: Bool = false
    
    @State var picked: String? = ""
    
    var body: some View {
        ZStack
            {
                Color.white
                VStack(alignment: .leading) {
                    HStack {                Text("Livingston").font(.headline).foregroundColor(Color.black)
                        Spacer()
                    }
                    HStack {
                        Button(action: {
                            self.touchAction("A")
                            
                        }) {
                            imageA?
                                .renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                        
                        Spacer()
                        Button(action: {
                            self.touchAction("B")
                            
                        }) {
                            imageB?
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
                            imageC?
                                .renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                        
                        Spacer()
                        Button(action: {
                            self.touchAction("D")
                            
                        }) {
                            imageD?
                                .renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                        
                    }
                    Spacer()
                }.padding()
                //                .sheet(isPresented: true, onDismiss: nil, content: ImagePicker(image: self.$image))
                if (showCaptureImageView) {
                    CaptureImageView(isShown: $showCaptureImageView, imageA: $imageA, imageB: $imageB, imageC: $imageC, imageD: $imageD, picked: $picked)
                }
        }
    }
    private func touchAction(_ btn: String) {
        print(btn)
        //        ImagePicker(image: self.$image)
        self.picked = btn
        self.showCaptureImageView.toggle()
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
    @Binding var imageA: Image?
    @Binding var imageB: Image?
    @Binding var imageC: Image?
    @Binding var imageD: Image?
    @Binding var picked: String?
    
    //    var result: Bool = false
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(isShown: $isShown, imageA: $imageA, imageB: $imageB, imageC: $imageC, imageD: $imageD, picked: $picked)
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
