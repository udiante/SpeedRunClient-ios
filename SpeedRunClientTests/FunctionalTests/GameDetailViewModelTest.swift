//
//  GameDetailViewModelTest.swift
//  SpeedRunClientTests
//
//  Created by Alejandro Quibus on 20/01/2019.
//  Copyright © 2019 Alejandro Quibus. All rights reserved.
//

import XCTest
@testable import SpeedRunClient
import Mockingjay

class GameDetailViewModelTest: XCTestCase {

    
    override var defaultExpectationTimeOut: Double {
        return 8
    }
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    let gamesURL = TestEndPoints.games.rawValue
    let runsURL = TestEndPoints.runs.rawValue
    let userURL = TestEndPoints.users.rawValue
    
    func testGameDetailSuccess(){
        let gamesListViewModel = GamesListViewModel()
        
        let preconditionExpectation = expectation(description: "We must have a valid game to start the test")
        let expectationStartDownload = expectation(description: "The download should start")
        let expectationEndDownlodad = expectation(description: "The download should end")
        
        // Given - We mock a valid "/games", "/runs" and "users" response
        stub(uri(gamesURL), jsonData(TestUtils.getJSON(withName: "gamesList")))
        stub(uri(runsURL), jsonData(TestUtils.getJSON(withName: "runsResponse")))
        stub(TestUtils.partUri(userURL), jsonData(TestUtils.getJSON(withName: "usersResponse")))
        
        
        var gameDetailViewModel: GameDetailViewModel?
        
        let detailGameDelegate = TestNetworkDelegate(downloadStartedHandler: {
            expectationStartDownload.fulfill()
        }, downloadEndedHandler: {
            //Then: - All the info is displayed
            guard let gameDetailViewModel = gameDetailViewModel else {return}
            XCTAssertEqual(gameDetailViewModel.getNumberOfCells(), 4)
            XCTAssertNotNil(gameDetailViewModel.getCell(atIndex: 0) as? GamesListGameCellViewModel)
            XCTAssertNotNil(gameDetailViewModel.getCell(atIndex: 1) as? GameDetailButtonCellViewModel)
            XCTAssertNotNil(gameDetailViewModel.getCell(atIndex: 2) as? GameDetailInfoCellViewModel)
            XCTAssertNotNil(gameDetailViewModel.getCell(atIndex: 3) as? GameDetailInfoCellViewModel)

            expectationEndDownlodad.fulfill()
        })
        
        let preconditionDownload = TestNetworkDelegate(downloadStartedHandler: {
            // Not used
        }) {
            if let cellGameDataVM = gamesListViewModel.getCell(atIndex: 0) as? GamesListGameCellViewModel {
                gameDetailViewModel = GameDetailViewModel(gameData: cellGameDataVM.gameModel)
                // When: - we fetch the game Detail
                gameDetailViewModel?.fetchGameDetails(delegate: detailGameDelegate)
            }
            preconditionExpectation.fulfill()
        }
        
        
        gamesListViewModel.fetchGames(delegate: preconditionDownload)
        
        waitForExpectations(timeout: defaultExpectationTimeOut, handler: nil)
    }
    
    func testGameDetailRunsRequestFails(){
        let gamesListViewModel = GamesListViewModel()
        
        let preconditionExpectation = expectation(description: "We must have a valid game to start the test")
        let expectationStartDownload = expectation(description: "The download should start")
        let expectationEndDownlodad = expectation(description: "The download should end")
        
        // Given - We mock a valid "/games" and invalid "/runs" and valid "users" response
        stub(uri(gamesURL), jsonData(TestUtils.getJSON(withName: "gamesList")))
        stub(uri(runsURL), http(500))
        stub(TestUtils.partUri(userURL), jsonData(TestUtils.getJSON(withName: "usersResponse")))

        
        var gameDetailViewModel: GameDetailViewModel?
        
        let detailGameDelegate = TestNetworkDelegate(downloadStartedHandler: {
            expectationStartDownload.fulfill()
        }, downloadEndedHandler: {
            guard let gameDetailViewModel = gameDetailViewModel else {return}
            //Then: - Only the game info is displayed
            XCTAssertEqual(gameDetailViewModel.getNumberOfCells(), 1)
            XCTAssertNotNil(gameDetailViewModel.getCell(atIndex: 0) as? GamesListGameCellViewModel)
        
            expectationEndDownlodad.fulfill()
        })
        
        let preconditionDownload = TestNetworkDelegate(downloadStartedHandler: {
            // Not used
        }) {
            if let cellGameDataVM = gamesListViewModel.getCell(atIndex: 0) as? GamesListGameCellViewModel {
                gameDetailViewModel = GameDetailViewModel(gameData: cellGameDataVM.gameModel)
                // When: - we fetch the game Detail
                gameDetailViewModel?.fetchGameDetails(delegate: detailGameDelegate)
            }
            preconditionExpectation.fulfill()
        }
        
        
        gamesListViewModel.fetchGames(delegate: preconditionDownload)
        
        waitForExpectations(timeout: defaultExpectationTimeOut, handler: nil)
    }
    
