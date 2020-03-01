//
//  Team.swift
//  NBATeams
//
//  Created by Antonio Chan on 2020/2/29.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import Foundation

struct TeamData: Codable {
    let data: [Team]
}

struct Team: Codable {
    let id: Int
    let abbreviation: String
    let city: String
    let conference: String
    let division: String
    let full_name: String
    let name: String
}
