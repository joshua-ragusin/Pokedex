//
//  PokemonDetialsView.swift
//  Pokedex
//
//  Created by Joshua Ragusin on 5/27/23.
//

import SwiftUI

struct PokemonDetialsView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var model: PokemonDetailViewModel
    
    private let screen = UIScreen.main.bounds
    
    init(_ pokemon: PokemonResult) {
        _model = StateObject(wrappedValue: PokemonDetailViewModel(pokemon))
    }
    
    var body: some View {
        VStack(alignment: .center) {
            pokemonImage
            pokemonNameLabel
            typeRow
            physicalInfoRow
            statsGrid
            Spacer()
        }
        .task(priority: .background) {
            await model.loadStats()
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
        Text("Height: \(model.pokemon.height)")
    }
    
    private var weightLabel: some View {
        Text("Weight: \(model.pokemon.weight)")
    }
    
    private var typeRow: some View {
        HStack {
            typeLabel(for: model.pokemon.primaryTypeEnum)
            
            if let secondaryType = model.pokemon.secondaryTypeEnum {
                typeLabel(for: secondaryType)
            }
        }
    }
    
    private var statsGrid: some View {
        Grid {
            GridRow {
                Text("HP: \(model.hp)")
            }
            
            GridRow {
                Text("Attack: \(model.attack)")
            }
            
            GridRow {
                Text("Defense: \(model.defense)")
            }
            
            GridRow {
                Text("Special Attack: \(model.spAttack)")
            }
            
            GridRow {
                Text("Special Defense: \(model.spDefense)")
            }
            
            GridRow {
                Text("Speed: \(model.speed)")
            }
        }
    }
    
    // MARK: - Computed Vars
    
    private var imageURL: URL? {
        URL(string: model.pokemon.imageString)
    }
    
    private var pokemonNameString: String {
        "#\(model.pokemon.id). \(model.pokemon.name.properCase)"
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
