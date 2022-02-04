//
//  UIViewControllerExt.swift
//  AladinProject
//
//  Created by Irfan Adika on 04/02/22.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    let alertView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    let alertLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var alert: UIAlertController!
    var window: UIWindow!
    var screenHeight: CGFloat?
    var screenWidth: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    func initView() {
        setup(frame: UIScreen.main.bounds)
    }
    
    func setup(frame: CGRect) {
        screenHeight = frame.height
        screenWidth = frame.width
    }

    func getHeight(centimeter: CGFloat) -> CGFloat {
        return screenHeight! * centimeter / 14.9
    }
    
    func getWidth(centimeter: CGFloat) -> CGFloat {
        return screenWidth! * centimeter / 8.4
    }
    
    func showAlertFromTop(message: String, isSuccess: Bool) {
        let statusHeight = UIApplication.shared.statusBarFrame.height
        let navBarHeight = self.navigationController?.navigationBar == nil ? 0 : (self.navigationController?.navigationBar.frame.height)!
        let height = statusHeight + navBarHeight
        window = UIApplication.shared.keyWindow
        alertLabel.textColor = .white
        alertLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.semibold)
        alertLabel.text = message
        alertLabel.numberOfLines = 0
        alertLabel.textAlignment = .center
        alertLabel.sizeThatFits(CGSize(width: window.frame.width - getHeight(centimeter: 1.2), height: navBarHeight))
        
        alertView.frame = CGRect(x: 0, y: 0 - height, width: window.frame.width, height: height)
        
        alertView.addSubview(alertLabel)
        alertLabel.frame = CGRect(x: alertView.frame.height * 0.2, y: statusHeight, width: self.view.frame.width - alertView.frame.height * 0.4, height: navBarHeight)
        window.addSubview(alertView)
        
        alertView.backgroundColor = isSuccess ? .systemGreen : .red
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.alertView.frame = CGRect(x: 0, y: 0, width: self.window.frame.width, height: height)
        }, completion: nil)
        
        let when = DispatchTime.now() + 2 // change 1 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.removeAlert()
        }
    }
        
    func removeAlert() {
        let statusHeight = UIApplication.shared.statusBarFrame.height
        let navBarHeight = self.navigationController?.navigationBar == nil ? 0 : (self.navigationController?.navigationBar.frame.height)!
        let height = statusHeight + navBarHeight
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.alertView.frame = CGRect(x: 0, y: 0 - height, width: self.window.frame.width, height: height)
            self.alertLabel.frame = CGRect(x: self.alertView.frame.height * 0.2, y: 0 - self.alertLabel.frame.height, width: self.view.frame.width - self.alertView.frame.height * 0.4, height: navBarHeight)
        })
    }
}
