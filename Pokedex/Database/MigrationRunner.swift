//
//  MigrationRunner.swift
//  Pokedex
//
//  Created by Joshua Ragusin on 1/29/24.
//

import GRDB

class MigrationRunner {
    private var migrator = DatabaseMigrator()
    private var queue: DatabaseQueue!
    
    init(queue: DatabaseQueue) {
        self.queue = queue
    }

    func performMigrations() {
        migrator.eraseDatabaseOnSchemaChange = true
        
        let migrationsToRun: [PokedexMigration] = [
            Migration01InitialSetup(),
            Migration02AddedFavorite()
        ]
        
        for migration in migrationsToRun {
            migrator.registerMigration(migration.name) { db in
                try migration.migrate(db: db)
            }
        }
        
        try? migrator.migrate(queue)
    }
}
