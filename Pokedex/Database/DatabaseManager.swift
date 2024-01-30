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
        let runner = MigrationRunner(queue: dbQueue)
        runner.performMigrations()
    }
}
