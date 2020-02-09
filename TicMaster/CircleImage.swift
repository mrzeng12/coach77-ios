//
//  CircleImage.swift
//  TicMaster
//
//  Created by Chao Zeng on 2/2/20.
//  Copyright © 2020 livingston. All rights reserved.
//

import SwiftUI

struct CircleImage: View {
    var body: some View {
        Image("IMG_0012")
            .frame(height: 200.0)
        .clipShape(Circle())
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage()
    }
}
