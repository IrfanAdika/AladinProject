//
//  RealmManager.swift
//  AladinProject
//
//  Created by Irfan Adika on 04/02/22.
//

import Foundation
import RealmSwift
import Realm

class RealmManager: NSObject {
    
    static let shared = RealmManager()

    let realm = try! Realm()
    
    var products: Results<ProductEntity>?
    var cart: Results<CartEntity>?
    
    func loadRealmObject() {
        products = realm.objects(ProductEntity.self)
        cart = realm.objects(CartEntity.self)
    }
    
    func retrieveAllDataObject(_ T : Object.Type) -> [Object] {
        var objects = [Object]()
        for result in realm.objects(T) {
            objects.append(result)
        }
        
        return objects
    }
    
    func deleteAllDataObject(_ T : Object.Type) {
        self.delete(self.retrieveAllDataObject(T))
    }
    
    func delete(_ objects : [Object]) {
        
        try! realm.write{
            realm.delete(objects)
        }
    }
    
    func delete(_ objects : Object) {
        
        try! realm.write{
            realm.delete(objects)
        }
    }
    
    func add(_ objects : Object) {
        
        try! realm.write{
            
            realm.add(objects)
        }
    }
    
    func add(_ objects: [Object]) {
        try! realm.write{
            
            realm.add(objects)
        }
    }
    
    func getProductById(idProduct: Int) -> ProductEntity? {
        if let item = RealmManager.shared.products?.filter("idProduct == \(idProduct)"), !item.isEmpty {
            return item.first
        }
        return nil
    }
    
    func getCartById(idProduct: Int) -> CartEntity? {
        if let item = RealmManager.shared.cart?.filter("idProduct == \(idProduct)"), !item.isEmpty {
            return item.first
        }
        return nil
    }
    
//    func deleteCartById() {
//        if let items = menuCategoriesByBrand {
//            for result in items {
//               try! realm.write{
//                    realm.cascadeDelete(result)
//                }
//            }
//        }
//    }
    
    func updateCartItemCount(_ cart: CartEntity, _ total: Int) {
        do {
            try realm.write {
                cart.totalItem = total
            }
        } catch {
            print("ERROR UPDATING CURRENT TOTAL DELIVERED ORDER: \(error)")
        }
    }
}
