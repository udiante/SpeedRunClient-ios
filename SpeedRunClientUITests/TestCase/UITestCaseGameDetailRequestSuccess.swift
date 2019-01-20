//
//  UITestCaseGameDetailRequestSuccess.swift
//  SpeedRunClientUITests
//
//  Created by Alejandro Quibus on 20/01/2019.
//  Copyright © 2019 Alejandro Quibus. All rights reserved.
//

import XCTest

class UITestCaseGameDetailRequestSuccess: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        let gamesStub = UITestUtils.getStubEnvironmentVariable(path: TestEndPoints.games.rawValue, jsonName: "gamesList")
        let runsStub = UITestUtils.getStubEnvironmentVariable(path: TestEndPoints.runs.rawValue, jsonName: "runsResponse")
        let usersStub = UITestUtils.getStubEnvironmentVariable(path: TestEndPoints.users.rawValue, jsonName: "usersResponse")
        
        var mergeDictionary:[String:String] = [:]
        mergeDictionary.update(other: gamesStub)
        mergeDictionary.update(other: runsStub)
        mergeDictionary.update(other: usersStub)
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        let application = UITestUtils.getUITestApplication()
        application.launchEnvironment = mergeDictionary
        application.launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGoToDetail(){
        
        let tablesQuery = XCUIApplication().tables
        let fishyStaticText = tablesQuery.staticTexts["! Fishy !"]
        waitForElementToAppear(fishyStaticText)
        
        fishyStaticText.tap()

        waitForElementToAppear(XCUIApplication().navigationBars["GameRun Detail"])
        
        XCTAssert(tablesQuery.staticTexts["! Fishy !"].exists)
        XCTAssert(tablesQuery.staticTexts["7 minutes 15 seconds"].exists)
        XCTAssert(tablesQuery.staticTexts["f1"].exists)
        XCTAssert(tablesQuery.staticTexts["Show video"].exists)
        
    }
    
    func testGoToDetailVideo(){
        
        let tablesQuery = XCUIApplication().tables
        let fishyStaticText = tablesQuery.staticTexts["! Fishy !"]
        waitForElementToAppear(fishyStaticText)
        
        fishyStaticText.tap()
        
        waitForElementToAppear(XCUIApplication().navigationBars["GameRun Detail"])
        
        XCTAssert(tablesQuery.staticTexts["! Fishy !"].exists)
        XCTAssert(tablesQuery.staticTexts["7 minutes 15 seconds"].exists)
        XCTAssert(tablesQuery.staticTexts["f1"].exists)
        XCTAssert(tablesQuery.staticTexts["Show video"].exists)
        
        tablesQuery.staticTexts["Show video"].tap()
        
        let safari = XCUIApplication(bundleIdentifier: "com.apple.mobilesafari")
        safari.wait(for: .runningForeground, timeout: 20)
        XCUIApplication().activate()
        
        waitForElementToAppear(XCUIApplication().navigationBars["GameRun Detail"])
    }

}
