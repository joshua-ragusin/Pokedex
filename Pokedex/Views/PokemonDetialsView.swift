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
    private let statGridColumns = [GridItem(.fixed(75)), GridItem(.fixed(35)), GridItem()]
    
    init(_ pokemon: PokemonResult) {
        _model = StateObject(wrappedValue: PokemonDetailViewModel(pokemon))
    }
    
    var body: some View {
        VStack(alignment: .center) {
            pokemonImage
            pokemonNameLabel
            typeRow
            physicalInfoRow
            statsSection
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
    
    private var statsSection: some View {
        VStack(alignment: .leading) {
            Text("Stats")
                .font(.title)
                .fontWeight(.bold)
                .padding(.leading)
            hpRow
            attackRow
            defenseRow
            spAttackRow
            spDefenseRow
            speedRow
        }
    }
    
    // TODO: This can just be 1 function ...
    private var hpRow: some View {
        LazyVGrid(columns: statGridColumns) {
            Text("HP")
            Text("\(model.hp)")
            statBar(amount: Double(model.hp), barColor: .blue)
                .frame(height: 25)
        }
    }
    
    private var attackRow: some View {
        LazyVGrid(columns: statGridColumns) {
            Text("ATK")
            Text("\(model.attack)")
            statBar(amount: Double(model.attack), barColor: .blue)
                .frame(height: 25)
        }
    }
    
    private var defenseRow: some View {
        LazyVGrid(columns: statGridColumns) {
            Text("DEF")
            Text("\(model.defense)")
            statBar(amount: Double(model.defense), barColor: .blue)
                .frame(height: 25)
        }
    }
    
    private var spAttackRow: some View {
        LazyVGrid(columns: statGridColumns) {
            Text("SpATK")
            Text("\(model.spAttack)")
            statBar(amount: Double(model.spAttack), barColor: .blue)
                .frame(height: 25)
        }
    }
    
    private var spDefenseRow: some View {
        LazyVGrid(columns: statGridColumns) {
            Text("SpDEF")
            Text("\(model.spDefense)")
            statBar(amount: Double(model.spDefense), barColor: .blue)
                .frame(maxHeight: 25)
        }
    }
    
    private var speedRow: some View {
        LazyVGrid(columns: statGridColumns) {
            Text("SPE")
            Text("\(model.speed)")
            statBar(amount: Double(model.speed), barColor: .blue)
                .frame(height: 25)
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
    
    private func statBar(amount: Double, barColor: Color) -> some View {
        let fractionCompleted = amount / Stats.MAX_STAT_VALUE
        return GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width, height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(.gray)
                Rectangle().frame(width: fractionCompleted * geometry.size.width, height: geometry.size.height)
                    .foregroundColor(barColor)
            }
            .cornerRadius(45.0)
        }
    }
}
