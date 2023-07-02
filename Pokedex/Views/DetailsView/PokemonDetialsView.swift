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
            
            VStack(alignment: .leading) {
                pokemonNameLabel
                flavorTextLabel
//                physicalInfoRow
                statsSection
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
        // TODO: Flavor text isn't expanding horizontally. Possible due to ScrollView (?)
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
