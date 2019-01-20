//
//  GameDetailViewModel.swift
//  SpeedRunClient
//
//  Created by Alejandro Quibus on 20/01/2019.
//  Copyright © 2019 Alejandro Quibus. All rights reserved.
//

import UIKit

class GameDetailViewModel {

    fileprivate let gameData:GameData
    fileprivate var firstRunData:RunsData?
    fileprivate var userRunData:UserData?
    fileprivate (set) var cellsVM = [BaseCellViewModel]()
    
    init(gameData:GameData){
        self.gameData = gameData
    }
    
    // MARK: - UI
    
    func getNumberOfCells()->Int{
        return cellsVM.count
    }
    
    func getCell(atIndex index:Int)->BaseCellViewModel?{
        guard index >= 0, index < getNumberOfCells() else {return nil}
        return self.cellsVM[index]
    }
    
    fileprivate func preareCellsVM(){
        cellsVM.removeAll()
        
        // Game detail
        cellsVM.append(GamesListGameCellViewModel(gameModel: gameData))
        
        // Runtime info
        if let runData = self.firstRunData {
            if let videoURL = runData.videos?.links?.first?.uri {
                cellsVM.append(GameDetailButtonCellViewModel(title: "button_show_video".localized(), buttonURL: videoURL))
            }
            if let timeRun = runData.times?.realtime_t {
                cellsVM.append(GameDetailInfoCellViewModel(title: Utils.formatSeconds(timeRun), subtitle: "time_title".localized()))
            }
        }
        
        // Player info
        if let playerData = self.userRunData, let userName = playerData.names?.international {
            cellsVM.append(GameDetailInfoCellViewModel(title: userName, subtitle: "username_title".localized()))
        }
        
    }
    
    // MARK: - Request
    
    private func getRunsURI()->String? {
        for link in gameData.links ?? [] {
            if link.rel == "runs", let uriRuns = link.uri  {
                return uriRuns
            }
        }
        return nil
    }
    
    private func getUserRunURI()->String?{
        return firstRunData?.players?.first?.uri
    }
    
    func fetchGameDetails(delegate:NetworkingViewProtocol) {
        delegate.downloadStarted()
        let completionSuccessCallback = { [weak self, weak delegate] in
            self?.preareCellsVM()
            delegate?.downloadEnded()
        }
        
        guard let gameRunsUri = getRunsURI() else {
            completionSuccessCallback()
            return
        }

        SpeedRunDataSource.getGameRuns(gameRunsURI: gameRunsUri) { [weak self] (error, response) in
            self?.firstRunData = response?.data?.first
            
            // Check if the user information is available to continue
            if let userUri = self?.getUserRunURI() {
                SpeedRunDataSource.getUserDetail(userURI: userUri, completionHandler: { (error, userResponse) in
                    self?.userRunData = userResponse?.data
                    completionSuccessCallback()
                })
            }
            else {
                completionSuccessCallback()
            }
        }
    }
}

class GameDetailInfoCellViewModel: BaseCellViewModel {
    
    let title:String
    let subtitle:String?

    
    override var cellIdentifier: String! {
        return ""
    }
    
    override var cellHeight: CGFloat? {
        return UITableView.automaticDimension
    }
    
    init(title:String, subtitle:String?){
        self.title = title
        self.subtitle = subtitle
    }
}

class GameDetailButtonCellViewModel: BaseCellViewModel {
    let title:String
    let buttonActionUrl:String
    
    override var cellIdentifier: String! {
        return ""
    }
    
    override var cellHeight: CGFloat? {
        return 66
    }
    
    init(title:String, buttonURL:String){
        self.title = title
        self.buttonActionUrl = buttonURL
    }
    
}
