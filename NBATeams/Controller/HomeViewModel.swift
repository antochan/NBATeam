//
//  HomeViewModel.swift
//  NBATeams
//
//  Created by Antonio Chan on 2020/2/29.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import Foundation

struct HomeViewModel {
    private let teams: TeamData
    
    init(teams: TeamData) {
        self.teams = teams
    }
}

extension HomeViewModel {
    var listOfAllTeams: [Team] {
        return teams.data
    }
    
    /* can do filters here as well like teams with
     over X amount of wins can be another variable */
}
