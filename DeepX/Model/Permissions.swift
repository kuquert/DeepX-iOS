//
//  Permissions.swift
//  DeepX
//
//  Created by Marcus Vinicius Kuquert on 27/05/17.
//  Copyright © 2017 Marcus Vinicius Kuquert. All rights reserved.
//

import Foundation
import ObjectMapper

class Permissions {
    var admin: Bool?
    var push: Bool?
    var pull: Bool?
    
    required init?(map: Map) {
        //Requiered empty init
    }
    
    func mapping(map: Map) {
        self.admin <- map["admin"]
        self.push <- map["push"]
        self.pull <- map["pull"]
    }
}
