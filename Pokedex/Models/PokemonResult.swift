//
//  PokemonResult.swift
//  Pokedex
//
//  Created by Joshua Ragusin on 5/26/23.
//

import Foundation
import GRDB

struct PokemonResult: Codable, Hashable, FetchableRecord {
    let uuid = UUID()
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    
    let imageString: String
    
    let primaryType: String
    let secondaryType: String?
    
    let battleStats: [PokemonStat]
    
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
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        height = try container.decode(Int.self, forKey: .height)
        weight = try container.decode(Int.self, forKey: .weight)
        
        imageString = try spriteContainer.decode(String.self, forKey: .imageString)
        
        primaryType = types[0].type.name
        
        if let secondType = types.last,
           secondType.type.name != primaryType {
            secondaryType = secondType.type.name
        } else {
            secondaryType = nil
        }
        
        var decodedStats = [PokemonStat]()
        for stat in stats {
            decodedStats.append(PokemonStat(stat))
        }
        
        battleStats = decodedStats
    }
    
    // MARK: - Computed Vars
    var primaryTypeEnum: PokemonTypes {
        if let type = PokemonTypes(rawValue: primaryType) {
            return type
        } else {
            return .normal
        }
    }
    
    var secondaryTypeEnum: PokemonTypes? {
        if let secondaryType,
           let type = PokemonTypes(rawValue: secondaryType) {
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
    
    func getStat(_ stat: BattleStats) -> PokemonStat {
        return battleStats.first { $0.name == stat.rawValue } ?? PokemonStat(stat)
    }
}

struct PokemonTypeResult: Codable {
    let slot: Int
    let type: PokemonType
}

struct PokemonType: Codable {
    let name: String
    let url: String
}

struct PokemonNetworkStatResult: Codable, Hashable {
    let base_stat: Int
    let effort: Int
    let stat: PokemonNetworkStat
}

struct PokemonNetworkStat: Codable, Hashable {
    let name: String
    let url: String
}
