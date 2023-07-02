//
//  StatsStore.swift
//  Pokedex
//
//  Created by Joshua Ragusin on 5/28/23.
//

import Foundation
import GRDB

protocol StatsStore {
    func stats(_ id: Int) -> PokemonGameStats?
    func saveStat(_ stat: PokemonGameStats) throws
}

class LiveStatsStore: StatsStore {
    var queue: DatabaseQueue {
        DatabaseManager.dbQueue
    }
    
    func stats(_ id: Int) -> PokemonGameStats? {
        try? queue.read { db in
            try PokemonGameStats.fetchOne(db, sql: """
                SELECT * FROM stats
                WHERE id = ?
                """, arguments: [id])
        }
    }
    
    func saveStat(_ stat: PokemonGameStats) throws {
        try queue.write { db in
            try PokemonGameStats(id: stat.id, hp: stat.hp, attack: stat.attack, defense: stat.defense, spAttack: stat.spAttack, spDefense: stat.spDefense, speed: stat.speed)
                .insert(db, onConflict: .replace)
        }
    }
}
