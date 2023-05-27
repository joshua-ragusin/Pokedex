//
//  PokemonResultAPI.swift
//  Pokedex
//
//  Created by Joshua Ragusin on 5/26/23.
//

import Foundation

protocol PokemonResultAPI {
    func getPokemon(named: String) async throws -> PokemonResult?
}

struct LivePokemonResultAPI: PokemonResultAPI {
    
    private let baseURLString = "https://pokeapi.co/api/v2"
    
    func getPokemon(named name: String) async throws -> PokemonResult? {
        let constructedURLString = baseURLString.appending("/pokemon/\(name)/")
        guard let url = URL(string: constructedURLString) else {
            print("URL: \(constructedURLString) does not exist")
            return nil
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        if let decodedResponse = try? JSONDecoder().decode(PokemonResult.self, from: data) {
            return decodedResponse
        } else {
            return nil
        }
    }
}
