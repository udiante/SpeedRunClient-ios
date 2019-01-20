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
    
    static func formatSeconds(_ seconds:Int)->String{
        var baseString = ""
        let time: (Int, Int, Int) = (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
        if time.0 > 0 {
            baseString = String(format: "hours_format".localized(), time.0)
        }
        if time.1 > 0 {
            baseString += String(format: "minutes_format".localized(), time.1)
        }
        if time.2 > 0 {
            baseString += String(format: "seconds_format".localized(), time.2)
        }
        return baseString
    }
}
