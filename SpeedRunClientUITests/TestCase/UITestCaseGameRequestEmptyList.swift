//
//  UITestCaseGameRequestEmptyList.swift
//  SpeedRunClientUITests
//
//  Created by Alejandro Quibus on 20/01/2019.
//  Copyright © 2019 Alejandro Quibus. All rights reserved.
//

import XCTest

class UITestCaseGameRequestEmptyList: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        let application = UITestUtils.getUITestApplication()
        application.launchEnvironment = UITestUtils.getStubEnvironmentVariable(path: TestEndPoints.games.rawValue, jsonName: "gamesListEmpty")
        application.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGameListEmptySucceed(){
        // GIVEN: - We have a valid /games response without Games
        
        let tablesQuery = XCUIApplication().tables
        
        // When: - The download finishes Then: - "No games founds" is visible
        waitForElementToAppear(tablesQuery.staticTexts["No games founds"])
        
        
    }

}
