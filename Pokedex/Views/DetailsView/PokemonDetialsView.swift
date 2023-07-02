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
    private let statGridColumns = [GridItem(.fixed(75)),
                                   GridItem(.fixed(35)),
                                   GridItem()]
    
    init(_ pokemon: PokemonResult) {
        _model = StateObject(wrappedValue: PokemonDetailViewModel(pokemon))
    }
    
    var body: some View {
        ScrollView(.vertical) {
            pokemonImage
            typeRow
            
            VStack(alignment: .leading, spacing: 10) {
                pokemonNameLabel
                flavorTextLabel
                Divider()
                statsSection
                Divider()
                typeMatchupSection
                Divider()
                characteristicsSection
            }
            .frame(maxWidth: .infinity)
            .padding(.leading)
        }
        .task(priority: .background) {
            model.loadStats()
            await model.loadFlavorText { text in
                model.saveFlavorText(text)
            }
        }
    }
    
    // MARK: - Computed Views
    
    private var pokemonNameLabel: some View {
        VStack(alignment: .leading) {
            Text("#\(model.pokemon.id)")
                .font(.callout)
                .foregroundColor(.gray)
            Text(model.pokemon.name.properCase)
                .font(.title)
                .fontWeight(.bold)
        }
    }
    
    private var flavorTextLabel: some View {
        Text(model.flavorText ?? "")
            .fixedSize(horizontal: false, vertical: true)
            .foregroundColor(.gray)
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
    
    private var characteristicsSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Characteristics")
                .font(.headline)
                .fontWeight(.bold)
            heightLabel
            weightLabel
        }
    }
    
    private var typeMatchupSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Type Matchups")
                .font(.title)
                .fontWeight(.bold)
            
            if !model.typeImmunities.isEmpty {
                immunitiesSection
            }
            
            if !model.typeDoubleWeaknesses.isEmpty || !model.typeQuadrupleWeaknesses.isEmpty {
                weaknessSection
            }
            
            if !model.typeDoubleResistances.isEmpty || !model.typeQuadrupleResistances.isEmpty {
                resistanceSection
            }
        }
    }
    
    private var heightLabel: some View {
        HStack {
            Text("Height")
                .foregroundColor(model.pokemon.primaryType.color)
                .font(.subheadline)
            Text("\(Double(model.pokemon.height) / 10, specifier: "%.1f") Meters")
        }
    }
    
    private var weightLabel: some View {
        HStack {
            Text("Weight")
                .foregroundColor(model.pokemon.primaryType.color)
                .font(.subheadline)
            Text("\(Double(model.pokemon.weight) / 10, specifier: "%.1f") Kilograms")
        }
    }
    
    private var typeRow: some View {
        HStack {
            typeLabel(for: model.pokemon.primaryType)
            
            if let secondaryType = model.pokemon.secondaryType {
                typeLabel(for: secondaryType)
            }
        }
    }
    
    private var statsSection: some View {
        VStack(alignment: .leading) {
            Text("Stats")
                .font(.title)
                .fontWeight(.bold)
            hpRow
            attackRow
            defenseRow
            spAttackRow
            spDefenseRow
            speedRow
        }
    }
    
    private var hpRow: some View {
        statRow("HP", amount: model.hp)
    }
    
    private var attackRow: some View {
        statRow("ATK", amount: model.attack)
    }
    
    private var defenseRow: some View {
        statRow("DEF", amount: model.defense)
    }
    
    private var spAttackRow: some View {
        statRow("SpATK", amount: model.spAttack)
    }
    
    private var spDefenseRow: some View {
        statRow("SpDEF", amount: model.spDefense)
    }
    
    private var speedRow: some View {
        statRow("SPE", amount: model.speed)
    }
    
    private var immunitiesSection: some View {
        VStack(alignment: .leading) {
            Text("Immune to:")
                .font(.subheadline)
                .fontWeight(.bold)
            HStack {
                Text("x0")
                OverflowGrid(horizontalSpacing: 10) {
                    ForEach(model.typeImmunities, id: \.self) { pokemonType in
                        typeLabel(for: pokemonType)
                            .frame(maxWidth: 75, maxHeight: 20)
                    }
                }
            }
        }
    }
    
    private var weaknessSection: some View {
        VStack(alignment: .leading) {
            Text("Weak to:")
                .font(.subheadline)
                .fontWeight(.bold)
            if !model.typeDoubleWeaknesses.isEmpty {
                HStack {
                    Text("x2")
                    OverflowGrid(horizontalSpacing: 10) {
                        ForEach(model.typeDoubleWeaknesses, id: \.self) { pokemonType in
                            typeLabel(for: pokemonType)
                                .frame(maxWidth: 75, maxHeight: 20)
                        }
                    }
                }
            }
            
            if !model.typeQuadrupleWeaknesses.isEmpty {
                HStack {
                    Text("x4")
                    OverflowGrid(horizontalSpacing: 10) {
                        ForEach(model.typeQuadrupleWeaknesses, id: \.self) { pokemonType in
                            typeLabel(for: pokemonType)
                                .frame(maxWidth: 75, maxHeight: 20)
                        }
                    }
                }
            }
        }
    }
    
    private var resistanceSection: some View {
        VStack(alignment: .leading) {
            Text("Resistant to:")
                .font(.subheadline)
                .fontWeight(.bold)
            if !model.typeDoubleResistances.isEmpty {
                HStack {
                    Text("x\u{00BD}")
                    OverflowGrid(horizontalSpacing: 10) {
                        ForEach(model.typeDoubleResistances, id: \.self) { pokemonType in
                            typeLabel(for: pokemonType)
                                .frame(maxWidth: 75, maxHeight: 20)
                        }
                    }
                }
            }
            
            if !model.typeQuadrupleResistances.isEmpty {
                HStack {
                    Text("x\u{00BC}")
                    OverflowGrid(horizontalSpacing: 10) {
                        ForEach(model.typeQuadrupleResistances, id: \.self) { pokemonType in
                            typeLabel(for: pokemonType)
                                .frame(maxWidth: 75, maxHeight: 20)
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Computed Vars
    
    private var imageURL: URL? {
        URL(string: model.pokemon.imageString)
    }
    
    // MARK: - Helper Methods
    
    private func statRow(_ type: String, amount: Int) -> some View {
        LazyVGrid(columns: statGridColumns, alignment: .leading) {
            Text(type)
            Text("\(amount)")
            statBar(amount: Double(amount), barColor: .blue)
                .frame(height: 25)
        }
    }
    
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
        let fractionCompleted = amount / PokemonGameStats.MAX_STAT_VALUE
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
