//
//  PokemonResult.swift
//  Pokedex
//
//  Created by Joshua Ragusin on 5/26/23.
//

import Foundation
import GRDB
import UIKit

struct PokemonResult: Hashable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let imageString: String
    let primaryTypeString: String
    let secondaryTypeString: String?
    let favorite: Bool
    
    
    var pokemonStats: PokemonGameStats? = nil
    var image: PokemonImage? = nil
    
    init(id: Int, name: String, height: Int, weight: Int, imageString: String, primaryType: String, secondaryType: String?, favorite: Bool = false) {
        self.id = id
        self.name = name
        self.height = height
        self.weight = weight
        self.imageString = imageString
        self.primaryTypeString = primaryType
        self.secondaryTypeString = secondaryType
        self.favorite = favorite
    }
    
    // MARK: - Computed Vars
    
    var primaryType: PokemonTypes {
        if let type = PokemonTypes(rawValue: primaryTypeString) {
            return type
        } else {
            return .normal
        }
    }
    
    var secondaryType: PokemonTypes? {
        if let secondaryTypeString,
           let type = PokemonTypes(rawValue: secondaryTypeString) {
            return type
        } else {
            return nil
        }
    }
    // MARK: - Functions
    
    // For hashable
    static func == (lhs: PokemonResult, rhs: PokemonResult) -> Bool {
        lhs.id == rhs.id
    }
}

extension PokemonResult: Codable {
    enum PokemonKeys: String, CodingKey {
        case id, name, height, weight, sprites, types, stats
    }
    
    enum SpriteKeys: String, CodingKey {
        case imageString = "front_default"
    }
    
    enum PokemonTypeResultsKeys: String, CodingKey {
        case slot, type
    }

    enum PokemonTypeKeys: String, CodingKey {
        case name, url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PokemonKeys.self)
        let spriteContainer = try container.nestedContainer(keyedBy: SpriteKeys.self, forKey: .sprites)
        let types = try container.decode([PokemonTypeResult].self, forKey: .types)
        let stats = try container.decode([PokemonNetworkStatResult].self, forKey: PokemonKeys.stats)
        
        let id = try container.decode(Int.self, forKey: .id)
        
        self.id = id
        name = try container.decode(String.self, forKey: .name)
        height = try container.decode(Int.self, forKey: .height)
        weight = try container.decode(Int.self, forKey: .weight)
        
        imageString = try spriteContainer.decode(String.self, forKey: .imageString)
        
        primaryTypeString = types[0].type.name
        
        if let secondType = types.last,
           secondType.type.name != primaryTypeString {
            secondaryTypeString = secondType.type.name
        } else {
            secondaryTypeString = nil
        }
        
        var decodedStats = [PokemonStat]()
        for stat in stats {
            decodedStats.append(PokemonStat(stat))
        }
        
        favorite = false
        pokemonStats = decodeStats(from: decodedStats, for: id)
    }
    
    private func decodeStats(from pokemonStats: [PokemonStat], for id: Int) -> PokemonGameStats {
        let hp = pokemonStats.first { $0.name == BattleStats.hp.rawValue }
            .map { $0.value } ?? 0
        let attack = pokemonStats.first { $0.name == BattleStats.attack.rawValue }
            .map { $0.value } ?? 0
        let defense = pokemonStats.first { $0.name == BattleStats.defense.rawValue }
            .map { $0.value } ?? 0
        let spAttack = pokemonStats.first { $0.name == BattleStats.spAttack.rawValue }
            .map { $0.value } ?? 0
        let spDefense = pokemonStats.first { $0.name == BattleStats.spDefense.rawValue }
            .map { $0.value } ?? 0
        let speed = pokemonStats.first { $0.name == BattleStats.speed.rawValue }
            .map { $0.value } ?? 0
        return PokemonGameStats(id: id, hp: hp, attack: attack, defense: defense, spAttack: spAttack, spDefense: spDefense, speed: speed)
    }
}

extension PokemonResult: TableRecord, FetchableRecord, PersistableRecord {
    static var databaseTableName = "pokemon"
    
    enum Column: String, SQLSpecificExpressible {
        case id, name, primaryType, secondaryType, height, weight, imageString, favorite
    }
    
    init(row: Row) throws {
        id = row[Column.id.rawValue]
        name = row[Column.name.rawValue]
        primaryTypeString = row[Column.primaryType.rawValue]
        secondaryTypeString = row[Column.secondaryType.rawValue]
        height = row[Column.height.rawValue]
        weight = row[Column.weight.rawValue]
        imageString = row[Column.imageString.rawValue]
        favorite = row[Column.favorite.rawValue]
    }
}

extension PokemonResult: Comparable {
    static func < (lhs: PokemonResult, rhs: PokemonResult) -> Bool {
        return lhs.name < rhs.name
    }
}
