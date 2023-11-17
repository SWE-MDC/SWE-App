//
//  AttendeesResponse.swift
//  SWE-App
//
//  Created by Liang Geng on 11/16/23.
//

import Foundation

struct AttendeesResponse: Decodable {
    let status: Int
    let message: String
    let notDecided: Int
    let accept: Int
    let reject: Int
    let showUp: Int
    let attendees: [Attendee]
}


public class Attendee: Identifiable, Decodable {
    public let id: Int
    let email: String
    let firstName: String?
    let lastName: String?
    let status: Int
    let showUp: Int
    let comments: String?

    
    public enum CodingKeys : String, CodingKey {
        case id
        case email
        case firstName
        case lastName
        case status
        case showUp
        case comments
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.email = try container.decode(String.self, forKey: .email)
        self.firstName = try container.decodeIfPresent(String.self, forKey: .firstName)
        self.lastName = try container.decodeIfPresent(String.self, forKey: .lastName)
        self.status = try container.decode(Int.self, forKey: .status)
        self.showUp = try container.decode(Int.self, forKey: .showUp)
        self.comments = try container.decodeIfPresent(String.self, forKey: .comments)
    }
}
