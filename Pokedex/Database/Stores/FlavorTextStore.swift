//
//  FlavorTextStore.swift
//  Pokedex
//
//  Created by Joshua Ragusin on 6/3/23.
//

import Foundation
import GRDB

protocol FlavorTextStore {
    func getFlavorText(for name: String) -> PokemonFlavorText?
    func saveFlavorText(_ text: PokemonFlavorText) throws
}

class LiveFlavorTextStore: FlavorTextStore {
    var queue: DatabaseQueue {
        DatabaseManager.dbQueue
    }
    
    func getFlavorText(for name: String) -> PokemonFlavorText? {
        try? queue.read { db in
            try PokemonFlavorText.fetchOne(db, sql: """
            SELECT * FROM flavorText
            WHERE name = ?
            """, arguments: [name])
        }
    }
    
    func saveFlavorText(_ text: PokemonFlavorText) throws {
        try queue.write { db in
            try db.execute(sql: """
            INSERT OR REPLACE INTO flavorText (name, text)
            VALUES (?, ?)
            """, arguments: [text.name, text.flavorText])
        }
    }
}
