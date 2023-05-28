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
        let databaseURL = try FileManager.default
            .url(for: .applicationDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appending(path: "db.sqlite")
        
        dbQueue = try DatabaseQueue(path: databaseURL.path())
    }
}
