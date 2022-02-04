//
//  CartContract.swift
//  AladinProject
//
//  Created by Irfan Adika on 04/02/22.
//

import Foundation

protocol CartRouterProtocol: class {
    func navigateCheckout()
}

protocol CartPresenterProtocol: class {
    func plusProduct(data: CartEntity)
    func minProduct(data: CartEntity)
    func removeProduct(data: CartEntity)
    func getTotalProduct() -> Float
    func checkout()
}

protocol CartInteractorOutputProtocol: class {
    func didSuccessCheckout()
    func requestDidFailed(message: String)
}

protocol CartInteractorInputProtocol: class {
    var output: CartInteractorOutputProtocol? { get set }
    
    func reqCheckout()
}

protocol CartViewProtocol: class {
    var presenter: CartPresenterProtocol? { get set }
    
    func didSuccessGetProducts()
    func didSuccessCalcuteProduct()
    func showProgressDialog(isShow: Bool)
    func showAlertMessage(title: String, message: String)
}
