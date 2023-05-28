//
//  PokemonNetworkStat.swift
//  Pokedex
//
//  Created by Joshua Ragusin on 5/28/23.
//

import Foundation

struct PokemonNetworkStatResult: Codable, Hashable {
    let base_stat: Int
    let effort: Int
    let stat: PokemonNetworkStat
}

struct PokemonNetworkStat: Codable, Hashable {
    let name: String
    let url: String
}
