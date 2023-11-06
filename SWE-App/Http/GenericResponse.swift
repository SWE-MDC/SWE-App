//
//  GenericResponse.swift
//  SWE-App
//
//  Created by Liang Geng on 11/5/23.
//

import Foundation

struct GenericResponse:Decodable {
    let status: Int
    let message: String
}
