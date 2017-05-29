//
//  RestUtil.swift
//  DeepX
//
//  Created by Marcus Vinicius Kuquert on 27/05/17.
//  Copyright © 2017 Marcus Vinicius Kuquert. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
typealias dict = [String:String]

struct RestUtil {
    
    init() { }
    
    static let baseUrl = "https://api.github.com"
    
    static func allReposForUser(user: String, response: @escaping (([Repo]) -> ())) {
        
        let path = "/users/\(user)/repos"
        
        Alamofire.request(baseUrl + path).responseArray { (resp: DataResponse<[Repo]>) in
            response(resp.result.value!)
        }
    }
    
    static func languagesForRepo(repo: Repo, ofUser user: String, response: @escaping ((dict: Dictionary<String, Int>, repos: Repo)) -> ()) {
        
        //TODO Assert to make sure we have repo.name
        let path = "/repos/\(user)/\(repo.name!)/languages"
        
        Alamofire.request(baseUrl + path).responseJSON { resp in
            
            switch resp.result {
            case .success(let json):
                
                response((json as! Dictionary<String, Int>, repo))
                
            case .failure(let error):
                print("Request failed with error: \(error)")
            }
            
        }
    }
}
