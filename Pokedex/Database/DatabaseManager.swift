//
//  DatabaseManager.swift
//  Pokedex
//
//  Created by Joshua Ragusin on 5/27/23.
//

import Foundation
import GRDB
import UIKit

var dbQueue: DatabaseQueue!

class DatabaseManager {
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
                t.column("spriteData", .blob).notNull()
                t.column("height", .integer).notNull()
                t.column("weight", .integer).notNull()
            }
        }
        
        try! migrator.migrate(dbQueue)
    }
}
