//
//  GameListViewModel.swift
//  SpeedRunClientTests
//
//  Created by Alejandro Quibus on 20/01/2019.
//  Copyright © 2019 Alejandro Quibus. All rights reserved.
//

import XCTest
@testable import SpeedRunClient
import Mockingjay

class GameListViewModel: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGamesDownload(){
        let gamesListViewModel = GamesListViewModel()
        let expectationStartDownload = expectation(description: "The download should start")
        let expectationEndDownlodad = expectation(description: "The download should end")
        
        // Given - We mock a valid "/games" response 
        stub(uri("/api/v1/games"), jsonData(TestUtils.getJSON(withName: "gamesList")))
        
        let networkDelegate = TestNetworkDelegate(downloadStartedHandler: {
            expectationStartDownload.fulfill()
        }, downloadEndedHandler: {
            // Then: - The cellsVM should contain only Games cells
            XCTAssertGreaterThan(gamesListViewModel.cellsVM.count, 0)
            gamesListViewModel.cellsVM.forEach({ (cellVM) in
                XCTAssertTrue(cellVM is GamesListGameCellViewModel)
            })
            expectationEndDownlodad.fulfill()
        })
        

        // When - We fetch the games
        gamesListViewModel.fetchGames(delegate: networkDelegate)
        
        waitForExpectations(timeout: defaultExpectationTimeOut, handler: nil)
    }
    
    func testGamesDownloadFails(){
        let gamesListViewModel = GamesListViewModel()
        let expectationStartDownload = expectation(description: "The download should start")
        let expectationEndDownlodad = expectation(description: "The download should end")
        
        // Given - We mock a 500 error in "/games" response
        stub(uri("/api/v1/games"), http(500))
        
        let networkDelegate = TestNetworkDelegate(downloadStartedHandler: {
            expectationStartDownload.fulfill()
        }, downloadEndedHandler: {
            // Then: - The cellsVM should only contain an error message
            XCTAssertEqual(gamesListViewModel.getNumberOfCells(), 1)
            XCTAssertTrue(gamesListViewModel.cellsVM.first is GamesListErrorCellViewModel)
            expectationEndDownlodad.fulfill()
        })
        
        
        // When - We fetch the games
        gamesListViewModel.fetchGames(delegate: networkDelegate)
        
        waitForExpectations(timeout: defaultExpectationTimeOut, handler: nil)
    }
    
    func testGamesDownloadEmptyList(){
        let gamesListViewModel = GamesListViewModel()
        let expectationStartDownload = expectation(description: "The download should start")
        let expectationEndDownlodad = expectation(description: "The download should end")
        
        // Given - We mock a "/games" response that doesn't have any data
        stub(uri("/api/v1/games"), jsonData(TestUtils.getJSON(withName: "gamesListEmpty")))

        let networkDelegate = TestNetworkDelegate(downloadStartedHandler: {
            expectationStartDownload.fulfill()
        }, downloadEndedHandler: {
            // Then: - The cellsVM should only contain an empty state
            XCTAssertEqual(gamesListViewModel.getNumberOfCells(), 1)
            XCTAssertTrue(gamesListViewModel.cellsVM.first is GamesListEmptyStateCellViewModel)
            expectationEndDownlodad.fulfill()
        })
        
        
        // When - We fetch the games
        gamesListViewModel.fetchGames(delegate: networkDelegate)
        
        waitForExpectations(timeout: defaultExpectationTimeOut, handler: nil)
    }

    func testGamesAreReset(){
        let gamesListViewModel = GamesListViewModel()
        let expectationStartDownload = expectation(description: "The download should start")
        let expectationEndDownlodad = expectation(description: "The download should end")
        
        // Given - We mock a valid "/games" response
        stub(uri("/api/v1/games"), jsonData(TestUtils.getJSON(withName: "gamesList")))
        
        let networkDelegate = TestNetworkDelegate(downloadStartedHandler: {
            expectationStartDownload.fulfill()
        }, downloadEndedHandler: {
        
            // When - We the games are fetched and we reset the viewModel

            XCTAssertGreaterThan(gamesListViewModel.cellsVM.count, 0)
            gamesListViewModel.cellsVM.forEach({ (cellVM) in
                XCTAssertTrue(cellVM is GamesListGameCellViewModel)
            })
        
            gamesListViewModel.resetGamesList()
            // Then: - The cellsVM should be empty
            XCTAssertEqual(gamesListViewModel.getNumberOfCells(), 0)
            
            expectationEndDownlodad.fulfill()
        })
        
        
        gamesListViewModel.fetchGames(delegate: networkDelegate)
        
        waitForExpectations(timeout: defaultExpectationTimeOut, handler: nil)
    }
    
    func testGamesCellsVMGetter(){
        let gamesListViewModel = GamesListViewModel()
        let expectationStartDownload = expectation(description: "The download should start")
        let expectationEndDownlodad = expectation(description: "The download should end")
        
        // Given - We mock a valid "/games" response
        stub(uri("/api/v1/games"), jsonData(TestUtils.getJSON(withName: "gamesList")))
        
        let networkDelegate = TestNetworkDelegate(downloadStartedHandler: {
            expectationStartDownload.fulfill()
        }, downloadEndedHandler: {
            
            XCTAssertGreaterThan(gamesListViewModel.cellsVM.count, 0)
            gamesListViewModel.cellsVM.forEach({ (cellVM) in
                XCTAssertTrue(cellVM is GamesListGameCellViewModel)
            })
            
            // When - We acces an invalid cellVM index a nil is retreived
            XCTAssertNil(gamesListViewModel.getCell(atIndex: -1))

            // When - We acces a valid cellVM index a cellVM is retreived
            XCTAssertNotNil(gamesListViewModel.getCell(atIndex: 1))
            
            expectationEndDownlodad.fulfill()
        })
        
        
        gamesListViewModel.fetchGames(delegate: networkDelegate)
        
        waitForExpectations(timeout: defaultExpectationTimeOut, handler: nil)
    }
}
