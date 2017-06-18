//
//  DeepXTests.swift
//  DeepXTests
//
//  Created by Marcus Vinicius Kuquert on 27/05/17.
//  Copyright © 2017 Marcus Vinicius Kuquert. All rights reserved.
//

import XCTest
import RealmSwift

@testable import DeepX

class DeepXTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testStoryboardInstances(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController
        let detailvc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        
        let _ = vc?.view // force loading subviews and setting outlets
        let _ = detailvc?.view
        
        vc?.viewDidLoad()
        detailvc?.viewDidLoad()
        
        XCTAssertNotNil(vc)
        XCTAssertNotNil(detailvc)
    }
    
    func testLanguagesCount() {
        let user = "BearchInc"
        let promise = expectation(description: "saveAndFetchReposLocally")
        
        RealmUtil.saveReposLocally(user: user) { (response) in
            switch response {
            case .success( _):
                
                let lang = RealmUtil.fetchReposLocally(user: user)
                
                for l in lang! {
                    print("\(l.key) - \(l.value.linesCount)")
                }
                
                promise.fulfill()
                
            case .failure(let error):
                XCTFail(error.message ?? "nil")
            }
        }
        waitForExpectations(timeout: 15, handler: nil)
    }
    
    func testExample() {
        
        let user = "BearchInc"
        let promise = expectation(description: "fetchAllRepos")
        let promise2 = expectation(description: "fetchLanguage")
        var count = 0
        
        RestUtil.allReposForUser(user: user) { response in
            switch response {
                case .success(let repos):
                    promise.fulfill()
                    for repo in repos {
                        RestUtil.languagesForRepo(repo: repo, ofUser: user) { resp in
                            switch resp {
                            case .success( _):
                                count += 1
                                if count == repos.count {
                                    promise2.fulfill()
                                }
                                break
                            case .failure(let error):
                                XCTFail(error.localizedDescription)
                                break
                            }
                        }
                    }
                    break
                case  .failure(let error):
                    XCTFail("Fail to comunicate with remote: \(error.localizedDescription)")
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
