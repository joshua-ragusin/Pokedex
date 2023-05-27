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
        NavigationView {
            List(model.pokemon, id: \.id) { pokemon in
                LazyVStack(alignment: .leading) {
                    PokedexListCellView(pokemon)
                    Divider()
                }
            }
            .navigationBarTitle("Pokedex", displayMode: .inline)
            .task {
                await model.loadPokemon()
            }
        }
    }
}
