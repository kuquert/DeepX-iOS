//
//  RestUtil.swift
//  DeepX
//
//  Created by Marcus Vinicius Kuquert on 27/05/17.
//  Copyright © 2017 Marcus Vinicius Kuquert. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

enum CustomResponse<S, F> {
    case success(S)
    case failure(F)
}

typealias RepoLanguageModel = (repo: Repo, languages: [Language])

struct RestUtil {
    
    init() { }
    
    enum Route {
        case languages(user: String, repo: String)
        case repos(user: String)
    }
    
    static let manager: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10 // seconds
        configuration.requestCachePolicy = .reloadRevalidatingCacheData
        return Alamofire.SessionManager(configuration: configuration)
    }()
    
    private static func authenticatedURL(forRoute route: Route) -> String {
        let baseUrl = "https://api.github.com"
        let clientID = "cf6fc09d97d5383a9a72"
        let clientSecret = "bcafb4ff0dee03763d28c66974cf8fd336ad0fb9"
        
        switch route {
        case .languages(let user, let repo):
            return "\(baseUrl)/repos/\(user)/\(repo)/languages"
        case .repos(let user):
            return "\(baseUrl)/users/\(user)/repos?client_id=\(clientID)&client_secret=\(clientSecret)"
        }
    }
    
    static func languagesFor(user: String, completion: @escaping ((CustomResponse<[Repo], CustomAPIError>) -> Void)) {
        
        RestUtil.allReposForUser(user: user, completion: { resp in
            var i = 0
//            var repos = [Repo]()
            
            switch resp {
            case .success(let repos):
                
                for repo in repos {
                    RestUtil.languagesForRepo(repo: repo, ofUser: user, completion: { resp in
                        switch resp {
                        case .success(let languages):
                            i += 1
                            repo.languages.append(objectsIn: languages)
                            
                            if i == repos.count {
                                completion(CustomResponse<[Repo], CustomAPIError>.success(repos))
                            }
                        case .failure(let error):
                            completion(CustomResponse<[Repo], CustomAPIError>.failure(error))
                        }
                    })
                    
                }
            case .failure(let error):
                completion(CustomResponse<[Repo], CustomAPIError>.failure(error))
            }
        })
    }
    
    static func allReposForUser(user: String, completion: @escaping ((CustomResponse<[Repo], CustomAPIError>) -> Void)) {
        
        let finalURLString = RestUtil.authenticatedURL(forRoute: .repos(user: user))
        
        if let url = URL(string: finalURLString) {
            let newCompletion = { (response: DataResponse<[Repo]>) -> Void in
                
                switch response.result {
                case .success(let value):
                    completion(CustomResponse<[Repo], CustomAPIError>.success(value))
                    
                case .failure(let error):
                    var customError: CustomAPIError
                    
                    if let data = response.data,
                        let JSON = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
                        let errorObj = Mapper<CustomAPIError>().map(JSONObject: JSON) {
                        customError = errorObj
                    } else {
                        customError = CustomAPIError()
                        customError.rawError = error as NSError
                    }
                    
                    completion(CustomResponse<[Repo], CustomAPIError>.failure(customError))
                }
            }
            
            manager.request(url).responseArray(completionHandler: newCompletion)
        } else {
            let customError = CustomAPIError(JSON: ["message" : "InvalidUserURL"])
            completion(CustomResponse<[Repo], CustomAPIError>.failure(customError!))
        }
    }
    
    static func languagesForRepo(repo: Repo, ofUser user: String, completion: @escaping ((CustomResponse<[Language], CustomAPIError>) -> Void)) {
        
        //TODO Assert to make sure we have repo.name
        let finalURLString = RestUtil.authenticatedURL(forRoute: .languages(user: user, repo: repo.name!))
        let url = URL(string: finalURLString)!
        
        let newCompletion = { (response: DataResponse<Any>) -> Void in
            
            switch response.result {
            case .success(let value):
                var languages = [Language]()
                
                if let v = value as? Dictionary<String, Int> {
                    v.forEach({
                        let l = Language()
                        l.name = $0.key
                        l.linesCount = $0.value
                        l.ownerID = (repo.owner?.id)!
                        l.repoID = repo.id
                        l.id = "\(l.name)-\(repo.id)"
                        languages.append(l)
                    })
                }
                
                completion(CustomResponse<[Language], CustomAPIError>.success(languages))
                
            case .failure(let error):
                var customError: CustomAPIError
                
                if let data = response.data,
                    let JSON = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
                    let errorObj = Mapper<CustomAPIError>().map(JSONObject: JSON) {
                    customError = errorObj
                } else {
                    customError = CustomAPIError()
                    customError.rawError = error as NSError
                }
                
                completion(CustomResponse<[Language], CustomAPIError>.failure(customError))
            }
        }
        
        manager.request(url).responseJSON(completionHandler: newCompletion)
    }
}
