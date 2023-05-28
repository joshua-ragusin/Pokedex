//
//  PokemonStore.swift
//  Pokedex
//
//  Created by Joshua Ragusin on 5/28/23.
//

import Foundation
import GRDB

protocol PokemonStore {
    func pokemon(id: Int) async -> PokemonResult?
    func savePokemon(_ pokemon: PokemonResult) async throws
}

class LivePokemonStore: PokemonStore {
    internal var queue: DatabaseQueue {
        DatabaseManager.dbQueue
    }
    
    func pokemon(id: Int) async -> PokemonResult? {
        try? await queue.read { db in
            try PokemonResult
                .filter(PokemonResult.Column.id == id)
                .fetchOne(db)
        }
    }
    
    func savePokemon(_ pokemon: PokemonResult) async throws {
        try await queue.write { db in
            try db.execute(sql:
                """
                INSERT OR REPLACE INTO pokemon (id, name, primaryType, secondaryType, height, weight, imageString)
                VALUES (?, ?, ?, ?, ?, ?, ?)
                """, arguments: [pokemon.id, pokemon.name, pokemon.primaryType, pokemon.secondaryType, pokemon.height, pokemon.weight, pokemon.imageString])
        }
    }
}
