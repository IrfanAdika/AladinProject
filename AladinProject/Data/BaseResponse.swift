//
//  BaseResponse.swift
//  AladinProject
//
//  Created by Irfan Adika on 03/02/22.
//

struct BaseResponse<T : Decodable> : Decodable {
    let code: Int?
    var status: Bool = false
    let message: String?
    let data: T
}
