//
//  ProductContract.swift
//  AladinProject
//
//  Created by Irfan Adika on 03/02/22.
//

import Foundation

protocol ProductRouterProtocol: class {
    func navigateToCart()
}

protocol ProductPresenterProtocol: class {
    func navigateToCart()
    func getProducts()
    func saveToCart(data: ProductEntity)
}

protocol ProductInteractorOutputProtocol: class {
    func didSuccessGetProduct(data: [ProductEntity])
    func requestDidFailed(message: String)
}

protocol ProductInteractorInputProtocol: class {
    var output: ProductInteractorOutputProtocol? { get set }
    
    func getProducts()
}

protocol ProductViewProtocol: class {
    var presenter: ProductPresenterProtocol? { get set }
    
    func didSuccessGetProducts(data: [ProductEntity])
    func showProgressDialog(isShow: Bool)
    func showAlertMessage(isSuccess: Bool, message: String)
}
