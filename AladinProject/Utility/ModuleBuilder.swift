//
//  ModuleBuilder.swift
//  AladinProject
//
//  Created by Irfan Adika on 03/02/22.
//

import Foundation

class ModuleBuilder {
    static let shared = ModuleBuilder()
    
    func createProductViewController() -> ProductViewController {
        let view = ProductViewController(nibName: "ProductViewController", bundle: nil)
        let interactor = ProductInteractor()
        let router = ProductRouter()
        let presenter = ProductPresenter(interface: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        
        return view
    }
    
    func createCartViewController() -> CartViewController {
        let view = CartViewController(nibName: "CartViewController", bundle: nil)
        let interactor = CartInteractor()
        let router = CartRouter()
        let presenter = CartPresenter(interface: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        
        return view
    }
}
