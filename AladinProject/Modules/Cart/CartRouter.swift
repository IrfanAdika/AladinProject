//
//  CartRouter.swift
//  AladinProject
//
//  Created by Irfan Adika on 04/02/22.
//

import Foundation
import UIKit

class CartRouter: CartRouterProtocol {
    
    weak var viewController: UIViewController?
    
    func navigateCheckout() {
        viewController?.dismiss(animated: true, completion: nil)
    }
}
