//
//  TestUtils.swift
//  SpeedRunClientTests
//
//  Created by Alejandro Quibus on 19/01/2019.
//  Copyright © 2019 Alejandro Quibus. All rights reserved.
//

import Foundation
import XCTest

class TestUtils {
    static func getJSON(withName name:String)->Data {
        let url = Bundle(for: TestUtils.self).url(forResource: name, withExtension: "json")!
        let data = try! Data(contentsOf: url)
        return data
    }
}

extension XCTestCase {
    var defaultExpectationTimeOut: Double {
        return 2
    }
}
