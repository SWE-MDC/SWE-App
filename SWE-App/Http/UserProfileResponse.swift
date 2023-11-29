//
//  UserProfileResponse.swift
//  SWE-App
//
//  Created by Liang Geng on 11/29/23.
//

import Foundation

/**
 {
   "id": 7,
   "firstName": "Liang",
   "lastName": "Geng",
   "email": "geng.161@buckeyemail.osu.edu",
   "username": "geng.161",
   "pronouns": null,
   "year": 0,
   "major": null
 }
 */

public class UserProfileResponse: Decodable {
    let id: Int
    let firstName: String?
    let lastName: String?
    let email: String
    let username: String
    let pronouns: String?
    let year: String?
    let major: String?
    
    public enum CodingKeys : String, CodingKey {
        case id
        case firstName
        case lastName
        case email
        case username
        case pronouns
        case year
        case major
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.firstName = try container.decodeIfPresent(String.self, forKey: .firstName)
        self.lastName = try container.decodeIfPresent(String.self, forKey: .lastName)
        self.email = try container.decode(String.self, forKey: .email)
        self.username = try container.decode(String.self, forKey: .username)
        self.pronouns = try container.decodeIfPresent(String.self, forKey: .pronouns)
        self.year = try container.decodeIfPresent(String.self, forKey: .year)
        self.major = try container.decodeIfPresent(String.self, forKey: .major)
    }
    
    public init() {
        id = 0
        firstName = ""
        lastName = ""
        email = ""
        username = ""
        pronouns = ""
        year = ""
        major = ""
    }
}

