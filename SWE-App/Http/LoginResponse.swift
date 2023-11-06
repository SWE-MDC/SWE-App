//
//  LoginResponse.swift
//  SWE-App
//
//  Created by Liang Geng on 10/30/23.
//

import Foundation

public class LoginResponse: Decodable {
    let status: Int
    let message: String
    let token: String?
    let role: Role?
    
    public enum CodingKeys : String, CodingKey {
        case status
        case message
        case token
        case role
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decode(Int.self, forKey: .status)
        self.message = try container.decode(String.self, forKey: .message)
        self.token = try container.decodeIfPresent(String.self, forKey: .token)
        self.role = try container.decodeIfPresent(Role.self, forKey: .role)
    }
}
