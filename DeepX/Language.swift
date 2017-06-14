//
//  Language.swift
//  DeepX
//
//  Created by Marcus Vinicius Kuquert on 11/06/17.
//  Copyright © 2017 Marcus Vinicius Kuquert. All rights reserved.
//

import Foundation
import RealmSwift

class Language: Object {
    
    dynamic var id: String = "" //it will be ownerID + name
    dynamic var name: String = ""
    dynamic var ownerID = -1
    dynamic var repoID = -1 //Maybe can be deleted
    dynamic var linesCount = -1
    
    let repos = LinkingObjects(fromType: Repo.self, property: "languages")
    
    override public static func primaryKey() -> String? {
        return "id"
    }
}
