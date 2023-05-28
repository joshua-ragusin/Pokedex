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
            statsGrid
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
    
    private var statsGrid: some View {
        Grid {
            GridRow {
                Text("HP: \(hpValue)")
            }
            
            GridRow {
                Text("Attack: \(attackValue)")
            }
            
            GridRow {
                Text("Defense: \(defenseValue)")
            }
            
            GridRow {
                Text("Special Attack: \(spAttackValue)")
            }
            
            GridRow {
                Text("Special Defense: \(spDefenseValue)")
            }
            
            GridRow {
                Text("Speed: \(speedValue)")
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
    
    private var hpValue: Int {
        pokemon.pokemonStats?.hp ?? 0
    }
    
    private var attackValue: Int {
        pokemon.pokemonStats?.attack ?? 0
        
    }
    
    private var defenseValue: Int {
        pokemon.pokemonStats?.defense ?? 0
    }
    
    private var spAttackValue: Int {
        pokemon.pokemonStats?.spAttack ?? 0
    }
    
    private var spDefenseValue: Int {
        pokemon.pokemonStats?.spDefense ?? 0
    }
    
    private var speedValue: Int {
        pokemon.pokemonStats?.speed ?? 0
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
