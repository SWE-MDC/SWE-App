//
//  ProfileInfo.swift
//  SWE-App
//
//  Created by Becca Pratel on 11/5/23.
//

import Foundation
import SwiftUI

struct ProfileInfo: Identifiable{
    let id = UUID()
    let image: String
    let name: String
    let email: String
    let pronouns: String
    let major: String
    let year: String
    /* still need to include affinity groups */
}

let allProfiles = [
    ProfileInfo(image: "Logo", name: "Name_1", email: "Email_1", pronouns: "Pronouns_1", major: "Major_1", year: "Year_1"),
    ProfileInfo(image: "Logo", name: "Name_2", email: "Email_2", pronouns: "Pronouns_2", major: "Major_2", year: "Year_2"),
    ProfileInfo(image: "Logo", name: "Name_3", email: "Email_3", pronouns: "Pronouns_3", major: "Major_3", year: "Year_3")
]

