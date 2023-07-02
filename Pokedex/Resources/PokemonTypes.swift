//
//  File.swift
//  Pokedex
//
//  Created by Joshua Ragusin on 5/27/23.
//

import Foundation
import SwiftUI

enum PokemonTypes: String, Identifiable {
    case normal, fire, water, grass, electric, ice, fighting, poison, ground, flying, psychic, bug, rock, ghost, dark, dragon, steel, fairy
    
    var id: Self { self }
    
    // MARK: - Defensive Type helper methods
    
    /// Returns immunities for a certian type (on defense). Ex. Ghost is immune to normal attacks, so this function returns [.normal] for .ghost
    func getDefensiveImmunities() -> [PokemonTypes] {
        switch self {
        case .normal:
            return [.ghost]
        case .fire:
            return [PokemonTypes]()
        case .water:
            return [PokemonTypes]()
        case .grass:
            return [PokemonTypes]()
        case .electric:
            return [PokemonTypes]()
        case .ice:
            return [PokemonTypes]()
        case .fighting:
            return [PokemonTypes]()
        case .poison:
            return [PokemonTypes]()
        case .ground:
            return [.electric]
        case .flying:
            return [.ground]
        case .psychic:
            return [PokemonTypes]()
        case .bug:
            return [PokemonTypes]()
        case .rock:
            return [PokemonTypes]()
        case .ghost:
            return [.normal]
        case .dark:
            return [.psychic]
        case .dragon:
            return [PokemonTypes]()
        case .steel:
            return [.poison]
        case .fairy:
            return [.dragon]
        }
    }
    
    /// Returns the defensive resistences for a given pokemon type. For example,
    /// psychic types resist fighting and psychic moves. So this method returns
    /// [.psychic, .fighting] for psychic types.
    func getDefensiveResistances() -> [PokemonTypes] {
        switch self {
        case .normal:
            return [PokemonTypes]()
        case .fire:
            return [.fire, .grass, .ice, .bug, .steel, .fairy]
        case .water:
            return [.fire, .water, .ice, .steel]
        case .grass:
            return [.water, .electric, .grass, .ground]
        case .electric:
            return [.electric, .flying, .steel]
        case .ice:
            return [.ice]
        case .fighting:
            return [.bug, .rock]
        case .poison:
            return [.grass, .fighting, .poison, .bug, .fairy]
        case .ground:
            return [.poison, .rock]
        case .flying:
            return [.grass, .fighting, .bug]
        case .psychic:
            return [.fighting, .psychic]
        case .bug:
            return [.grass, .fighting, .ground]
        case .rock:
            return [.normal, .fire, .poison, .flying]
        case .ghost:
            return [.poison, .bug]
        case .dark:
            return [.ghost, .dark]
        case .dragon:
            return [.fire, .water, .grass, .electric]
        case .steel:
            return [.normal, .grass, .ice, .flying, .psychic, .bug, .rock, .dragon, .steel, .fairy]
        case .fairy:
            return [.fighting, .dark]
        }
    }
    
    /// Returns the defensive weaknesses for a given type. For example, fairy types
    /// are weak to steel and poison mvoes. So this would return [.steel, .poison] for fairy types
    func getDefensiveWeaknesses() -> [PokemonTypes] {
        switch self {
        case .normal:
            return [.fighting]
        case .fire:
            return [.water, .ground, .rock]
        case .water:
            return [.grass, .electric]
        case .grass:
            return [.fire, .ice, .poison, .flying, .bug]
        case .electric:
            return [.ground]
        case .ice:
            return [.fire, .fighting, .rock, .steel]
        case .fighting:
            return [.psychic, .fairy, .flying]
        case .poison:
            return [.ground, .psychic]
        case .ground:
            return [.grass, .water, .ice]
        case .flying:
            return [.electric, .ice, .rock]
        case .psychic:
            return [.bug, .dark, .ghost]
        case .bug:
            return [.fire, .flying, .rock]
        case .rock:
            return [.water, .grass, .fighting, .ground]
        case .ghost:
            return [.ghost, .dark]
        case .dark:
            return [.bug, .fairy, .fighting]
        case .dragon:
            return [.ice, .dragon, .fairy]
        case .steel:
            return [.fire, .fighting, .ground]
        case .fairy:
            return [.poison, .steel]
        }
    }
    
    // MARK: - Offensive helper methods
    
