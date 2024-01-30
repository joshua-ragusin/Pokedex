//
//  PokemonStore.swift
//  Pokedex
//
//  Created by Joshua Ragusin on 5/28/23.
//

import Foundation
import GRDB

protocol PokemonStore {
    func allPokemon() -> [PokemonResult]?
    func pokemon(id: Int) -> PokemonResult?
    func pokemon(name: String) -> PokemonResult?
    func savePokemon(_ pokemon: PokemonResult) throws
}

class LivePokemonStore: PokemonStore {
    var queue: DatabaseQueue {
        DatabaseManager.dbQueue
    }
    
    func allPokemon() -> [PokemonResult]? {
        try? queue.read { db in
            try PokemonResult
                .fetchAll(db)
        }
    }
    
    func pokemon(id: Int) -> PokemonResult? {
        try? queue.read { db in
            try PokemonResult.fetchOne(db, sql: """
                SELECT * FROM pokemon
                WHERE id = ?
                """, arguments: [id])
        }
    }
    
    func pokemon(name: String) -> PokemonResult? {
        try? queue.read { db in
            try PokemonResult
                .filter(PokemonResult.Column.name == name)
                .fetchOne(db)
        }
    }
    
    func savePokemon(_ pokemon: PokemonResult) throws {
        try queue.write { db in
            try db.execute(sql:
                """
                INSERT OR REPLACE INTO pokemon (id, name, primaryType, secondaryType, height, weight, imageString)
                VALUES (?, ?, ?, ?, ?, ?, ?)
                """, arguments: [pokemon.id, pokemon.name, pokemon.primaryTypeString, pokemon.secondaryTypeString, pokemon.height, pokemon.weight, pokemon.imageString])
        }
    }
    
    func updateFavorite(for id: Int64, to newFavorite: Bool) throws {
        try queue.write { db in
            try db.execute(sql:
                """
                UPDATE pokemon
                    SET favorite = ?
                    WHERE pokemon.id = ?
                """, arguments: [newFavorite, id])
        }
    }
}
