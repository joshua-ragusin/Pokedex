//
//  PokedexFlavorTextAPI.swift
//  Pokedex
//
//  Created by Joshua Ragusin on 5/29/23.
//

import Foundation

protocol PokedexFlavorTextAPI {
    func getFlavorText(for name: String) async throws-> PokemonFlavorText?
}

class LivePokedexFlavorTextAPI: PokedexFlavorTextAPI {
    private let baseURLString = "https://pokeapi.co/api/v2/pokemon-species"
    
    func getFlavorText(for name: String) async throws-> PokemonFlavorText? {
        let constructedURLString = baseURLString.appending("/\(name)/")
        
        guard let url = URL(string: constructedURLString) else {
            print("URL: \(constructedURLString) does not exist")
            return nil
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        if let decodedResponse = try? JSONDecoder().decode(PokemonFlavorText.self, from: data) {
            return decodedResponse
        } else {
            return nil
        }
    }
}
