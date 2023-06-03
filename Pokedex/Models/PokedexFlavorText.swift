//
//  PokedexFlavorText.swift
//  Pokedex
//
//  Created by Joshua Ragusin on 5/29/23.
//

import Foundation
import GRDB

struct PokemonFlavorText: Codable {
    let name: String
    let flavorText: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case flavorText = "flavor_text_entries"
    }
    
    enum FlavorTextKeys: String, CodingKey {
        case text = "flavor_text"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let flavorTexts = try container.decode([FlavorTextContainer].self, forKey: .flavorText)
        name = try container.decode(String.self, forKey: .name)
    
        flavorText = flavorTexts.first { $0.language.name == "en" }?.flavor_text ?? ""
    }
}

extension PokemonFlavorText: TableRecord, FetchableRecord, PersistableRecord {
    static var databaseTableName = "flavorText"
    
    enum Column: String, SQLSpecificExpressible {
        case name, flavorText
    }
    
    init(row: Row) throws {
        name = row[Column.name.rawValue]
        flavorText = row[Column.flavorText.rawValue]
    }
}

struct FlavorTextContainer: Codable {
    let flavor_text: String
    let language: Language
}

struct Language: Codable {
    let name: String
    let url: String
}
