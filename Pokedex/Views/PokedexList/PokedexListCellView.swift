//
//  PokedexListCellView.swift
//  Pokedex
//
//  Created by Joshua Ragusin on 5/26/23.
//

import SwiftUI

struct PokedexListCellView: View {
    @StateObject private var model: PokedexListCellViewModel
    @State private var showPokemonDetails = false
    
    private let screen = UIScreen.main.bounds
    
    init(_ pokemon: PokemonResult) {
        _model = StateObject(wrappedValue: PokedexListCellViewModel(pokemon))
    }
    
    var body: some View {
        HStack {
            icon
            VStack(alignment: .leading) {
                nameLabel
                idLabel
                typeRow
            }
        }
        .task {
            await model.fetchImageData()
        }
    }
    
    // MARK: - Computed Views
    
    // TODO: Make icons look better (they're too small rn)
    private var icon: some View {
        pokemonImage
            .scaledToFit()
            .frame(width: 75, height: 100)
    }
    
    private var idLabel: some View {
        Text("#\(model.pokemon.id)")
            .foregroundColor(.black)
    }
    
    private var nameLabel: some View {
        Text(model.pokemon.name.properCase)
            .foregroundColor(.black)
            .font(.title)
            .fontWeight(.medium)
    }
    
    private var typeRow: some View {
        HStack {
            typeLabel(for: model.pokemon.primaryTypeEnum)
                .frame(maxWidth: 75, maxHeight: 25)
            
            if let secondaryType = model.pokemon.secondaryTypeEnum {
                typeLabel(for: secondaryType)
                    .frame(maxWidth: 75, maxHeight: 25)
            } else {
                Spacer()
            }
        }
    }
    
    private var pokemonImage: Image {
        if let data = model.imageData,
           let image = Image(data: data) {
            return image
                .resizable()
        } else {
            return Image(systemName: "nosign")
                .resizable()
        }
    }
    
    // MARK: - Computed Vars
    
    private var imageURL: URL? {
        URL(string: model.pokemon.imageString)
    }
    
    // MARK: - Helper Methods
    private func typeLabel(for type: PokemonTypes) -> some View {
        ZStack(alignment: .center) {
            Rectangle()
                .cornerRadius(10)
                .foregroundColor(type.color)
            Text(type.rawValue.properCase)
                .foregroundColor(.white)
                .fontWeight(.bold)
        }
    }
}
