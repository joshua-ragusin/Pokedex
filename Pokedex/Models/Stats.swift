//
//  Stats.swift
//  Pokedex
//
//  Created by Joshua Ragusin on 5/28/23.
//

import Foundation
import GRDB

struct Stats: Hashable, Codable {
    let id: Int
    let hp: Int
    let attack: Int
    let defense: Int
    let spAttack: Int
    let spDefense: Int
    let speed: Int
}

extension Stats: TableRecord, FetchableRecord, PersistableRecord {
    static var databaseTableName = "stats"
    
    enum Columns: String, SQLSpecificExpressible {
        case id, hp, attack, defense, spAttack, spDefense, speed
    }
}
