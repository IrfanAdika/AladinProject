//
//  ProductRouter.swift
//  AladinProject
//
//  Created by Irfan Adika on 03/02/22.
//

import Foundation
import UIKit

class ProductRouter: ProductRouterProtocol {
    
    weak var viewController: UIViewController?
    
    func navigateToCart() {
        let vc = ModuleBuilder.shared.createCartViewController()
        viewController?.present(vc, animated: true, completion: nil)
    }
}
