//
//  GamesListViewController.swift
//  SpeedRunClient
//
//  Created by Alejandro Quibus on 19/01/2019.
//  Copyright © 2019 Alejandro Quibus. All rights reserved.
//

import UIKit

class GamesListViewController: BaseViewController {
    
    @IBOutlet weak var gamesTableView: UITableView!
    fileprivate let viewModel = GamesListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fetchData()
    }
    
    override func configureUI() {
        super.configureUI()
        
        self.title = "title_games_vc".localized()
        
        self.gamesTableView.backgroundColor = Constants.colors.defaultBackgroundColor
        
        gamesTableView.register(UINib(nibName: "InfoTableViewCell", bundle: nil), forCellReuseIdentifier: "InfoTableViewCell")

        gamesTableView.register(UINib(nibName: "GameItemTableViewCell", bundle: nil), forCellReuseIdentifier: "GameItemTableViewCell")
                
        gamesTableView.delegate = self
        gamesTableView.dataSource = self

        gamesTableView.refreshControl = self.refreshControl
        
        gamesTableView.tableFooterView = UIView()
    }
    
    
    func fetchData(){
        viewModel.fetchGames(delegate: self)
    }

    override func refreshData() {
        super.refreshData()
        fetchData()
    }
    
    override func downloadEnded() {
        super.downloadEnded()
        gamesTableView.scrollRectToVisible(CGRect.zero, animated: false)
        gamesTableView.reloadData()
    }
}

extension GamesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfCells()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellVM = viewModel.getCell(atIndex: indexPath.row) else {
            return UITableViewCell()
        }
        
        if let cellEmptyStateVM = cellVM as? GamesListEmptyStateCellViewModel, let cell = tableView.dequeueReusableCell(withIdentifier: cellVM.cellIdentifier, for: indexPath) as? InfoTableViewCell {
            cell.configure(emptyStateDescription: cellEmptyStateVM.textDescription, delegate: self)
            return cell
        }
        
        if let cellErrorVM = cellVM as? GamesListErrorCellViewModel, let cell = tableView.dequeueReusableCell(withIdentifier: cellVM.cellIdentifier, for: indexPath) as? InfoTableViewCell {
            cell.configure(cellVM: cellErrorVM, delegate: self)
            return cell
        }
        
        if let gameCellVM = cellVM as? GamesListGameCellViewModel, let cell = tableView.dequeueReusableCell(withIdentifier: cellVM.cellIdentifier, for: indexPath) as? GameItemTableViewCell {
            cell.configure(cellVM: gameCellVM)
            return cell
        }

        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.getCell(atIndex: indexPath.row)?.cellHeight ?? UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cellVM = viewModel.getCell(atIndex: indexPath.row) as? GamesListGameCellViewModel else {return}
        // Display the GameDetail info
        let detailVC = GameDetailViewController.storyBoardInstance(withGameData: cellVM.gameModel)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension GamesListViewController: InfoTableViewCellDelegate {
    func acctionButtonPressed(status: InfoTableViewCell.InfoTableViewCellStatus) {
        self.fetchData()
    }
    
    
}
