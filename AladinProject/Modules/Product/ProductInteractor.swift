//
//  ProductInteractor.swift
//  AladinProject
//
//  Created by Irfan Adika on 03/02/22.
//

import Foundation

class ProductInteractor: ProductInteractorInputProtocol {
    var output: ProductInteractorOutputProtocol?
    private let coreApi: CoreApi
    
    init() {
        self.coreApi = CoreApi()
        coreApi.delegate = self
    }
    
    func getProducts() {
        coreApi.getRequest(urlRequest: ServiceConfig.getProduct)
    }
}

extension ProductInteractor: CoreApiDelegate {
    func finish(interFace: CoreApi, responseHeaders: HTTPURLResponse, data: Data) {
        do {
            let jsonDecoder = JSONDecoder()
            
            let response = try jsonDecoder.decode(BaseResponse<[ProductEntity]>.self, from: data)
            
            if response.status {
                self.output?.didSuccessGetProduct(data: response.data)
            }
            
        } catch let error {
            self.output?.requestDidFailed(message: "Failed get data \(error.localizedDescription)")
        }
    }
    
    func failed(interFace: CoreApi, result: AnyObject) {
        self.output?.requestDidFailed(message: "Problem with server")
    }
}
