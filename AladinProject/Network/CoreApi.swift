//
//  CoreApi.swift
//  AladinProject
//
//  Created by Irfan Adika on 03/02/22.
//

import Foundation
import Alamofire

@objc protocol CoreApiDelegate {
    @objc func finish(interFace : CoreApi, responseHeaders : HTTPURLResponse, data : Data)
    @objc func failed(interFace : CoreApi, result : AnyObject)
}

class CoreApi : NSObject {
    weak var delegate : CoreApiDelegate?
    
    func getRequest(urlRequest: URLRequestConvertible){
        AF.request(urlRequest).responseData { response in
            
            print("Header >>> \(String(describing: response.request?.allHTTPHeaderFields))\n")
            print("URL Request >>> \(String(describing: response.request))\n")  // original URL request
            print("statusCode >>> \(String(describing: response.response?.statusCode))\n")
            
            if self.isConnectedToInternet() {
                let statusCode = response.response?.statusCode
                switch (statusCode) {
                case 200,201:
                    
                    guard let responseHeader = response.response else { return }
                    guard let data = response.data else { return }
                    self.success(responseHeaders: responseHeader, data: data)
                case 403:
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationTokenExpired"), object: nil, userInfo: nil)
                default:
                    guard let data = response.data else { return }
                    self.failed(data: data as AnyObject)
                    
                }
            }
        }
        
    }
    
    //MARK : RESPONSE SUCCESS
    func success(responseHeaders : HTTPURLResponse, data : Data) {
        delegate?.finish(interFace: self, responseHeaders : responseHeaders, data : data)
    }
    
    //MARK : RESPONSE FAILED
    func failed(data : AnyObject) {
        delegate?.failed(interFace: self, result: data)
    }
    
    //MARK : CHECKING IS CONNECTING TO NETWORK
    func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
}


