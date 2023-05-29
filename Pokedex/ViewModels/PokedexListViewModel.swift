//
//  PokedexListViewModel.swift
//  Pokedex
//
//  Created by Joshua Ragusin on 5/26/23.
//

import Foundation

class PokedexListViewModel: ObservableObject {
    @Published var pokemonList = [PokemonResult]()
    
    private let pokemonListAPI = LivePokemonListAPI()
    private let pokemonImageAPI = LivePokemonImageAPI()
    private let pokemonResultAPI = LivePokemonResultAPI()
    
    private let pokemonStore = LivePokemonStore()
    private let pokemonImageStore = LivePokemonImageStore()
    private let statsStore = LiveStatsStore()
    
    private var pokemonListResult: PokemonListResult?
    
    func load(completion: @escaping (_ id: Int) -> Void) async {
        if let list = self.pokemonListResult {
            for networkPokemon in list.results {
                // If successful, Load each individual pokemon
                await loadPokemonResult(from: networkPokemon) { pokemon in
                    // If successful, save it to db
                    if let pokemon {
                        self.savePokemon(pokemon)
                        completion(pokemon.id)
                    }
                }
            }
        } else {
            print("LIST NOT FOUND")
        }
    }
    
    func loadPokemonList(completion: @escaping (() async -> Void)) async {
        if let _ = pokemonStore.allPokemon() {
            await completion()
        }
        
        if let list = try? await pokemonListAPI.getPokemonList() {
            self.pokemonListResult = list
            await completion()
        }
    }
    
    func loadPokemonFromDB(id: Int) {
        guard let pokemon = pokemonStore.pokemon(id: id) else {
            return
        }
        
        DispatchQueue.main.sync {
            self.pokemonList.append(pokemon)
        }
    }
    
    private func loadPokemonResult(from networkPokemon: SmallPokemonResult, completion: @escaping (PokemonResult?) async -> Void) async {
        if let pokemon = await getPokemon(networkPokemon.name) {
            await completion(pokemon)
        }
        
        if var result = try? await pokemonResultAPI.getPokemon(named: networkPokemon.name) {
            let id = result.id
            let imageURLString = result.imageString
            result.image = await loadPokemonImage(for: id, url: imageURLString)
            await completion(result)
        } else {
            await completion(nil)
        }
    }
    
    private func loadPokemonImage(for id: Int, url urlString: String) async -> PokemonImage? {
        if let imageData = try? await pokemonImageAPI.loadImage(from: urlString) {
            return PokemonImage(id: id, imageData: imageData)
        } else {
            return nil
        }
    }
    
    private func savePokemon(_ pokemon: PokemonResult) {
        do {
            try pokemonStore.savePokemon(pokemon)
            
            if let stats = pokemon.pokemonStats {
                try statsStore.saveStat(stats)
            }

            if let pokemonImage = pokemon.image {
                try pokemonImageStore.savePokemonImage(pokemonImage)
            }
        } catch {
            print(error)
        }
    }
    
    private func getPokemon(_ id: Int) async -> PokemonResult? {
        return pokemonStore.pokemon(id: id)
    }
    
    private func getPokemon(_ name: String) async -> PokemonResult? {
        return pokemonStore.pokemon(name: name)
    }
}
