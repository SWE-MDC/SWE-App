//
//  Contact.swift
//  SWE-App
//
//  Created by Sam Weigman on 10/30/23.
//

import Foundation
import SwiftUI

struct Contact: Identifiable{
    let id = UUID()
    let image: String
    let name: String
    let email: String
}

let contacts = [
    Contact(image: "Logo", name: "Name_1", email: "Email_1"),
    Contact(image: "Logo", name: "Name_2", email: "Email_2"),
    Contact(image: "Logo", name: "Name_3", email: "Email_3")


]
