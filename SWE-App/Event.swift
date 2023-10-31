//
//  Event.swift
//  SWE-App
//
//  Created by Sam Weigman on 10/31/23.
//

import Foundation
import SwiftUI

struct Events: Identifiable{
    let id = UUID()
    let name: String
    let date: String
    let time: String
    let location: String

}


let events = [
    Events(name: "event_1", date: "date_1", time: "time_1", location: "location_1"),
    Events(name: "event_2", date: "date_2", time: "time_2", location: "location_2"),
    Events(name: "event_3", date: "date_3", time: "time_3", location: "location_3")

]
