//
//  PokemonDetailViewModel.swift
//  Pokedex
//
//  Created by Joshua Ragusin on 5/28/23.
//

import Foundation

class PokemonDetailViewModel: ObservableObject {
    @Published var pokemonStats: PokemonGameStats?
    @Published var flavorText: String?

    private let statsStore = LiveStatsStore()
    private let flavorTextAPI = LivePokedexFlavorTextAPI()
    private let flavorTextStore = LiveFlavorTextStore()
    
    let pokemon: PokemonResult
    
    init(_ pokemon: PokemonResult) {
        self.pokemon = pokemon
    }
    
    func loadStats() {
        if let stats = statsStore.stats(pokemon.id) {
            DispatchQueue.main.async {
                self.pokemonStats = stats
            }
        }
    }
    
    func loadFlavorText(completion: @escaping (PokemonFlavorText) -> Void) async {
        if let pokedexEntry = try? await flavorTextAPI.getFlavorText(for: pokemon.name) {
            DispatchQueue.main.async {
                // TODO: This is fine for now, but I would prefer to have a way of fittering out all the newlines and whitespace characters we get from the API before storing them in the DB
                self.flavorText = pokedexEntry.flavorText.replacingOccurrences(of: "\n", with: " ")
            }
            
            completion(pokedexEntry)
        }
    }
    
    func saveFlavorText(_ text: PokemonFlavorText) {
        do {
            try flavorTextStore.saveFlavorText(text)
        } catch {
            print(error)
        }
    }
    
    // MARK: - Computed Vars
    
    var typeImmunities: [PokemonTypes] {
        let immunities = pokemon.primaryTypeEnum.getDefensiveImmunities() + (pokemon.secondaryTypeEnum?.getDefensiveImmunities() ?? [PokemonTypes]())
        
        return Array(Set(immunities))
    }
    
    var typeDoubleWeaknesses: [PokemonTypes] {
        let primaryTypeWeaknesses = pokemon.primaryTypeEnum.getDefensiveWeaknesses()
        let secondaryTypeWeaknesses = pokemon.secondaryTypeEnum?.getDefensiveWeaknesses() ?? [PokemonTypes]()
        let typeWeaknesses = (primaryTypeWeaknesses + secondaryTypeWeaknesses).filter { !primaryTypeWeaknesses.contains($0) || !secondaryTypeWeaknesses.contains($0)
        }
        var weaknessSet = Set(typeWeaknesses)
                
        let resistantTypes = pokemon.primaryTypeEnum.getDefensiveResistances() + (pokemon.secondaryTypeEnum?.getDefensiveResistances() ?? [PokemonTypes]())
        let resistanceSet = Set(resistantTypes)
        
        for pokemonType in resistanceSet {
            if weaknessSet.contains(pokemonType) {
                weaknessSet.remove(pokemonType)
            }
        }
        
        return Array(weaknessSet)
    }
    
    var typeQuadrupleWeaknesses: [PokemonTypes] {
        let typeWeaknesses = pokemon.primaryTypeEnum.getDefensiveWeaknesses() + (pokemon.secondaryTypeEnum?.getDefensiveWeaknesses() ?? [PokemonTypes]())
        var weaknessSet = Set<PokemonTypes>()
        
        return typeWeaknesses.filter { !weaknessSet.insert($0).inserted }
    }
    
    var typeDoubleResistances: [PokemonTypes] {
        let primaryTypeResistances = pokemon.primaryTypeEnum.getDefensiveResistances()
        let secondaryTypeResistances = pokemon.secondaryTypeEnum?.getDefensiveResistances() ?? [PokemonTypes]()
        let typeResistances = (primaryTypeResistances + secondaryTypeResistances).filter {
            !primaryTypeResistances.contains($0) || !secondaryTypeResistances.contains($0)
        }
        var resistanceSet = Set(typeResistances)
        
        let typeWeaknesses = pokemon.primaryTypeEnum.getDefensiveWeaknesses() + (pokemon.secondaryTypeEnum?.getDefensiveWeaknesses() ?? [PokemonTypes]())
        var weaknessSet = Set(typeWeaknesses)
        
        for pokemonType in weaknessSet {
            if resistanceSet.contains(pokemonType) {
                resistanceSet.remove(pokemonType)
            }
        }
        
        return Array(resistanceSet)
    }
    
    var typeQuadrupleResistances: [PokemonTypes] {
        let typeResistances = pokemon.primaryTypeEnum.getDefensiveResistances() + (pokemon.secondaryTypeEnum?.getDefensiveResistances() ?? [PokemonTypes]())
        var resistancesSet = Set<PokemonTypes>()
        
        return typeResistances.filter { !resistancesSet.insert($0).inserted }
    }
    
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
