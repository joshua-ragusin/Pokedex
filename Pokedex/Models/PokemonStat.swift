//
//  PokemonStat.swift
//  Pokedex
//
//  Created by Joshua Ragusin on 5/27/23.
//

import Foundation

struct PokemonStat: Hashable, Codable {
    let name: String
    let value: Int
    let effortYield: Int
    
    init(_ networkStat: PokemonNetworkStatResult) {
        self.name = networkStat.stat.name
        self.value = networkStat.base_stat
        self.effortYield = networkStat.effort
    }
    
    init(_ stat: BattleStats) {
        self.name = stat.rawValue
        self.value = 0
        self.effortYield = 0
    }
}
