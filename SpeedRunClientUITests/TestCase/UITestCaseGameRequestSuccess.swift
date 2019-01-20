//
//  SpeedRunClientUITests.swift
//  SpeedRunClientUITests
//
//  Created by Alejandro Quibus on 19/01/2019.
//  Copyright © 2019 Alejandro Quibus. All rights reserved.
//

import XCTest

class UITestCaseGameRequestSuccess: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        let application = UITestUtils.getUITestApplication()
        application.launchEnvironment = UITestUtils.getStubEnvironmentVariable(path: TestEndPoints.games.rawValue, jsonName: "games") //["UITest_URL/api/v1/games":"gamesListEmpty"]
        application.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func disabled_testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testGameListSucceed(){
        // GIVEN: - We have a valid /games response
        
        let tablesQuery = XCUIApplication().tables
        
        // When: - The download finishes
        waitForElementToAppear(tablesQuery.staticTexts["! Fishy !"])
        
        // Then: - The first games items should be visible appear
        XCTAssertTrue(tablesQuery.staticTexts["&meow; (Meow)"].exists)
        XCTAssertTrue(tablesQuery.staticTexts["'Allo 'Allo! Cartoon Fun!"].exists)
        
    }
    
    
    func testGamePullToRefresh(){
        // GIVEN: - We have a valid /games response
        
        let tablesQuery = XCUIApplication().tables
        
        // When: - The download finishes and we pull to refresh
        let cell = tablesQuery.staticTexts["! Fishy !"]
        waitForElementToAppear(cell)
        
        // Then: - A refresh is displayed
        pullToRefresh(cell: cell)

        waitForElementToAppear(tablesQuery.staticTexts["! Fishy !"])
        
    }


}
