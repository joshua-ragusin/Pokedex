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
    private let pokemonImageAPI = LivePokemonImageAPI()
    private let pokemonResultAPI = LivePokemonResultAPI()
    
    private let pokemonStore = LivePokemonStore()
    private let pokemonImageStore = LivePokemonImageStore()
    private let statsStore = LiveStatsStore()
    
    func loadPokemon() async {
        if let list = try? await pokemonListAPI.getPokemonList(){
            for smallPokemon in list.results {
                if let result = await loadPokemonResult(from: smallPokemon) {
//                    self.savePokemon(result)
                    
//                    if let savedPokemon = await self.getPokemon(result.id) {
                        DispatchQueue.main.async {
                            self.pokemon.append(result)
                        }
//                    }
                }
            }
        }
    }
    
    private func loadPokemonResult(from networkPokemon: SmallPokemonResult) async -> PokemonResult? {
        if let result = try? await pokemonResultAPI.getPokemon(named: networkPokemon.name) {
            await savePokemon(result)
        return result
        } else {
            return nil
        }
    }
    
//    private func loadPokemonImage(for id: Int, url urlString: String) async -> PokemonImage? {
//        if let imageData = try? await pokemonImageAPI.loadImage(from: urlString) {
//            return PokemonImage(id: id, imageData: imageData)
//        } else {
//            return nil
//        }
//    }
    
    private func savePokemon(_ pokemon: PokemonResult) async {
        do {
            try await pokemonStore.savePokemon(pokemon)
            
//            if let stats = pokemon.pokemonStats {
//                try statsStore.saveStat(stats)
//            }
//
//            if let pokemonImage = pokemon.image {
//                try pokemonImageStore.savePokemonImage(pokemonImage)
//            }
        } catch {
            print(error)
        }
    }
    
    private func getPokemon(_ id: Int) async -> PokemonResult? {
        return await pokemonStore.pokemon(id: id)
    }
}
