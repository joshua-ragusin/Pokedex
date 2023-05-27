//
//  PokedexListCellView.swift
//  Pokedex
//
//  Created by Joshua Ragusin on 5/26/23.
//

import SwiftUI

struct PokedexListCellView: View {
    private let pokemon: PokemonResult
    
    init(_ pokemon: PokemonResult) {
        self.pokemon = pokemon
    }
    
    var body: some View {
        Button {
            // TODO: Navigate to details page
        } label: {
            cellLabel
                .frame(maxWidth: .infinity, alignment: .leading)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
        .buttonStyle(BorderlessButtonStyle())
    }
    
    // MARK: - Computed Views
    
    private var cellLabel: some View {
        HStack {
            icon
            VStack(alignment: .leading) {
                idLabel
                nameLabel
                typeLabel
            }
        }
    }
    
    private var icon: some View {
        AsyncImage(url: imageURL) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 45, height: 45)
                .clipShape(Circle())
        } placeholder: {
            ProgressView()
        }
    }
    
    private var idLabel: some View {
        Text("#\(pokemon.id)")
    }
    
    private var nameLabel: some View {
        Text(pokemon.name.properCase)
    }
    
    // TODO: Make nicer type labels
    private var typeLabel: some View {
        HStack {
            Text(pokemon.primaryTypeEnum.rawValue.properCase)
            
            if let secondaryType = pokemon.secondaryTypeEnum {
                Text(secondaryType.rawValue.properCase)
            }
        }
    }
    
    // MARK: - Computed Vars
    
    private var imageURL: URL? {
        URL(string: pokemon.imageString)
    }
}
