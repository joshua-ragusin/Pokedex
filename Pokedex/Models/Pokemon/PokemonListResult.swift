//
//  PokemonListResult.swift
//  Pokedex
//
//  Created by Joshua Ragusin on 5/26/23.
//

import Foundation

struct PokemonListResult: Codable {
    let count: Int
    let results: [SmallPokemonResult]
}
