//
//  UITestStubKeys.swift
//  SpeedRunClient
//
//  Created by Alejandro Quibus on 20/01/2019.
//  Copyright © 2019 Alejandro Quibus. All rights reserved.
//

import Foundation

enum UITestStubKeys: String {
    case UITestEnabled = "UITestMode"
    case stubJSON = "UITest_URL"
    case stubHTTPSatus = "UITest_URL_ERROR"
}

enum TestEndPoints: String {
    case games = "/api/v1/games"
}
