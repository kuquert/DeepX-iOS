//
//  Owner.swift
//  DeepX
//
//  Created by Marcus Vinicius Kuquert on 27/05/17.
//  Copyright © 2017 Marcus Vinicius Kuquert. All rights reserved.
//

import Foundation
import ObjectMapper

class Owner: NSObject, Mappable {
    var login: String?
    var id: Int?
    var avatar_url: String?
    var gravatar_id: String?
    var url: String?
    var html_url: String?
    var followers_url: String?
    var following_url: String?
    var gists_url: String?
    var starred_url: String?
    var subscriptions_url: String?
    var organizations_url: String?
    var repos_url: String?
    var events_url: String?
    var received_events_url: String?
    var type: String?
    var site_admin: Bool?
    
    required init(map: Map) {
        //Required empty implementation
    }
    
    func mapping(map: Map) {
        self.login <- map["login"]
        self.id <- map["id"]
        self.avatar_url <- map["avatar_url"]
        self.gravatar_id <- map["gravatar_id"]
        self.url <- map["url"]
        self.html_url <- map["html_url"]
        self.followers_url <- map["followers_url"]
        self.following_url <- map["following_url"]
        self.gists_url <- map["gists_url"]
        self.starred_url <- map["starred_url"]
        self.subscriptions_url <- map["subscriptions_url"]
        self.organizations_url <- map["organizations_url"]
        self.repos_url <- map["repos_url"]
        self.events_url <- map["events_url"]
        self.received_events_url <- map["received_events_url"]
        self.type <- map["type"]
        self.site_admin <- map["site_admin"]
    }
}
