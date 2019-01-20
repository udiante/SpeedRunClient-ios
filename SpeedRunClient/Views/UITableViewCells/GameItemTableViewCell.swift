//
//  GameItemTableViewCell.swift
//  SpeedRunClient
//
//  Created by Alejandro Quibus on 20/01/2019.
//  Copyright © 2019 Alejandro Quibus. All rights reserved.
//

import UIKit
import SDWebImage

class GameItemTableViewCell: BaseTableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    fileprivate (set) var cellVM:GamesListGameCellViewModel?
    
    override func configureUI() {
        super.configureUI()
    }
    
    func configure(cellVM:GamesListGameCellViewModel){
        self.cellVM = cellVM
        
        self.iconImageView.image = Constants.assets.imagePlaceHolder
        if let iconURL = cellVM.getIconImageURL() {
            self.iconImageView.sd_setImage(with: iconURL)
        }
        
        self.lblTitle.text = cellVM.getCellTitle()
        
    }
}
