//
//  ProductPresenter.swift
//  AladinProject
//
//  Created by Irfan Adika on 03/02/22.
//

import Foundation

class ProductPresenter: ProductPresenterProtocol {
    
    weak private var view: ProductViewProtocol?
    private let interactor: ProductInteractorInputProtocol?
    private let router: ProductRouterProtocol?
    
    init(interface: ProductViewProtocol, interactor: ProductInteractorInputProtocol, router: ProductRouterProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func navigateToCart() {
        router?.navigateToCart()
    }
    
    func getProducts() {
        view?.showProgressDialog(isShow: true)
        interactor?.getProducts()
    }
    
    func saveToCart(data: ProductEntity) {
        if let cart = RealmManager.shared.getCartById(idProduct: data.idProduct) {
            RealmManager.shared.updateCartItemCount(cart, cart.totalItem + 1)
        } else {
            let cartEntity = CartEntity()
            cartEntity.idProduct = data.idProduct
            cartEntity.totalItem = 1
            RealmManager.shared.add(cartEntity)
        }
        
        
        view?.showAlertMessage(isSuccess: true, message: "Success Add to Cart")
    }
    
}

extension ProductPresenter: ProductInteractorOutputProtocol {
    func didSuccessGetProduct(data: [ProductEntity]) {
        view?.showProgressDialog(isShow: false)
        view?.didSuccessGetProducts(data: data)
        
        RealmManager.shared.deleteAllDataObject(ProductEntity.self)
        RealmManager.shared.add(data)
    }
    
    func requestDidFailed(message: String) {
        view?.showAlertMessage(isSuccess: false, message: message)
    }
}
