//
//  DatabaseManager.swift
//  Pokedex
//
//  Created by Joshua Ragusin on 5/27/23.
//

import Foundation
import GRDB
import UIKit

class DatabaseManager {
    static var dbQueue: DatabaseQueue!
    
    static func setup(for application: UIApplication) throws {
        let appSupportURL = try FileManager.default
            .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let directoryURL = appSupportURL.appending(path: "PokedexDatabase")
        
        try FileManager.default.createDirectory(at: directoryURL, withIntermediateDirectories: true)
        
        let databaseURL = directoryURL.appending(path: "db.sqlite")
        dbQueue = try DatabaseQueue(path: databaseURL.path)
        performMigrations()
    }
    
    static private func performMigrations() {
        var migrator = DatabaseMigrator()
        
        migrator.eraseDatabaseOnSchemaChange = true
        
        migrator.registerMigration("01Migration-Create-Pokemon-Table") { db in
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
        }
        
        migrator.registerMigration("02Migration-Create-Pokemon-Image-Table") { db in
            try db.create(table: "pokemonImage") { t in
                t.column("id", .integer).notNull()
                    .primaryKey()
                t.column("imageData", .blob).notNull()
            }
        }
        
        migrator.registerMigration("03Migration-Create-Stats-Table") { db in
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
        }
        
        try? migrator.migrate(dbQueue)
    }
}
