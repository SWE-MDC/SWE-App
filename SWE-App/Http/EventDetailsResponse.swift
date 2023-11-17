//
//  EventDetailsResponse.swift
//  SWE-App
//
//  Created by Liang Geng on 11/16/23.
//
import Foundation

/**
 {
   "status": 200,
   "message": "",
   "eventDetail": {
     "userId": 7,
     "eventId": 2,
     "title": "Test event 2",
     "details": "No details really",
     "date": "November 11, 2023 11:11",
     "status": 2,
     "showUp": 1,
     "comments": "",
     "location": "DreeseLab",
     "organizer": "Liang Geng",
     "eventCode": "916013"
   }
 }
 */

struct EventDetailsResponse: Decodable {
    let status: Int
    let message: String
    let eventDetails: EventDetails
}

struct EventDetails: Decodable {
    let userId: Int
    let eventId: Int
    let title: String
    let details: String
    let date: String
    let status: Int
    let showUp: Int
    let comments: String
    let location: String
    let organizer: String
    let eventCode: String
    
    init() {
        userId = 0
        eventId = 0
        title = ""
        details = ""
        date = ""
        status = 0
        showUp = 0
        comments = ""
        location = ""
        organizer = ""
        eventCode = ""
    }
}
