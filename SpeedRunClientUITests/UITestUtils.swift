//
//  UITestUtils.swift
//  SpeedRunClientUITests
//
//  Created by Alejandro Quibus on 20/01/2019.
//  Copyright © 2019 Alejandro Quibus. All rights reserved.
//

import XCTest

class UITestUtils {
    static func getUITestApplication()-> XCUIApplication{
        let application = XCUIApplication()
        application.launchArguments = [UITestStubKeys.UITestEnabled.rawValue]
        return application
    }
    
    static func getStubEnvironmentVariable(path:String,jsonName:String)-> [String:String] {
        return ["\(UITestStubKeys.stubJSON.rawValue)\(path)":jsonName]
    }
    
    static func getStubEnvironmentErrorCode(path:String,errorCode:Int)-> [String:String] {
        return ["\(UITestStubKeys.stubHTTPSatus.rawValue)\(path)":errorCode.description]
    }
}

extension XCTestCase {
    func waitForElementToAppear(_ element: XCUIElement) {
        let existsPredicate = NSPredicate(format: "exists == true")
        expectation(for: existsPredicate, evaluatedWith: element, handler: nil)
        waitForExpectations(timeout: defaultExpectationTimeOut, handler: nil)
    }
    
    func waitForElementToDisappear(_ element: XCUIElement) {
        let existsPredicate = NSPredicate(format: "exists == false")
        expectation(for: existsPredicate, evaluatedWith: element, handler: nil)
        waitForExpectations(timeout: defaultExpectationTimeOut, handler: nil)
    }
    
    func pullToRefresh(cell:XCUIElement) {
        let start = cell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        let finish = cell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 12))
        start.press(forDuration: 0, thenDragTo: finish)
    }
}


extension Dictionary {
    mutating func update(other:Dictionary) {
        for (key,value) in other {
            self.updateValue(value, forKey:key)
        }
    }
}
