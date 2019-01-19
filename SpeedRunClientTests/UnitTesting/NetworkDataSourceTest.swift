//
//  NetworkDataSourceTest.swift
//  SpeedRunClientTests
//
//  Created by Alejandro Quibus on 19/01/2019.
//  Copyright © 2019 Alejandro Quibus. All rights reserved.
//

import XCTest
@testable import SpeedRunClient
import Mockingjay

fileprivate class TEST_MODEL : Codable {
    let a : Int?
    let b : String?
    
    enum CodingKeys: String, CodingKey {
        case a = "a"
        case b = "b"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        a = try values.decodeIfPresent(Int.self, forKey: .a)
        b = try values.decodeIfPresent(String.self, forKey: .b)
    }
    
}

class NetworkDataSourceTest: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    func testRequestSuccess(){
        let dataSource = NetworkDataSource(withHTTPheaders: nil)
        let expect = expectation(description: "The download should succeed")

        // Given - We mock a valid response
        let stubBody = ["a":1,"b":"test"] as [String : Any]
        stub(uri( "/test"), json(stubBody))

        // When - Whe we perfom a request
        dataSource.getRequest(urlRequest: "http://test.com/test", parameters: nil, responseObject: TEST_MODEL.self) { (error, responseObject) in
            // Then - The completion callback has an instance with the stub data
            XCTAssertNil(error)
            guard let expectedObject = responseObject as? TEST_MODEL else {
                return
            }
            XCTAssertEqual(expectedObject.a, stubBody["a"] as? Int)
            XCTAssertEqual(expectedObject.b, stubBody["b"] as? String)
            
            expect.fulfill()
        }
        waitForExpectations(timeout: defaultExpectationTimeOut, handler: nil)
    }
    
    func testRequestFailure(){
        let dataSource = NetworkDataSource(withHTTPheaders: nil)
        let expect = expectation(description: "The download should fail")
        
        // Given: - We mock a request failure (404)
        stub(everything, http(404))
        
        // When: - We perfom the request
        dataSource.getRequest(urlRequest: "http://test.com/test", parameters: nil, responseObject: TEST_MODEL.self) { (error, responseObject) in
            // Then: - The completion has a RequestError error object and no data
            XCTAssertEqual(error, NetworkDataSourceError.RequestError)
            XCTAssertNil(responseObject)
            expect.fulfill()
        }
        
        waitForExpectations(timeout: defaultExpectationTimeOut, handler: nil)
    }
    
    func testRequestUnauthorized(){
        let dataSource = NetworkDataSource(withHTTPheaders: nil)
        let expect = expectation(description: "The download should fail")
        
        // Given: - We mock a request failure (404)
        stub(everything, http(401))
        
        // When: - We perfom the request
        dataSource.getRequest(urlRequest: "http://test.com/test", parameters: nil, responseObject: TEST_MODEL.self) { (error, responseObject) in
            // Then: - The completion has a UnAuthorized error object and no data
            XCTAssertEqual(error, NetworkDataSourceError.UnAuthorized)
            XCTAssertNil(responseObject)
            expect.fulfill()
        }
        
        waitForExpectations(timeout: defaultExpectationTimeOut, handler: nil)
    }

    func testLocalizedString() {
        XCTAssertEqual(NetworkDataSourceError.NetworkError.getLocalizedErrorDescription(), "No internet connection, try again later")
        XCTAssertEqual(NetworkDataSourceError.RequestError.getLocalizedErrorDescription(), "Error, try again later")
        XCTAssertEqual(NetworkDataSourceError.UnAuthorized.getLocalizedErrorDescription(), "Error, try again later")

    }
}
