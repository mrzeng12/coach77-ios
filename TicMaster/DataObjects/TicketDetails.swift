//
//  TicketDetails.swift
//  TicMaster
//
//  Created by Zeng, Charles on 2/13/20.
//  Copyright © 2020 livingston. All rights reserved.
//

import Foundation
class TicketDetail: NSObject, NSCoding {
    
    override init() {
        self.count = -1;
        self.image = "";
    }
    
    init(count:Int, image: String) {
        self.count = count;
        self.image = image;
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.count, forKey: "count")
        coder.encode(self.image, forKey: "image")
    }
    
    required init?(coder: NSCoder) {
        self.count = coder.decodeInteger(forKey: "count")
        self.image = coder.decodeObject(forKey: "image") as! String;
        
    }
    
    var count: Int = -1
    var image: String = ""
}
