//
//  CartInteractor.swift
//  AladinProject
//
//  Created by Irfan Adika on 04/02/22.
//

import Foundation

class CartInteractor:
    CartInteractorInputProtocol {
    var output: CartInteractorOutputProtocol?
    private let coreApi: CoreApi
    
    init() {
        self.coreApi = CoreApi()
        coreApi.delegate = self
    }
    
    func reqCheckout() {
        //Not implemented with api
    }
}

extension CartInteractor: CoreApiDelegate {
    func finish(interFace: CoreApi, responseHeaders: HTTPURLResponse, data: Data) {
        //Not implemented with api
    }
    
    func failed(interFace: CoreApi, result: AnyObject) {
        //Not implemented with api
    }
    
    
}
