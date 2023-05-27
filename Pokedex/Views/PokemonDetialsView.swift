//
//  PokemonDetialsView.swift
//  Pokedex
//
//  Created by Joshua Ragusin on 5/27/23.
//

import SwiftUI

struct PokemonDetialsView: View {
    @Environment(\.dismiss) private var dismiss
    
    private let pokemon: PokemonResult
    
    init(_ pokemon: PokemonResult) {
        self.pokemon = pokemon
    }
    
    var body: some View {
        HStack {
            pokemonImage
        }
    }
    
    // MARK: - Computed Views
    
    private var pokemonImage: some View {
        AsyncImage(url: imageURL) { image in
            image
                .resizable()
                .scaledToFill()
        } placeholder: {
            ProgressView()
        }
        .frame(maxWidth: 150, maxHeight: 300)
    }
    
    // MARK: - Computed Vars
    
    private var imageURL: URL? {
        URL(string: pokemon.imageString)
    }
}
