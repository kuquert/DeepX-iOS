//
//  Owner.swift
//  DeepX
//
//  Created by Marcus Vinicius Kuquert on 27/05/17.
//  Copyright © 2017 Marcus Vinicius Kuquert. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

//TODO Remover propriedades não utilizadas.
class Owner: Object, Mappable {
    
    dynamic var id: Int = 0
    dynamic var login: String?
    
    override public static func primaryKey() -> String? {
        return "id"
    }
    
    required convenience public init?(map: Map) {
        self.init()
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        self.login <- map["login"]
        self.id <- map["id"]
    }
}
