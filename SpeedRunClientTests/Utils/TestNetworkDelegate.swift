//
//  TestNetworkDelegate.swift
//  SpeedRunClientTests
//
//  Created by Alejandro Quibus on 20/01/2019.
//  Copyright © 2019 Alejandro Quibus. All rights reserved.
//

import Foundation
@testable import SpeedRunClient


class TestNetworkDelegate: NetworkingViewProtocol {
    
    let downloadStartedHandler:(()->Void)?
    let downloadEndedHandler:(()->Void)?

    
    init(downloadStartedHandler:(@escaping ()->Void), downloadEndedHandler downloadEndedHandler:(@escaping ()->Void)) {
        self.downloadStartedHandler = downloadStartedHandler
        self.downloadEndedHandler = downloadEndedHandler
    }
    
    func downloadStarted() {
        self.downloadStartedHandler?()
    }
    
    func downloadEnded() {
        self.downloadEndedHandler?()
    }
    
    
}
