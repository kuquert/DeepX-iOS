//
//  CustomAPIError.swift
//  DeepX
//
//  Created by Marcus Vinicius Kuquert on 13/06/17.
//  Copyright © 2017 Marcus Vinicius Kuquert. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper

struct CustomAPIError: Error, Mappable {
    var rawError: NSError?
    var message: String?
    var documentation_url: [String] = []
    
    init() {}
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        message <- map["message"]
        documentation_url <- map["documentation_url"]
    }
}
