//
//  ProductEntity.swift
//  AladinProject
//
//  Created by Irfan Adika on 03/02/22.
//

import Foundation
import Realm
import RealmSwift

@objcMembers class ProductEntity: Object, Decodable {
    @objc dynamic var idProduct: Int = 0
    @objc dynamic var imageUrlProduct: String = ""
    @objc dynamic var titleProduct: String = ""
    @objc dynamic var descriptionProduct: String = ""
    @objc dynamic var priceProduct: Float = 0
    
    enum CodingKeys: String, CodingKey {
        case idProduct = "id"
        case imageUrlProduct = "image_url"
        case titleProduct = "title"
        case descriptionProduct = "description"
        case priceProduct = "price"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        idProduct = try container.decode(Int.self, forKey: .idProduct)
        imageUrlProduct = try container.decode(String.self, forKey: .imageUrlProduct)
        titleProduct = try container.decode(String.self, forKey: .titleProduct)
        descriptionProduct = try container.decode(String.self, forKey: .descriptionProduct)
        priceProduct = try container.decode(Float.self, forKey: .priceProduct)
        
        super.init()
    }
    
    required override init() {
        super.init()
    }
}
