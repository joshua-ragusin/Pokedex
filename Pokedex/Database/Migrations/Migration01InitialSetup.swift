//
//  Migration01InitialSetup.swift
//  Pokedex
//
//  Created by Joshua Ragusin on 1/29/24.
//

import GRDB

struct Migration01InitialSetup: PokedexMigration {
    func migrate(db: GRDB.Database) throws {
        try db.create(table: "pokemon") { t in
            t.column("id", .integer).notNull()
                .primaryKey()
            t.column("name", .text).notNull()
            t.column("primaryType", .text).notNull()
            t.column("secondaryType", .text)
            t.column("height", .integer).notNull()
            t.column("weight", .integer).notNull()
            t.column("imageString", .text).notNull()
        }
        
        try db.create(table: "pokemonImage") { t in
            t.column("id", .integer).notNull()
                .primaryKey()
            t.column("imageData", .blob).notNull()
        }
        
        try db.create(table: "stats") { t in
            t.column("id", .integer).notNull()
                .primaryKey()
            t.column("hp", .integer).notNull()
            t.column("attack", .integer).notNull()
            t.column("defense", .integer).notNull()
            t.column("spAttack", .integer).notNull()
            t.column("spDefense", .integer).notNull()
            t.column("speed", .integer).notNull()
        }
        
        try db.create(table: "flavorText") { t in
            t.column("id", .integer)
                .primaryKey(autoincrement: true)
            t.column("name", .text).notNull()
            t.column("text", .blob).notNull()
        }
    }
    
    var name: String {
        "v1"
    }
}
