//
//  ContentView.swift
//  TicMaster
//
//  Created by Chao Zeng on 2/2/20.
//  Copyright © 2020 livingston. All rights reserved.
//

import SwiftUI

struct ContentView: View {
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
                    Image("ticket")
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
            
        
        }
    }
    private func touchAction(_ btn: String) {
      print(btn)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
