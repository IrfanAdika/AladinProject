//
//  String.swift
//  AladinProject
//
//  Created by Irfan Adika on 05/02/22.
//

import Foundation

extension String {
    func toIDR() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = NSLocale(localeIdentifier: "id_ID") as Locale?
        
        let kursNow = Float(self)
        let currency = formatter.string(from: NSNumber(value: kursNow ?? 0))
        let formatKursNow =  currency?.replacingOccurrences(of: "Rp", with: "IDR  ", options: .literal, range: nil)
        let finalIDR = formatKursNow!.replacingOccurrences(of: ",00", with: "", options: NSString.CompareOptions.literal, range:nil)
        return finalIDR
    }
}
