//
//  String.swift
//  Pokedex
//
//  Created by Joshua Ragusin on 5/26/23.
//

import Foundation

extension String {
    var properCase: String {
        let firstLetter = self.prefix(1).capitalized
        let remainingLetters = self.dropFirst().lowercased()
        
        return firstLetter + remainingLetters
    }
    
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
