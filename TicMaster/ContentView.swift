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
    @State var showCaptureImageView: Bool = false
    
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
                            Image("add")
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
                            Image("ticket")
                                .renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                        
                        Spacer()
                        Button(action: {
                            self.touchAction("D")
                            
                        }) {
                            Image("no-ticket")
                                .renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                        
                    }
                    Spacer()
                }.padding()
//                .sheet(isPresented: true, onDismiss: nil, content: ImagePicker(image: self.$image))
                if (showCaptureImageView) {
                  CaptureImageView(isShown: $showCaptureImageView, image: $imageA)
                }
        }
    }
    private func touchAction(_ btn: String) {
        print(btn)
        //        ImagePicker(image: self.$image)
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
  @Binding var image: Image?
  
  func makeCoordinator() -> Coordinator {
    return Coordinator(isShown: $isShown, image: $image)
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
