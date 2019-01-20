//
//  GamesListViewModel.swift
//  SpeedRunClient
//
//  Created by Alejandro Quibus on 19/01/2019.
//  Copyright © 2019 Alejandro Quibus. All rights reserved.
//

import UIKit

class GamesListViewModel: NSObject {
    
    fileprivate var gamesList = [GameData]()
    fileprivate (set) var cellsVM = [GamesListCellsViewModel]()
    
    func resetGamesList() {
        self.gamesList.removeAll()
        self.cellsVM.removeAll()
    }
    
    // MARK: - UI
    
    func getNumberOfCells()->Int{
        return cellsVM.count
    }
    
    func getCell(atIndex index:Int)->GamesListCellsViewModel?{
        guard index >= 0, index <= getNumberOfCells() else {return nil}
        return self.cellsVM[index]
    }
    
    // MARK: - Request
    
    fileprivate func prepareCellsVM(withError error:NetworkDataSourceError?){
        
        defer {
            if cellsVM.count == 0 {
                cellsVM.append(GamesListEmptyStateCellViewModel(textDescription: "nogames_description".localized()))
            }
        }
        
        cellsVM.removeAll()
        
        guard error == nil else {
            cellsVM.append(GamesListErrorCellViewModel(networkError: error!))
            return
        }
        
        for game in gamesList {
            cellsVM.append(GamesListGameCellViewModel(gameModel: game))
        }

    }
    
    func fetchGames(delegate:NetworkingViewProtocol) {
        delegate.downloadStarted()
        SpeedRunDataSource.getGames { [weak self, weak delegate] (error, gamesResponse) in
            self?.gamesList  = gamesResponse?.data ?? []
            self?.prepareCellsVM(withError: error)
            delegate?.downloadEnded()
        }
    }
}


class GamesListCellsViewModel {
    private (set) var cellIdentifier: String!
}

class GamesListGameCellViewModel: GamesListCellsViewModel {
    override var cellIdentifier: String! {
        return "GameItemTableViewCell"
    }
    
    let gameModel:GameData
    
    init(gameModel:GameData){
        self.gameModel = gameModel
        super.init()
    }
    
    // MARK: - Cell UI Methods
    
}

class GamesListErrorCellViewModel: GamesListCellsViewModel {
    override var cellIdentifier: String! {
        return "InfoTableViewCell"
    }
    
    let networkError:NetworkDataSourceError
    
    init(networkError:NetworkDataSourceError){
        self.networkError = networkError
        super.init()
    }
}

class GamesListEmptyStateCellViewModel: GamesListCellsViewModel{
    override var cellIdentifier: String! {
        return "InfoTableViewCell"
    }
    
    let textDescription:String
    
    init(textDescription: String) {
        self.textDescription = textDescription
    }
}
