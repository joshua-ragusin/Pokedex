//
//  PokemonDetailViewModel.swift
//  Pokedex
//
//  Created by Joshua Ragusin on 5/28/23.
//

import Foundation

class PokemonDetailViewModel: ObservableObject {
    @Published var pokemonStats: Stats? = nil

    private var statsStore = LiveStatsStore()
    
    let pokemon: PokemonResult
    
    init(_ pokemon: PokemonResult) {
        self.pokemon = pokemon
    }
    
    func loadStats() async {
        if let stats = await statsStore.stats(pokemon.id) {
            DispatchQueue.main.async {
                self.pokemonStats = stats
            }
        }
    }
    
    
    // MARK: - Computed Vars
    
    var hp: Int {
        if let stats = pokemonStats {
            return stats.hp
        } else {
            return 0
        }
    }
    
    var attack: Int {
        if let stats = pokemonStats {
            return stats.attack
        } else {
            return 0
        }
    }
    
    var defense: Int {
        if let stats = pokemonStats {
            return stats.defense
        } else {
            return 0
        }
    }
    
    var spAttack: Int {
        if let stats = pokemonStats {
            return stats.spAttack
        } else {
            return 0
        }
    }
    
    var spDefense: Int {
        if let stats = pokemonStats {
            return stats.spDefense
        } else {
            return 0
        }
    }
    
    var speed: Int {
        if let stats = pokemonStats {
            return stats.speed
        } else {
            return 0
        }
    }
}
