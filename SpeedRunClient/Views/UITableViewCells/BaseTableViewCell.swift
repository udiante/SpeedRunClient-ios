//
//  BaseTableViewCell.swift
//  SpeedRunClient
//
//  Created by Alejandro Quibus on 20/01/2019.
//  Copyright © 2019 Alejandro Quibus. All rights reserved.
//

import UIKit

class BaseCellViewModel {
    open private (set) var cellIdentifier: String!
    open private (set) var cellHeight: CGFloat!
    
}

class BaseTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureUI()
    }
    
    open func configureUI(){
        self.selectionStyle = .none
        self.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }

}
