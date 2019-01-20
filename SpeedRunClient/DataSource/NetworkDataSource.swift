//
//  NetworkDataSource.swift
//  SpeedRunClient
//
//  Created by Alejandro Quibus on 19/01/2019.
//  Copyright © 2019 Alejandro Quibus. All rights reserved.
//

import Foundation
import Alamofire

public enum NetworkDataSourceError : Error {
    case RequestError
    case NetworkError
    case UnAuthorized
    
    func getLocalizedErrorDescriptionKey()->String {
        switch self {
        case .NetworkError:
            return "message_error_nointernet"
        default:
            return "message_error_request"
        }
    }
}

/// Generic Network data source allowing GET and POST request to external services.
public class NetworkDataSource: NSObject {
    
    fileprivate let defaultHTTPheaders : HTTPHeaders?
    
    /**
     Initializes the NetworkDataSource with a default HTTPHeaders that will be sent on each request.
     - Parameter httpHeaders: HTTP headers that will be send on each request.
     */
    init(withHTTPheaders httpHeaders:HTTPHeaders?){
        self.defaultHTTPheaders = httpHeaders;
    }
    
    /// Securely prints the provided items in the console only if the app is build with the debug enabled.
    private func log(_ items: Any...){
        guard Utils.isDebugEnabled() else {return}
        print(items)
    }
    
    private func prepareHeaders(additionalHeaders:HTTPHeaders?)->HTTPHeaders? {
        guard let baseHeaders = self.defaultHTTPheaders else {
            return additionalHeaders;
        }
        return baseHeaders.merging(additionalHeaders ?? [:] , uniquingKeysWith: {$1})
    }
    
    private func performRequest<T:Codable>(method: HTTPMethod, urlRequest : String, parameters:[String:Any]?, parametersEncoding encoding: ParameterEncoding, headers : HTTPHeaders?, responseObject:T.Type, completionHandler: (@escaping (NetworkDataSourceError?, Codable?) -> Void)) {
        
        guard let network = NetworkReachabilityManager(), network.isReachable else {
            completionHandler(NetworkDataSourceError.NetworkError,nil)
            return
        }
        
        Alamofire.request(urlRequest, method:method, parameters: parameters, encoding:encoding, headers:self.prepareHeaders(additionalHeaders: headers))
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData(completionHandler: { (response) in
                switch response.result {
                case .success:
                    if let data = response.data, let responseDecoded = try? JSONDecoder().decode(T.self, from: data) {
                        completionHandler(nil, responseDecoded)
                    }
                    else {
                        completionHandler(NetworkDataSourceError.RequestError, nil)
                    }
                case .failure (let error):
                    self.log("Request error: \(error)")
                    var customErrror : NetworkDataSourceError = NetworkDataSourceError.RequestError
                    if let errorCode = response.response?.statusCode {
                        if (errorCode == 401) {
                            customErrror = NetworkDataSourceError.UnAuthorized
                        }
                    }
                    completionHandler(customErrror,nil);
                    break;
                }
            })
    }
    
    public func getRequest<T:Codable>(urlRequest : String, parameters:[String:Any]?, headers : HTTPHeaders?=nil, responseObject:T.Type, completionHandler: (@escaping (NetworkDataSourceError?, Codable?) -> Void)){
        self.performRequest(method: .get, urlRequest: urlRequest, parameters: parameters, parametersEncoding: URLEncoding.default, headers: self.prepareHeaders(additionalHeaders: headers), responseObject: responseObject) { (error, responseObject) in
            self.log("[GET]\(urlRequest):",responseObject.debugDescription)
            completionHandler(error,responseObject)
        }
    }
    
}

