//
//  Migration02AddedFavorite.swift
//  Pokedex
//
//  Created by Joshua Ragusin on 1/29/24.
//

import GRDB

class Migration02AddedFavorite: PokedexMigration {
    func migrate(db: GRDB.Database) throws {
        try db.alter(table: "pokemon") { table in
            table.add(column: "favorite", .boolean)
                .defaults(to: false)
        }
    }
    
    var name: String {
        "v2"
    }
}