    /// Returns the offensive immunities for a given type. For example, if you
    /// use a dragon type opn a fairy pokemon, it would not deal any damage
    /// because fairy is immune to dragon. So this method would return [.fairy] for dragon type.
    func getOffensiveImmunities() -> [PokemonTypes] {
        switch self {
        case .normal:
            return [.ghost]
        case .fire:
            return [PokemonTypes]()
        case .water:
            return [PokemonTypes]()
        case .grass:
            return [PokemonTypes]()
        case .electric:
            return [.ground]
        case .ice:
            return [PokemonTypes]()
        case .fighting:
            return [.ghost]
        case .poison:
            return [.steel]
        case .ground:
            return [.flying]
        case .flying:
            return [PokemonTypes]()
        case .psychic:
            return [.dark]
        case .bug:
            return [PokemonTypes]()
        case .rock:
            return [PokemonTypes]()
        case .ghost:
            return [.normal]
        case .dark:
            return [PokemonTypes]()
        case .dragon:
            return [.fairy]
        case .steel:
            return [PokemonTypes]()
        case .fairy:
            return [PokemonTypes]()
        }
    }
    
    func getOffensiveResistences() -> [PokemonTypes] {
        switch self {
        case .normal:
            return [.rock, .steel]
        case .fire:
            return [.fire, .water, .rock, .dragon]
        case .water:
            return [.water, .grass, .dragon]
        case .grass:
            return [.fire, .grass, .poison, .flying, .bug, .dragon, .steel]
        case .electric:
            return [.electric, .grass, .dragon]
        case .ice:
            return [.fire, .water, .ice, .steel]
        case .fighting:
            return [.psychic, .poison, .flying, .bug, .fairy]
        case .poison:
            return [.poison, .ground, .rock, .ghost]
        case .ground:
            return [.grass, .bug]
        case .flying:
            return [.electric, .rock, .steel]
        case .psychic:
            return [.psychic, .steel]
        case .bug:
            return [.fire, .fighting, .poison, .flying, .ghost, .steel, .fairy]
        case .rock:
            return [.fighting, .ground, .steel]
        case .ghost:
            return [.dark]
        case .dark:
            return [.fighting, .dark, .fairy]
        case .dragon:
            return [.steel]
        case .steel:
            return [.fire, .water, .electric, .steel]
        case .fairy:
            return [.fire, .poison, .steel]
        }
    }
    
    /// Returns the offensive super effective types for a given type. Ex, psychic moves
    /// are super effective against opoison and fighting. So this method returns
    /// [.poison, .fighting] for psychic types.
    func getOffensiveSuperEffectiveTypes() -> [PokemonTypes] {
        switch self {
        case .normal:
            return [PokemonTypes]()
        case .fire:
            return [.grass, .ice, .bug, .steel]
        case .water:
            return [.fire, .rock, .ground]
        case .grass:
            return [.water, .ground, .rock]
        case .electric:
            return [.water, .flying]
        case .ice:
            return [.grass, .ground, .flying, .dragon]
        case .fighting:
            return [.normal, .dark, .ice, .steel, .rock]
        case .poison:
            return [.grass, .fairy]
        case .ground:
            return [.fire, .electric, .poison, .rock, .steel]
        case .flying:
            return [.grass, .fighting, .bug]
        case .psychic:
            return [.fighting, .poison]
        case .bug:
            return [.psychic, .grass, .dark]
        case .rock:
            return [.flying, .ice, .fire, .bug]
        case .ghost:
            return [.psychic, .ghost]
        case .dark:
            return [.psychic, .ghost]
        case .dragon:
            return [.dragon]
        case .steel:
            return [.ice, .rock, .fairy]
        case .fairy:
            return [.fighting, .dragon, .dark]
        }
    }
    
    var color: Color {
        switch self {
        case .normal:
            return .normalType
        case .fire:
            return .fireType
        case .water:
            return .waterType
        case .grass:
            return .grassType
        case .electric:
            return .electricType
        case .ice:
            return .iceType
        case .fighting:
            return .fightingType
        case .poison:
            return .poisonType
        case .ground:
            return .groundType
        case .flying:
            return .flyingType
        case .psychic:
            return .psychicType
        case .bug:
            return .bugType
        case .rock:
            return .rockType
        case .ghost:
            return .ghostType
        case .dark:
            return .darkType
        case .dragon:
            return .dragonType
        case .steel:
            return .steelType
        case .fairy:
            return .fairyType
        }
    }
}
