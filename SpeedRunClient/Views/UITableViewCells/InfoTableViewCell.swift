//
//  ErrorTableViewCell.swift
//  SpeedRunClient
//
//  Created by Alejandro Quibus on 20/01/2019.
//  Copyright © 2019 Alejandro Quibus. All rights reserved.
//

import UIKit

protocol InfoTableViewCellDelegate: class {
    func acctionButtonPressed(status:InfoTableViewCell.InfoTableViewCellStatus)
}

class InfoTableViewCell: BaseTableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var buttonRetry: UIButton!
    
    weak var delegate: InfoTableViewCellDelegate?
    
    enum InfoTableViewCellStatus {
        case EmptyState
        case Error
        
        fileprivate func imageIcon()-> UIImage? {
            switch self {
            case .EmptyState:
                return UIImage(named: "baseline_info_white")
            case .Error:
                return UIImage(named: "baseline_error_outline_white")
            }
        }
    }

    override func configureUI() {
        super.configureUI()
        self.buttonRetry.setTitle("btn_retry".localized(), for: .normal)
    }
    
    fileprivate (set) var status: InfoTableViewCellStatus = .EmptyState {
        didSet {
            self.iconImageView.image = status.imageIcon()
        }
    }
    
    func configure(cellVM:GamesListErrorCellViewModel, delegate:InfoTableViewCellDelegate){
        self.status = .Error
        self.lblDescription.text = cellVM.networkError.getLocalizedErrorDescriptionKey().localized()
        self.delegate = delegate
    }

    func configure(emptyStateDescription:String, delegate:InfoTableViewCellDelegate) {
        self.status = .EmptyState
        self.lblDescription.text = emptyStateDescription
        self.delegate = delegate
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        delegate?.acctionButtonPressed(status: self.status)
    }
}
