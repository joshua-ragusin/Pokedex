//
//  PokedexListView.swift
//  Pokedex
//
//  Created by Joshua Ragusin on 5/26/23.
//

import SwiftUI

struct PokedexListView: View {
    @StateObject private var model: PokedexListViewModel
    @State private var searchText = ""
    
    init() {
        _model = StateObject(wrappedValue: PokedexListViewModel())
    }
    
    var body: some View {
        NavigationStack {
            List(searchResults, id: \.id) { pokemon in
                NavigationLink(value: pokemon) {
                    PokedexListCellView(pokemon)
                }
            }
            .frame(maxWidth: .infinity)
            .listStyle(.plain)
            .navigationBarTitle("Pokedex", displayMode: .inline)
            .navigationViewStyle(.stack)
            .navigationDestination(for: PokemonResult.self) { pokemon in
                PokemonDetialsView(pokemon)
                    .navigationTitle(pokemon.name.properCase)
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        }
        .task(priority: .background) {
            await model.loadPokemonList {
                await model.load() { id in
                    model.loadPokemonFromDB(id: id)
                }
            }
        }
    }
    
    private var searchResults: [PokemonResult] {
        if searchText.isEmpty {
            return model.pokemonList
        } else {
            return model.filterPokemon(by: searchText)
        }
    }
}
