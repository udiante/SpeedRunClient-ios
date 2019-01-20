//
//  SpeedRunDataSourceTest.swift
//  SpeedRunClientTests
//
//  Created by Alejandro Quibus on 20/01/2019.
//  Copyright © 2019 Alejandro Quibus. All rights reserved.
//

import XCTest
@testable import SpeedRunClient
import Mockingjay

class SpeedRunDataSourceTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGamesListDownloadSucceed(){
        let expect = expectation(description: "The download should succeed")
        
        // Given - We mock a valid "/games" response
        stub(uri("/api/v1/games"), jsonData(TestUtils.getJSON(withName: "gamesList")))

        // When - Whe we fetch the first page of games
        SpeedRunDataSource.getGames { (error, gamesResponse) in
            // Then - The completion callback has an instance with the stub data and no errors
            XCTAssertNil(error)
            XCTAssertNotNil(gamesResponse?.data)
            expect.fulfill()
        }
        
        waitForExpectations(timeout: defaultExpectationTimeOut, handler: nil)
    }
    
    func testGamesListDownloadError(){
        let expect = expectation(description: "The download should fail")
        
        // Given - We mock a server error
        stub(uri( "/api/v1/games"), http(500))
        
        // When - Whe we fetch the first page of games
        SpeedRunDataSource.getGames { (error, gamesResponse) in
            // Then - The completion callback has an error and and empty response data
            XCTAssertNotNil(error)
            XCTAssertNil(gamesResponse?.data)
            expect.fulfill()
        }
        
        waitForExpectations(timeout: defaultExpectationTimeOut, handler: nil)
    }
}