    func testGameDetailUserRequestFails(){
        let gamesListViewModel = GamesListViewModel()
        
        let preconditionExpectation = expectation(description: "We must have a valid game to start the test")
        let expectationStartDownload = expectation(description: "The download should start")
        let expectationEndDownlodad = expectation(description: "The download should end")
        
        // Given - We mock a valid "/games", "/runs" and invalid valid "users" response
        stub(uri(gamesURL), jsonData(TestUtils.getJSON(withName: "gamesList")))
        stub(uri(runsURL), jsonData(TestUtils.getJSON(withName: "runsResponse")))
        stub(TestUtils.partUri(userURL), http(500))
        
        
        var gameDetailViewModel: GameDetailViewModel?
        
        let detailGameDelegate = TestNetworkDelegate(downloadStartedHandler: {
            expectationStartDownload.fulfill()
        }, downloadEndedHandler: {
            guard let gameDetailViewModel = gameDetailViewModel else {return}
            //Then: - Only the game and run info is displayed
            XCTAssertEqual(gameDetailViewModel.getNumberOfCells(), 3)
            XCTAssertNotNil(gameDetailViewModel.getCell(atIndex: 0) as? GamesListGameCellViewModel)
            XCTAssertNotNil(gameDetailViewModel.getCell(atIndex: 1) as? GameDetailButtonCellViewModel)
            XCTAssertNotNil(gameDetailViewModel.getCell(atIndex: 2) as? GameDetailInfoCellViewModel)
            
            expectationEndDownlodad.fulfill()
        })
        
        let preconditionDownload = TestNetworkDelegate(downloadStartedHandler: {
            // Not used
        }) {
            if let cellGameDataVM = gamesListViewModel.getCell(atIndex: 0) as? GamesListGameCellViewModel {
                gameDetailViewModel = GameDetailViewModel(gameData: cellGameDataVM.gameModel)
                // When: - we fetch the game Detail
                gameDetailViewModel?.fetchGameDetails(delegate: detailGameDelegate)
            }
            preconditionExpectation.fulfill()
        }
        
        
        gamesListViewModel.fetchGames(delegate: preconditionDownload)
        
        waitForExpectations(timeout: defaultExpectationTimeOut, handler: nil)
    }
    
    func testGameDetailWithoutURI(){
        let gamesListViewModel = GamesListViewModel()
        
        let preconditionExpectation = expectation(description: "We must have a valid game to start the test")
        let expectationStartDownload = expectation(description: "The download should start")
        let expectationEndDownlodad = expectation(description: "The download should end")
        
        // Given - We mock a "/games" response without the "run" link
        stub(uri(gamesURL), jsonData(TestUtils.getJSON(withName: "gamesInvalidLinks")))
        stub(uri(runsURL), jsonData(TestUtils.getJSON(withName: "runsResponse")))
        stub(TestUtils.partUri(userURL), jsonData(TestUtils.getJSON(withName: "usersResponse")))
        
        
        var gameDetailViewModel: GameDetailViewModel?
        
        let detailGameDelegate = TestNetworkDelegate(downloadStartedHandler: {
            expectationStartDownload.fulfill()
        }, downloadEndedHandler: {
            //Then: - Only the game info is displayed
            guard let gameDetailViewModel = gameDetailViewModel else {return}
            XCTAssertEqual(gameDetailViewModel.getNumberOfCells(), 1)
            XCTAssertNotNil(gameDetailViewModel.getCell(atIndex: 0) as? GamesListGameCellViewModel)
            
            expectationEndDownlodad.fulfill()
        })
        
        let preconditionDownload = TestNetworkDelegate(downloadStartedHandler: {
            // No used
        }) {
            if let cellGameDataVM = gamesListViewModel.getCell(atIndex: 0) as? GamesListGameCellViewModel {
                gameDetailViewModel = GameDetailViewModel(gameData: cellGameDataVM.gameModel)
                // When: - we fetch the game Detail
                gameDetailViewModel?.fetchGameDetails(delegate: detailGameDelegate)
            }
            preconditionExpectation.fulfill()
        }
        
        
        gamesListViewModel.fetchGames(delegate: preconditionDownload)
        
        waitForExpectations(timeout: defaultExpectationTimeOut, handler: nil)
    }
}
