//
//  BaseViewController.swift
//  SpeedRunClient
//
//  Created by Alejandro Quibus on 19/01/2019.
//  Copyright © 2019 Alejandro Quibus. All rights reserved.
//

import UIKit

protocol NetworkingViewProtocol {
    func startDownload()
    func stopDownload(withError error:NetworkDataSourceError?)
}

class BaseViewController: UIViewController, NetworkingViewProtocol {
    
    var useLargeTitleAtNavigationBar : Bool = true
    fileprivate (set) var refreshControl = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        JustHUD.setBackgroundColor(color: UIColor.black, automaticTextColor: true)
        JustHUD.setLoaderColor(color: Constants.colors.defaultActiveColor)
        
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        refreshControl.tintColor = UIColor.white
        navigationItem.largeTitleDisplayMode = .automatic;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = useLargeTitleAtNavigationBar;
    }
    
    //MARK: - UI Methods
    
    func showHud(){
        if let window = self.view.window ?? UIApplication.shared.windows.first {
            JustHUD.shared.showInWindow(window: window)
        }
        else {
            JustHUD.shared.showInView(view: self.view)
        }
    }
    
    func hideHud(){
        JustHUD.shared.hide()
    }
    
    
    // MARK: - Refresh Controll
    
    ///This function must be overrided for a custom refreshControll usage
    @objc open func refreshData() {
        
    }
    
    //MARK: - Networking protocol
    func startDownload() {
        showHud()
    }
    
    func stopDownload(withError error: NetworkDataSourceError?) {
        refreshControl.endRefreshing()
        hideHud()
    }
    
    func isForceTouchAvailable()->Bool{
        return self.traitCollection.forceTouchCapability == .available
    }
    
}

