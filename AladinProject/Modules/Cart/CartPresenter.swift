//
//  CartPresenter.swift
//  AladinProject
//
//  Created by Irfan Adika on 04/02/22.
//

import Foundation

class CartPresenter: CartPresenterProtocol {
    
    weak private var view: CartViewProtocol?
    private let interactor: CartInteractorInputProtocol?
    private let router: CartRouterProtocol?
    
    init(interface: CartViewProtocol, interactor: CartInteractorInputProtocol, router: CartRouterProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
        RealmManager.shared.loadRealmObject()
    }
    
    func plusProduct(data: CartEntity) {
        RealmManager.shared.updateCartItemCount(data, data.totalItem + 1)
        view?.didSuccessCalcuteProduct()
    }
    
    func minProduct(data: CartEntity) {
        if data.totalItem > 1 {
            RealmManager.shared.updateCartItemCount(data, data.totalItem - 1)
            view?.didSuccessCalcuteProduct()
        }
    }
    
    func removeProduct(data: CartEntity) {
        RealmManager.shared.delete(data)
        view?.didSuccessCalcuteProduct()
    }
    
    func getTotalProduct() -> Float {
        var total: Float = 0
        if let cart = RealmManager.shared.cart {
            for i in cart {
                if let product = RealmManager.shared.getProductById(idProduct: i.idProduct) {
                    total += (Float(i.totalItem) * product.priceProduct)
                }
            }
        }
        
        return total
    }
    
    func checkout() {
        RealmManager.shared.deleteAllDataObject(CartEntity.self)
        router?.navigateCheckout()
    }
}

extension CartPresenter: CartInteractorOutputProtocol {
    func didSuccessCheckout() {
        
    }
    
    func requestDidFailed(message: String) {
        
    }
    
    
}
