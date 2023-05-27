//
//  PokedexListViewModel.swift
//  Pokedex
//
//  Created by Joshua Ragusin on 5/26/23.
//

import Foundation

class PokedexListViewModel: ObservableObject {
    @Published var pokemon = [PokemonResult]()
    
    private let pokemonListAPI = LivePokemonListAPI()
    private let pokemonResultAPI = LivePokemonResultAPI()
    
    func loadPokemon() async {
        if let list = try? await pokemonListAPI.getPokemonList(){
            for smallPokemon in list.results {
                if let result = await loadPokemonResult(from: smallPokemon) {
                    DispatchQueue.main.async {
                        self.pokemon.append(result)
                    }
                }
            }
        }
    }
    
    private func loadPokemonResult(from networkPokemon: SmallPokemonResult) async -> PokemonResult? {
        return try? await pokemonResultAPI.getPokemon(named: networkPokemon.name)
    }
}
