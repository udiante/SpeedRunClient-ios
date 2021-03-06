//
//  BaseViewController.swift
//  SpeedRunClient
//
//  Created by Alejandro Quibus on 19/01/2019.
//  Copyright © 2019 Alejandro Quibus. All rights reserved.
//

import UIKit

protocol NetworkingViewProtocol: class {
    func downloadStarted()
    func downloadEnded()
}

class BaseViewController: UIViewController, NetworkingViewProtocol {
    
    var useLargeTitleAtNavigationBar : Bool = true
    fileprivate (set) var refreshControl = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        JustHUD.setBackgroundColor(color: Constants.colors.defaultSecondaryColor, automaticTextColor: true)
        JustHUD.setLoaderColor(color: Constants.colors.defaultActiveColor)
        
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        refreshControl.tintColor = UIColor.white
        navigationItem.largeTitleDisplayMode = .automatic
        
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = useLargeTitleAtNavigationBar;
    }
    
    //MARK: - UI Methods
    
    func showHud(){
        guard !refreshControl.isRefreshing else {return}
        if let window = self.view.window ?? UIApplication.shared.windows.first {
            JustHUD.shared.showInWindow(window: window)
        }
    }
    
    func hideHud(){
        JustHUD.shared.hide()
    }
    
    open func configureUI(){
        self.navigationController?.navigationBar.barStyle = .black
        self.view.backgroundColor = Constants.colors.defaultBackgroundColor
        self.navigationController?.navigationBar.tintColor = Constants.colors.defaultActiveColor
    }
    
    
    // MARK: - Refresh Controll
    
    ///This function must be overrided for a custom refreshControll usage
    @objc open func refreshData() {
        
    }
    
    //MARK: - Networking protocol
    func downloadStarted() {
        showHud()
    }
    
    func downloadEnded() {
        refreshControl.endRefreshing()
        hideHud()
    }
    
}

