//
//  File.swift
//  Pokedex
//
//  Created by Joshua Ragusin on 5/27/23.
//

import Foundation
import SwiftUI

enum PokemonTypes: String {
    case normal, fire, water, grass, electric, ice, fighting, poison, ground, flying, psychic, bug, rock, ghost, dark, dragon, steel, fairy
    
    var color: Color {
        switch self {
        case .normal:
            return Color.normalType
        case .fire:
            return Color.fireType
        case .water:
            return Color.waterType
        case .grass:
            return Color.grassType
        case .electric:
            return Color.electricType
        case .ice:
            return Color.iceType
        case .fighting:
            return Color.fightingType
        case .poison:
            return Color.poisonType
        case .ground:
            return Color.groundType
        case .flying:
            return Color.flyingType
        case .psychic:
            return Color.psychicType
        case .bug:
            return Color.bugType
        case .rock:
            return Color.rockType
        case .ghost:
            return Color.ghostType
        case .dark:
            return Color.darkType
        case .dragon:
            return Color.dragonType
        case .steel:
            return Color.steelType
        case .fairy:
            return Color.fairyType
        }
    }
}
