//
//  PokemonListCellViewModel.swift
//  Pokedex
//
//  Created by Joshua Ragusin on 5/28/23.
//

import Foundation

class PokedexListCellViewModel: ObservableObject {
    @Published var imageData: Data?
    
    let pokemon: PokemonResult
    
    private let pokemonImageStore = LivePokemonImageStore()
    
    init(_ pokemon: PokemonResult) {
        self.pokemon = pokemon
    }
    
    func fetchImageData() async {
        if let pokemonImage = await pokemonImageStore.pokemonImage(pokemon.id) {
            DispatchQueue.main.async {
                self.imageData = pokemonImage.imageData
            }
        }
    }
}
