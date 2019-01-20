//
//  GameItemTableViewCell.swift
//  SpeedRunClient
//
//  Created by Alejandro Quibus on 20/01/2019.
//  Copyright © 2019 Alejandro Quibus. All rights reserved.
//

import UIKit

class GameItemTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    fileprivate (set) var cellVM:GamesListGameCellViewModel?
    
    func configure(cellVM:GamesListGameCellViewModel){
        self.cellVM = cellVM
    }
}
