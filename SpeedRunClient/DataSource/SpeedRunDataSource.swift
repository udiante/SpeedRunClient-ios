//
//  SpeedRunDataSource.swift
//  SpeedRunClient
//
//  Created by Alejandro Quibus on 20/01/2019.
//  Copyright © 2019 Alejandro Quibus. All rights reserved.
//

import UIKit

/// Data Source to provide an easy access to the SpeedRun API service.
class SpeedRunDataSource: NSObject {
    
    fileprivate enum Endpoints : String  {
        case games = "games"
        
        func getFullPath(baseURL:String)->String{
            return "\(baseURL)\(self.rawValue)"
        }
    }

    fileprivate static let baseURL = "https://www.speedrun.com/api/v1/" //Test project with only one enviorement
    
    fileprivate static let networkDataSource = NetworkDataSource(withHTTPheaders: ["Accept":"application/json"])
    
    // MARK: - Public methods
    
    /**
     Request to the SpeedRun API service the first page of Games.
     - Parameter completionHandler: Callback with the response or error.
     */
    static func getGames(completionHandler: (@escaping (NetworkDataSourceError?, GamesResponse?) -> Void)){
        let requestUrl = Endpoints.games.getFullPath(baseURL: baseURL)
        self.networkDataSource.getRequest(urlRequest: requestUrl, parameters: nil, responseObject: GamesResponse.self) { (error, response) in
            completionHandler(error,response as? GamesResponse)
        }
    }
    
    /**
     Request to the SpeedRun API service the first page of Runs of the Game with the provided URI.
     - Parameter completionHandler: Callback with the response or error.
     */
    static func getGameRuns(gameRunsURI:String, completionHandler: (@escaping (NetworkDataSourceError?, RunsResponse?) -> Void)) {
        self.networkDataSource.getRequest(urlRequest: gameRunsURI, parameters: nil, responseObject: RunsResponse.self) { (error, response) in
            completionHandler(error,response as? RunsResponse)
        }
    }
    
    /**
     Request to the SpeedRun API service the details of a user given their URI.
     - Parameter completionHandler: Callback with the response or error.
     */
    static func getUserDetail(userURI:String, completionHandler: (@escaping (NetworkDataSourceError?, UserResponse?) -> Void)) {
        self.networkDataSource.getRequest(urlRequest: userURI, parameters: nil, responseObject: UserResponse.self) { (error, response) in
            completionHandler(error,response as? UserResponse)
        }
    }

}
