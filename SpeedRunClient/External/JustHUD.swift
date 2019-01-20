//
//  JustHUD.swift
//  mWELL
//
//  Created by Shubham Naik on 11/07/17.
//  Copyright © 2017 Shubham. All rights reserved.
//

import UIKit

class JustHUD: UIView {
    private var backView: UIView?
    private var progressIndicator: UIActivityIndicatorView?
    private var titleLabel: UILabel?
    private var footerLabel: UILabel?
    
    //Customizable properties
    private var headerColor = UIColor.white
    private var footerColor = UIColor.white
    private var backColor = UIColor.black
    private var loaderColor = UIColor.white
    
    ///Shared instance for easy access
    static let shared = JustHUD()
    
    init() {
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // MARK: Customizing methods
    
    class func setLoaderColor(color: UIColor) {
        shared.loaderColor = color
    }
    
    class func setBackgroundColor(color: UIColor, automaticTextColor: Bool = false) {
        shared.backColor = color
        if automaticTextColor {
            shared.headerColor = getComplementaryForColor(color: color, relativeTo: shared.headerColor)
            shared.footerColor = getComplementaryForColor(color: color, relativeTo: shared.footerColor)
            shared.loaderColor = getComplementaryForColor(color: color, relativeTo: shared.loaderColor)
        }
    }
    
    // MARK: Public Methods
    
    /// Show the loader added to the mentioned view with the provided title and footer texts
    func showInView(view: UIView, withHeader: String?, andFooter: String?) {
        self.hide()
        self.frame = view.bounds
        setIndicator()
        
        setBackGround(view: self)
        
        progressIndicator?.frame.origin = getIndicatorOrigin(view: backView!, activityIndicatorView: progressIndicator!)
        backView?.addSubview(progressIndicator!)
        view.addSubview(self)
    }
    

    // Show the loader added to the mentioned window with no title and footer texts
    func showInWindow(window: UIWindow) {
        self.showInView(view: window, withHeader: nil, andFooter: nil)
    }
    
    /// Removes the loader from its superview to hide
    func hide() {
        if self.superview != nil {
            DispatchQueue.main.async {
                self.removeFromSuperview()
            }
            progressIndicator?.stopAnimating()
        }
    }

    
    // MARK: -Set view properties
    private func setBackGround(view: UIView) {
        if backView?.superview != nil {
            backView?.removeFromSuperview()
            let aView = backView?.viewWithTag(1001) as UIView?
            aView?.removeFromSuperview()
        }
        backView = UIView(frame: getBackGroundFrame(view: self))
        backView?.backgroundColor = UIColor.clear
        let translucentView = UIView(frame: backView!.bounds)
        translucentView.backgroundColor = backColor
        translucentView.alpha = 0.85
        translucentView.tag = 1001;
        backView?.addSubview(translucentView)
        backView?.layer.cornerRadius = 15.0
        backView?.clipsToBounds = true
        self.addSubview(backView!)
    }
    
    private func setIndicator() {
        if progressIndicator?.superview != nil {
            progressIndicator?.removeFromSuperview()
        }
        progressIndicator = UIActivityIndicatorView(style: .whiteLarge)
        progressIndicator?.style = UIActivityIndicatorView.Style.whiteLarge
        progressIndicator?.color = loaderColor
        progressIndicator?.backgroundColor = UIColor.clear
        progressIndicator?.startAnimating()
    }
    

    
    // MARK: -Get Frame
    private func getBackGroundFrame(view: UIView) -> CGRect {
        let sideMargin: CGFloat = 20.0
        let side = progressIndicator!.frame.height + sideMargin
        
        let originX = view.center.x - (side/2)
        let originY = view.center.y - (side/2)
        return CGRect(x: originX, y: originY, width: side, height: side)
    }
    

    
    // MARK: -Get Origin
    private func getIndicatorOrigin(view: UIView, activityIndicatorView indicator: UIActivityIndicatorView) -> CGPoint {
        let side = indicator.frame.size.height
        let originX = (view.bounds.width/2) - (side/2)
        let originY = (view.bounds.height/2) - (side/2)
        return CGPoint(x: originX, y: originY)
    }
    

    // MARK: Colors
    /// get a complementary color to this color:
    private class func getComplementaryForColor(color: UIColor, relativeTo: UIColor) -> UIColor {
        let original = CIColor(color: color)
        let relative = CIColor(color: relativeTo)
        
        // get the current values and make the difference from white
        let compRed = ((1.0 - original.red) + 0.3 * relative.red)/1.3
        let compGreen = ((1.0 - original.green) + 0.3 * relative.green)/1.3
        let compBlue = ((1.0 - original.blue) + 0.3 * relative.blue)/1.3
        
        return UIColor(red: compRed, green: compGreen, blue: compBlue, alpha: 1.0)
    }
}
