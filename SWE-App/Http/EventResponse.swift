//
//  Event.swift
//  SWE-App
//
//  Created by Liang Geng on 10/30/23.
//

import Foundation
import SwiftUI

/**
 
 {
 "status": 200,
 "message": "",
 "events": [
 {
 "id": 2,
 "title": "Test event 2",
 "details": "No details really",
 "date": "November 11, 2023 11:11",
 "location": "DreeseLab",
 "organizer": "Liang Geng",
 "eventCode": "916013",
 "group": "Asian Connections"
 },
 {
 "id": 1,
 "title": "Test event",
 "details": "No details really",
 "date": "October 10, 2023 10:10",
 "location": "I really don't know where it takes place",
 "organizer": "Liang Geng",
 "eventCode": "841594",
 "group": "African-American"
 }
 ]
 }
 */

struct EventResponse: Decodable {
    let status: Int
    let message: String
    let events: [Event]
}

public class Event: Identifiable, Decodable {
    public let id: Int
    let title: String
    let details: String
    let date: String
    let location: String
    let organizer: String
    let eventCode: String
    let group: String?
    
    public enum CodingKeys : String, CodingKey {
        case id
        case title
        case details
        case date
        case location
        case organizer
        case eventCode
        case group
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.details = try container.decode(String.self, forKey: .details)
        self.date = try container.decode(String.self, forKey: .date)
        self.location = try container.decode(String.self, forKey: .location)
        self.organizer = try container.decode(String.self, forKey: .organizer)
        self.eventCode = try container.decode(String.self, forKey: .eventCode)
        self.group = try container.decodeIfPresent(String.self, forKey: .group)
    }
}

//var events = [
//    Event(title: "Event1", date: "2023 Oct 10", location: "Loc 1"),
//    Event(title: "Event2", date: "2023 Oct 20", location: "Loc 2"),
//    Event(title: "Event3", date: "2023 Oct 30", location: "Loc 3"),
//]

//var events = [Event]()
