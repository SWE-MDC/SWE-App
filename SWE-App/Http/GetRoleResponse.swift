//
//  GetRoleResponse.swift
//  SWE-App
//
//  Created by Liang Geng on 10/30/23.
//

import Foundation

struct GetRoleResponse: Decodable {
    let status: Int
    let message: String
    let role: Role
    
    enum CodingKeys : String, CodingKey {
        case status
        case message
        case role = "data"
    }
}

struct Role: Decodable {
    let id: Int
    let name: String
}
