//
//  PokemonType.swift
//  Pokedex
//
//  Created by Joshua Ragusin on 5/28/23.
//

import Foundation

struct PokemonTypeResult: Codable {
    let slot: Int
    let type: PokemonTypeModel
}

struct PokemonTypeModel: Codable {
    let name: String
    let url: String
}
