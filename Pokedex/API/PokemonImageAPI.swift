//
//  PokemonImageAPI.swift
//  Pokedex
//
//  Created by Joshua Ragusin on 5/26/23.
//

import Foundation
import UIKit

protocol PokemonImageAPI {
    func loadImage(from: String) async throws -> Data?
}

struct LivePokemonImageAPI: PokemonImageAPI {
    func loadImage(from urlString: String) async throws -> Data? {
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        return data
    }
}
