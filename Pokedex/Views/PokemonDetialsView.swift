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
    private let screen = UIScreen.main.bounds
    
    init(_ pokemon: PokemonResult) {
        self.pokemon = pokemon
    }
    
    var body: some View {
        VStack(alignment: .center) {
            pokemonImage
            pokemonNameLabel
            typeRow
            physicalInfoRow
            Spacer()
        }
    }
    
    // MARK: - Computed Views
    
    private var pokemonNameLabel: some View {
        Text(pokemonNameString)
            .font(.title)
    }
    
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
    
    private var physicalInfoRow: some View {
        HStack {
            heightLabel
            weightLabel
        }
    }
    
    private var heightLabel: some View {
        Text("Height: \(pokemon.height)")
    }
    
    private var weightLabel: some View {
        Text("Weight: \(pokemon.weight)")
    }
    
    private var typeRow: some View {
        HStack {
            typeLabel(for: pokemon.primaryTypeEnum)
            
            if let secondaryType = pokemon.secondaryTypeEnum {
                typeLabel(for: secondaryType)
            }
        }
    }
    
    // MARK: - Computed Vars
    
    private var imageURL: URL? {
        URL(string: pokemon.imageString)
    }
    
    private var pokemonNameString: String {
        "#\(pokemon.id). \(pokemon.name.properCase)"
    }
    
    // MARK: - Helper Methods
    private func typeLabel(for type: PokemonTypes) -> some View {
        ZStack {
            Rectangle()
                .cornerRadius(10)
                .frame(maxWidth: screen.width / 4 , maxHeight: 50)
                .foregroundColor(type.color)
            Text(type.rawValue.properCase)
                .foregroundColor(.white)
                .fontWeight(.bold)
        }
    }
}
