//
//  PokemonImage.swift
//  Pokedex
//
//  Created by Joshua Ragusin on 5/28/23.
//

import Foundation
import GRDB

struct PokemonImage: Hashable, Codable {
    let id: Int
    let imageData: Data
}

extension PokemonImage: TableRecord, FetchableRecord, PersistableRecord {
    static var databaseTableName = "pokemonImage"
    
    enum Columns: String, SQLSpecificExpressible {
        case id, imageData
    }
}
