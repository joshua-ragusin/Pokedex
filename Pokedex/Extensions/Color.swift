//
//  Color.swift
//  Pokedex
//
//  Created by Joshua Ragusin on 5/27/23.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: alpha
        )
    }
    
    // MARK: - Pokemon Type Colors
    public static var normalType: Color {
        Color(hex: 0xA8A77A)
    }
    
    public static var fireType: Color {
        Color(hex: 0xEE8130)
    }
    
    public static var waterType: Color {
        Color(hex: 0x6390F0)
    }
    
    public static var grassType: Color {
        Color(hex: 0x7AC74C)
    }
    
    public static var electricType: Color {
        Color(hex: 0xF7D02C)
    }
    
    public static var iceType: Color {
        Color(hex: 0x96D9D6)
    }
    
    public static var fightingType: Color {
        Color(hex: 0xC22E28)
    }
    
    public static var poisonType: Color {
        Color(hex: 0xA33EA1)
    }
    
    public static var groundType: Color {
        Color(hex: 0xE2BF65)
    }
    
    public static var flyingType: Color {
        Color(hex: 0xA98FF3)
    }
    
    public static var psychicType: Color {
        Color(hex: 0xF95587)
    }
    
    public static var bugType: Color {
        Color(hex: 0xA6B91A)
    }
    
    public static var rockType: Color {
        Color(hex: 0xB6A136)
    }
    
    public static var ghostType: Color {
        Color(hex: 0x735797)
    }
    
    public static var dragonType: Color {
        Color(hex: 0x6F35FC)
    }
    
    public static var darkType: Color {
        Color(hex: 0x705746)
    }
    
    public static var steelType: Color {
        Color(hex: 0xB7B7CE)
    }
    
    public static var fairyType: Color {
        Color(hex: 0xD685AD)
    }
}
