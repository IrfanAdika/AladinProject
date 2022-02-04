//
//  CartEntity.swift
//  AladinProject
//
//  Created by Irfan Adika on 04/02/22.
//

import Foundation
import RealmSwift
import Realm

@objcMembers class CartEntity: Object, Decodable {
    @objc dynamic var id: Int = 0
    @objc dynamic var idProduct: Int = 0
    @objc dynamic var totalItem: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case id
        case idProduct
        case totalItem
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        idProduct = try container.decode(Int.self, forKey: .idProduct)
        totalItem = try container.decode(Int.self, forKey: .totalItem)
        
        super.init()
    }
    
    required override init() {
        super.init()
    }
}
