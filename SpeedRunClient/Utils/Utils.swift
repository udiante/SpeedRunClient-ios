//
//  Utils.swift
//  SpeedRunClient
//
//  Created by Alejandro Quibus on 19/01/2019.
//  Copyright © 2019 Alejandro Quibus. All rights reserved.
//

import UIKit

class Utils: NSObject {
    static func isDebugEnabled()->Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
}
