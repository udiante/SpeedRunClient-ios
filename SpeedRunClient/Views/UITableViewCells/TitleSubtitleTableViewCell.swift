//
//  TItleSubtitleTableViewCell.swift
//  SpeedRunClient
//
//  Created by Alejandro Quibus on 20/01/2019.
//  Copyright © 2019 Alejandro Quibus. All rights reserved.
//

import UIKit

class TitleSubtitleTableViewCell: BaseTableViewCell {

    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var lblSubtitle: UILabel!
    
    override func configureUI() {
        super.configureUI()
        lblTitle.textColor = Constants.colors.defaultActiveColor
        lblSubtitle.textColor = Constants.colors.defaultSecondaryColor
    }
    
    func configure(title:String, subtitle:String?) {
        lblTitle.textColor = Constants.colors.defaultActiveColor
        lblTitle.textAlignment = .left
        self.lblSubtitle.isHidden = false
        
        self.lblTitle.text = title
        self.lblSubtitle.text = subtitle
    }
    
    func configure(buttonTitle:String){
        lblTitle.textColor = Constants.colors.highlightColor
        lblTitle.textAlignment = .center
        self.lblTitle.text = buttonTitle
        self.lblSubtitle.isHidden = true
    }
}
