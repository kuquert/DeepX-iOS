//
//  RealmUtil.swift
//  DeepX
//
//  Created by Marcus Vinicius Kuquert on 12/06/17.
//  Copyright © 2017 Marcus Vinicius Kuquert. All rights reserved.
//

import Foundation
import RealmSwift

class RealmUtil {
    
    static func saveReposLocally(user: String, completion: @escaping ((CustomResponse<[Repo], CustomAPIError>) -> Void)) {
        
        RestUtil.languagesFor(user: user) { response in
            switch response {
            case .success(let repos):
                do {
                    let realm = try Realm()
                    try realm.write {
                        for repo in repos {
                            realm.add(repo, update: true)
                            //Could have some problem here with duplicated language references
//                            rl.repo.languages.append(objectsIn: rl.languages)
//                            realm.add(rl.repo, update: true)
                        }
                    }
                    completion(CustomResponse<[Repo], CustomAPIError>.success(repos))
                } catch let error {
                    print(error)
                    
                }
            case .failure(let error):
                completion(CustomResponse<[Repo], CustomAPIError>.failure(error))
            }
        }
    }
    
    static func fetchReposLocally(user: String) -> AgregatedLanguages? {
        do {
            let realm = try Realm()
            if let owner = realm.objects(Owner.self).filter("login BEGINSWITH[c] '\(user)'").first {
                return fetchReposLocally(userID: owner.id)
            } else {
                return nil
            }
            //should trow and error
        } catch let error {
            print(error)
        }
        return nil
    }
    
    static func fetchReposLocally(userID: Int) -> AgregatedLanguages? {
        do {
            let realm = try Realm()
            var languages = AgregatedLanguages()
            let repos = realm.objects(Repo.self).filter("owner.id = \(userID)")
            
            for repo in repos {
                for l in  repo.languages {
                    let value = l.linesCount + (languages[l.name]?.linesCount ?? 0)
                    let rs = [repo] + (languages[l.name]?.repos ?? [Repo]())
                    languages[l.name] = (value, rs)
                }
            }
            return languages
        } catch let error {
            //Should threat error here
            print(error)
        }
        
        return nil
    }
}
