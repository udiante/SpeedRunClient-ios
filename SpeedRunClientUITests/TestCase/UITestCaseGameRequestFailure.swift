//
//  UITestCaseGameRequestFailure.swift
//  SpeedRunClientUITests
//
//  Created by Alejandro Quibus on 20/01/2019.
//  Copyright © 2019 Alejandro Quibus. All rights reserved.
//

import XCTest

class UITestCaseGameRequestFailure: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        let application = UITestUtils.getUITestApplication()
        application.launchEnvironment = UITestUtils.getStubEnvironmentErrorCode(path: TestEndPoints.games.rawValue, errorCode: 500)
        application.launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testGameListFails(){
        //XCUIApplication().activityIndicators["In progress"].exists

        
//        XCUIApplication().tables.staticTexts["There's a problem with your request.\n\nTry again later."].tap()
        
        let tablesQuery = XCUIApplication().tables
        tablesQuery.staticTexts["There's a problem with your request.\n\nTry again later."].tap()
        //tablesQuery.buttons["Retry"].tap()
        
        
        // GIVEN: - We have a invalid /games response
        
        // When: - The download finishes
        // Then: - A cell with the error and a retry button should be visible
        waitForElementToAppear(tablesQuery.staticTexts["There's a problem with your request.\n\nTry again later."])
        XCTAssertTrue(tablesQuery.buttons["Retry"].exists)
        //waitForExpectations(timeout: defaultExpectationTimeOut, handler:  nil)
    }
    
    func testGameListFailsRetryButton(){
        // GIVEN: - We have a invalid /games response
        let tablesQuery = XCUIApplication().tables

        // When: - The download finishes and the Retry button is pressed
        waitForElementToAppear(tablesQuery.staticTexts["There's a problem with your request.\n\nTry again later."])
        tablesQuery.buttons["Retry"].tap()

        // Then: - The UI should reload and the error message is visible
        waitForElementToAppear(tablesQuery.staticTexts["There's a problem with your request.\n\nTry again later."])

    }


}
