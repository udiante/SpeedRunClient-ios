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
    
    
    let gamesURL = TestEndPoints.games.rawValue
    let runsURL = TestEndPoints.runs.rawValue
    let userURL = TestEndPoints.users.rawValue


    func testGamesListDownloadSucceed(){
        let expect = expectation(description: "The download should succeed")
        
        // Given - We mock a valid "/games" response
        stub(uri(gamesURL), jsonData(TestUtils.getJSON(withName: "gamesList")))

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
        stub(uri(gamesURL), http(500))
        
        // When - Whe we fetch the first page of games
        SpeedRunDataSource.getGames { (error, gamesResponse) in
            // Then - The completion callback has an error and and empty response data
            XCTAssertNotNil(error)
            XCTAssertNil(gamesResponse?.data)
            expect.fulfill()
        }
        
        waitForExpectations(timeout: defaultExpectationTimeOut, handler: nil)
    }
    
    let testRunsURI = "https://www.speedrun.com/api/v1/runs?game=46wxo91r"
    func testRunsDownloadSucceed(){
        let expect = expectation(description: "The download should succeed")
        
        // Given - We mock a valid "/runs" response
        stub(uri(runsURL), jsonData(TestUtils.getJSON(withName: "runsResponse")))
        
        // When - Whe we fetch the runs
        SpeedRunDataSource.getGameRuns(gameRunsURI: testRunsURI) { (error, runsResponse) in
            // Then - The completion callback has an instance with the stub data and no errors
            XCTAssertNil(error)
            XCTAssertNotNil(runsResponse?.data?.first?.times)
            expect.fulfill()
        }
        
        waitForExpectations(timeout: defaultExpectationTimeOut, handler: nil)
    }
    
    func testRunsListDownloadError(){
        let expect = expectation(description: "The download should fail")
        
        // Given - We mock a server error
        stub(uri(runsURL), http(500))
        
        // When - Whe we fetch the runs
        SpeedRunDataSource.getGameRuns(gameRunsURI: testRunsURI) { (error, runsResponse) in
            // Then - The completion callback has an error and and empty response data
            XCTAssertNotNil(error)
            XCTAssertNil(runsResponse?.data?.first?.times)
            expect.fulfill()
        }
        
        waitForExpectations(timeout: defaultExpectationTimeOut, handler: nil)
    }
    
    let testUserURI = "https://www.speedrun.com/api/v1/users/mkj9nw84"
    func testUserDownloadSucceed(){
        let expect = expectation(description: "The download should succeed")
        
        // Given - We mock a valid "/runs" response
        stub(TestUtils.partUri(userURL), jsonData(TestUtils.getJSON(withName: "usersResponse")))
        
        // When - Whe we fetch the user detial
        SpeedRunDataSource.getUserDetail(userURI: testUserURI) { (error, runsResponse) in
            // Then - The completion callback has an instance with the stub data and no errors
            XCTAssertNil(error)
            XCTAssertNotNil(runsResponse?.data?.names?.international)
            expect.fulfill()
        }
        
        waitForExpectations(timeout: defaultExpectationTimeOut, handler: nil)
    }
    
    func testUserListDownloadError(){
        let expect = expectation(description: "The download should fail")
        
        // Given - We mock a server error
        stub(TestUtils.partUri(userURL), http(500))
        
        // When - Whe we fetch the user details
        SpeedRunDataSource.getUserDetail(userURI: testUserURI) { (error, runsResponse) in
            // Then - The completion callback has an error and and empty response data
            XCTAssertNotNil(error)
            XCTAssertNil(runsResponse?.data?.names?.international)
            expect.fulfill()
        }
        
        waitForExpectations(timeout: defaultExpectationTimeOut, handler: nil)
    }
}
