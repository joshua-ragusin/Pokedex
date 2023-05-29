//
//  PokedexListView.swift
//  Pokedex
//
//  Created by Joshua Ragusin on 5/26/23.
//

import SwiftUI

struct PokedexListView: View {
    @StateObject private var model: PokedexListViewModel
    
    init() {
        _model = StateObject(wrappedValue: PokedexListViewModel())
    }
    
    var body: some View {
        // TODO: Fix issue where navigating away from app causes list to repeat
        NavigationView {
            NavigationStack {
                List(model.pokemonList, id: \.id) { pokemon in
                    NavigationLink(value: pokemon) {
                        PokedexListCellView(pokemon)
                    }
                }
                .frame(maxWidth: .infinity)
                .listStyle(.plain)
                .navigationBarTitle("Pokedex", displayMode: .inline)
                .navigationDestination(for: PokemonResult.self) { pokemon in
                    PokemonDetialsView(pokemon)
                        .navigationTitle(pokemon.name.properCase)
                }
            }
        }
        .task(priority: .background) {
            await model.loadPokemonList {
                await model.load() { id in
                    model.loadPokemonFromDB(id: id)
                }
            }
        }
    }
}
