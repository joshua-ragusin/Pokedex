//
//  PokemonListAPI.swift
//  Pokedex
//
//  Created by Joshua Ragusin on 5/26/23.
//

import Foundation

protocol PokemonListAPI {
    func getPokemonList() async throws -> PokemonListResult?
}

struct LivePokemonListAPI: PokemonListAPI {
    var baseURL: URL {
        URL(string: "https://pokeapi.co/api/v2/pokemon?limit=100000&offset=0")!
    }
    
    func getPokemonList() async throws -> PokemonListResult? {
        let (data, _) = try await URLSession.shared.data(from: baseURL)
        
        if let decodedResponse = try? JSONDecoder().decode(PokemonListResult.self, from: data) {
            return decodedResponse
        } else {
            return nil
        }
    }
}
