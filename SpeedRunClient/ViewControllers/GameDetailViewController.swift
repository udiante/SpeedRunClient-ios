//
//  GameDetailViewController.swift
//  SpeedRunClient
//
//  Created by Alejandro Quibus on 20/01/2019.
//  Copyright © 2019 Alejandro Quibus. All rights reserved.
//

import UIKit

class GameDetailViewController: BaseViewController {
    
    fileprivate (set) var viewModel: GameDetailViewModel!
    @IBOutlet weak var gameDetailTableView: UITableView!
    
    static func storyBoardInstance(withGameData gameData:GameData)->GameDetailViewController{
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameDetailViewController") as! GameDetailViewController
        vc.viewModel = GameDetailViewModel(gameData: gameData)
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    func fetchData(){
        viewModel.fetchGameDetails(delegate: self)
    }
    
    override func configureUI() {
        super.configureUI()
        self.useLargeTitleAtNavigationBar = false
        self.title = "title_game_detail".localized()
        
        self.gameDetailTableView.backgroundColor = Constants.colors.defaultBackgroundColor
        
        gameDetailTableView.register(UINib(nibName: "GameItemTableViewCell", bundle: nil), forCellReuseIdentifier: "GameItemTableViewCell")
        gameDetailTableView.register(UINib(nibName: "TitleSubtitleTableViewCell", bundle: nil), forCellReuseIdentifier: "TitleSubtitleTableViewCell")
        
        
        gameDetailTableView.delegate = self
        gameDetailTableView.dataSource = self
        
        gameDetailTableView.refreshControl = self.refreshControl
        gameDetailTableView.bounces = false
        
        gameDetailTableView.tableFooterView = UIView()
    }
    
    override func downloadEnded() {
        super.downloadEnded()
        self.gameDetailTableView.reloadData()
    }
    
}

extension GameDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfCells()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellVM = viewModel.getCell(atIndex: indexPath.row) else {
            return UITableViewCell()
        }
        
        if let gameCellVM = cellVM as? GamesListGameCellViewModel, let cell = tableView.dequeueReusableCell(withIdentifier: cellVM.cellIdentifier, for: indexPath) as? GameItemTableViewCell {
            cell.lblTitle.textAlignment = .center
            cell.configure(cellVM: gameCellVM)
            return cell
        }
        
        if let infoCellVM = cellVM as? GameDetailInfoCellViewModel, let cell = tableView.dequeueReusableCell(withIdentifier: cellVM.cellIdentifier, for: indexPath) as? TitleSubtitleTableViewCell {
            cell.configure(title: infoCellVM.title, subtitle: infoCellVM.subtitle)
            return cell
        }
        
        if let buttonCellVM = cellVM as? GameDetailButtonCellViewModel, let cell = tableView.dequeueReusableCell(withIdentifier: cellVM.cellIdentifier, for: indexPath) as? TitleSubtitleTableViewCell {
            cell.configure(buttonTitle: buttonCellVM.title)
            cell.separatorInset = UIEdgeInsets(top: 0, left: self.view.bounds.width, bottom: 0, right: 0)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.getCell(atIndex: indexPath.row)?.cellHeight ?? UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cellVM = viewModel.getCell(atIndex: indexPath.row) as? GameDetailButtonCellViewModel, let videoURL = cellVM.buttonActionUrl else {return}
        UIApplication.shared.open(videoURL, options: [:], completionHandler: nil)
    }
    
}
