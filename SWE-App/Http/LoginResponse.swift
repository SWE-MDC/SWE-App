//
//  LoginResponse.swift
//  SWE-App
//
//  Created by Liang Geng on 10/30/23.
//

import Foundation

struct LoginResponse: Decodable {
    let status: Int
    let message: String
    let token: String
}
