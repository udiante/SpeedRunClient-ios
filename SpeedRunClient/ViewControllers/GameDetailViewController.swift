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
    
    static func storyBoardInstance(withGameData gameData:GameData)->GameDetailViewController{
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameDetailViewController") as! GameDetailViewController
        vc.viewModel = GameDetailViewModel(gameData: gameData)
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func configureUI() {
        super.configureUI()
        self.navigationItem.title = "title_game_detail".localized()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
