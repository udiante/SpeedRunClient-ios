//
//  SwiftExtensions.swift
//  SpeedRunClient
//
//  Created by Alejandro Quibus on 19/01/2019.
//  Copyright © 2019 Alejandro Quibus. All rights reserved.
//

import Foundation

extension String {
    func localized()->String{
        return NSLocalizedString(self, comment: self)
    }
}
