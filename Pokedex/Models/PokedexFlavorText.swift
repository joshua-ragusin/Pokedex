//
//  PokedexFlavorText.swift
//  Pokedex
//
//  Created by Joshua Ragusin on 5/29/23.
//

import Foundation

struct PokemonFlavorText: Codable {
    let name: String
    let flavorText: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case flavorText = "flavor_text_entries"
    }
    
    enum FlavorTextContainerKeys: String, CodingKey {
        case text = "flavor_text"
    }
    
    // TODO: Fix decoder for this class (flavorText not being decoded properly)
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        let flavorTextContainers = try container.nestedContainer(keyedBy: FlavorTextContainerKeys.self, forKey: .flavorText)
        
        flavorText = try flavorTextContainers.decode(String.self, forKey: .text)
    }
}
