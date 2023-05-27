//
//  PokedexListCellView.swift
//  Pokedex
//
//  Created by Joshua Ragusin on 5/26/23.
//

import SwiftUI

struct PokedexListCellView: View {
    private let pokemon: PokemonResult
    private let screen = UIScreen.main.bounds
    
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
                typeRow
            }
        }
    }
    
    // TODO: Make icons look better (they're too small rn)
    private var icon: some View {
        AsyncImage(url: imageURL) { image in
            image
                .resizable()
                .scaledToFill()
        } placeholder: {
            ProgressView()
        }
        .frame(width: 75, height: 100)
    }
    
    private var idLabel: some View {
        Text("#\(pokemon.id)")
    }
    
    private var nameLabel: some View {
        Text(pokemon.name.properCase)
    }
    
    // TODO: Make nicer type labels
    private var typeRow: some View {
        HStack {
            typeLabel(for: pokemon.primaryTypeEnum)
//                .frame(alignment: .leading)
            
            if let secondaryType = pokemon.secondaryTypeEnum {
                typeLabel(for: secondaryType)
//                    .frame(alignment: .leading)
            } else {
                Spacer()
            }
        }
        
    }
    
    private func typeLabel(for type: PokemonTypes) -> some View {
        ZStack(alignment: .center) {
            Rectangle()
                .cornerRadius(10)
                .foregroundColor(type.color)
                .frame(maxWidth: screen.width / 4.7)
            Text(type.rawValue.properCase)
                .foregroundColor(.white)
                .fontWeight(.bold)
        }
    }
    
    // MARK: - Computed Vars
    
    private var imageURL: URL? {
        URL(string: pokemon.imageString)
    }
}
