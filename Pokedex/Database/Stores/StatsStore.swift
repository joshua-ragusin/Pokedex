//
//  StatsStore.swift
//  Pokedex
//
//  Created by Joshua Ragusin on 5/28/23.
//

import Foundation
import GRDB

protocol StatsStore {
    func stats(_ id: Int) -> Stats?
    func saveStat(_ stat: Stats) throws
}

class LiveStatsStore: StatsStore {
    var queue: DatabaseQueue {
        DatabaseManager.dbQueue
    }
    
    func stats(_ id: Int) -> Stats? {
        try? queue.read { db in
            try Stats
                .filter(Stats.Columns.id == id)
                .fetchOne(db)
        }
    }
    
    func saveStat(_ stat: Stats) throws {
        try queue.write { db in
            try Stats(id: stat.id, hp: stat.hp, attack: stat.attack, defense: stat.defense, spAttack: stat.spAttack, spDefense: stat.spDefense, speed: stat.speed)
                .insert(db, onConflict: .replace)
        }
    }
}
