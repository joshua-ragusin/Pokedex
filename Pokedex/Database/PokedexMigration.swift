//
//  PokedexMigration.swift
//  Pokedex
//
//  Created by Joshua Ragusin on 1/29/24.
//
import GRDB

protocol PokedexMigration {
    func migrate(db: Database) throws
    var name: String { get }
}
