//
//  PokemonImageStore.swift
//  Pokedex
//
//  Created by Joshua Ragusin on 5/28/23.
//

import Foundation
import GRDB

protocol PokemonImageStore {
    func pokemonImage(_ id: Int) -> PokemonImage?
    func savePokemonImage(_ image: PokemonImage) throws
}

class LivePokemonImageStore: PokemonImageStore {
    var queue: DatabaseQueue {
        DatabaseManager.dbQueue
    }
    
    func pokemonImage(_ id: Int) -> PokemonImage? {
        try? queue.read { db in
            try PokemonImage.fetchOne(db, sql: """
                SELECT * FROM pokemonImage
                WHERE id = ?
                """, arguments: [id])
        }
    }
    
    func savePokemonImage(_ image: PokemonImage) throws {
        try queue.write { db in
            try PokemonImage(id: image.id, imageData: image.imageData)
                .insert(db, onConflict: .replace)
        }
    }
}
