//
//  UITestHelper.swift
//  SpeedRunClient
//
//  Created by Alejandro Quibus on 20/01/2019.
//  Copyright © 2019 Alejandro Quibus. All rights reserved.
//

import Foundation
import Mockingjay

//INFO: - Si se tratara de una aplicacion con intención de ser publicada se crearía un nuevo target para los UITest que tendría la dependencia con 'Mockingjay' y los JSON con las respuestas mockeadas para configurar el entorno de pruebas. Así la dependencia del pod 'Mockingjay' ni los JSON de pruebas se añadirían al bundle publicado.
class UITestHelper {
    static func configure(){
        guard isUITestActive() else {return}
        
        // Remove UIAnimations
        UIView.setAnimationsEnabled(false)
        
        // ConfigureStubsLogic
        ProcessInfo.processInfo.environment.forEach { (arg) in
            // The keyContaints the URL to stub and the object the JSON identifier
            let (pathToMock, value) = arg
            if pathToMock.contains(UITestStubKeys.stubJSON.rawValue), let json = getJSON(withName: value) {
                MockingjayProtocol.addStub(matcher: uri(pathToMock.replacingOccurrences(of: UITestStubKeys.stubJSON.rawValue, with: "")), builder: jsonData(json))
            }
            else if pathToMock.contains(UITestStubKeys.stubHTTPSatus.rawValue), let httpStatusCode = Int(value) {
                MockingjayProtocol.addStub(matcher: uri(pathToMock.replacingOccurrences(of: UITestStubKeys.stubHTTPSatus.rawValue, with: "")), builder: http(httpStatusCode))
            }
        }
    }
    
    static func isUITestActive()->Bool{
        return ProcessInfo.processInfo.arguments.contains(UITestStubKeys.UITestEnabled.rawValue)
    }
    
    static func getJSON(withName name:String)->Data? {
        if let url = Bundle(for: UITestHelper.self).url(forResource: name, withExtension: "json") {
            return try? Data(contentsOf: url)
        }
        return nil
    }
    
}
