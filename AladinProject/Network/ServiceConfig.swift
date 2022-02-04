//
//  ServiceConfig.swift
//  AladinProject
//
//  Created by Irfan Adika on 03/02/22.
//

import Foundation
import Alamofire

enum ServiceConfig {
    case getProduct
}

extension ServiceConfig: URLRequestConvertible {
    var baseURL: String {
        let url = "http://demo8122690.mockable.io/"
        return url
    }
    
    var path: String {
        switch self {
        case .getProduct:
            return "product"
        }
        
    }
    
    var method: HTTPMethod {
        switch self {
            
        case .getProduct:
            
            return .get
        }
    }
    
    func createUrlRequest(url: URL, param: [String: Any] = [:]) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        
        do {
            urlRequest.httpMethod = method.rawValue
            urlRequest.timeoutInterval = TimeInterval(10)
            urlRequest = try URLEncoding.default.encode(urlRequest, with: param)
        } catch {
            print("ERROR ENCODE URL REQUEST")
        }
        
        return urlRequest
    }
    
    func createUrlRequestWithParam(url: URL, param: [String: Any]) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        
        do {
            urlRequest.httpMethod = method.rawValue
            urlRequest.timeoutInterval = TimeInterval(10)
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: param)
        } catch {
            print("ERROR ENCODE URL REQUEST")
        }
        
        return urlRequest
    }
    
    //MARK : GET PARAM
    func getParam() -> [String : Any]  {
        return [:]
    }
    
    public func asURLRequest() throws -> URLRequest {
        switch self {
        case .getProduct:
            let link = baseURL + path
            let url = URL(string: link)!
            let urlRequest = createUrlRequest(url: url)
            
            return urlRequest
            
        }
    }
}

