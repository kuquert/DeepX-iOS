//
//  Repo.swift
//  DeepX
//
//  Created by Marcus Vinicius Kuquert on 27/05/17.
//  Copyright © 2017 Marcus Vinicius Kuquert. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class Repo: Object, Mappable {
    
    dynamic var id: Int = -1
    dynamic var name: String?
    dynamic var full_name: String?
    dynamic var owner: Owner?
    dynamic var url: String?
    dynamic var open_issues: Int = -1
    dynamic var html_url: String?
    dynamic var language: String?
    dynamic var created_at: Date?
    dynamic var updated_at: Date?
    
    let languages = List<Language>()
    
    override public static func primaryKey() -> String? {
        return "id"
    }
    
    required convenience public init?(map: Map) {
        self.init()
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.name <- map["name"]
        self.full_name <- map["full_name"]
        self.owner <- map["owner"]
        self.url <- map["url"]
        self.open_issues <- map["open_issues"]
        self.html_url <- map["html_url"]
        self.language <- map["language"]
        self.created_at <- (map["created_at"], ISO8601DateTransform())
        self.updated_at <- (map["updated_at"], ISO8601DateTransform())
    }
}
