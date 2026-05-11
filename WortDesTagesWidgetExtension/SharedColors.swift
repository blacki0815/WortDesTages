//
//  SharedColors.swift
//  WortDesTages
//
//  Created by Raphael Schwarz on 14.03.25.
//

import SwiftUI

let sharedDefaults = UserDefaults(suiteName: "group.DevRaph.WortDesTages")!

struct ColorTheme {
    let id: String
    let displayName: String
    let primary: Color
    let gradient: LinearGradient

    static let all: [ColorTheme] = [
        // Kräftige Farben
        .init(id: "blue",      displayName: "Blau",
              primary: .blue,
              gradient: LinearGradient(colors: [Color(red: 0.2, green: 0.5, blue: 1.0), Color(red: 0.1, green: 0.2, blue: 0.85)],
                                       startPoint: .topLeading, endPoint: .bottomTrailing)),
        .init(id: "indigo",    displayName: "Indigo",
              primary: .indigo,
              gradient: LinearGradient(colors: [.indigo, Color(red: 0.3, green: 0.2, blue: 0.9)],
                                       startPoint: .topLeading, endPoint: .bottomTrailing)),
        .init(id: "purple",    displayName: "Violett",
              primary: .purple,
              gradient: LinearGradient(colors: [.purple, Color(red: 0.85, green: 0.2, blue: 0.65)],
                                       startPoint: .topLeading, endPoint: .bottomTrailing)),
        .init(id: "red",       displayName: "Rot",
              primary: .red,
              gradient: LinearGradient(colors: [Color(red: 0.9, green: 0.2, blue: 0.2), Color(red: 0.7, green: 0.05, blue: 0.3)],
                                       startPoint: .topLeading, endPoint: .bottomTrailing)),
        .init(id: "orange",    displayName: "Orange",
              primary: .orange,
              gradient: LinearGradient(colors: [.orange, Color(red: 1.0, green: 0.45, blue: 0.0)],
                                       startPoint: .topLeading, endPoint: .bottomTrailing)),
        .init(id: "green",     displayName: "Grün",
              primary: .green,
              gradient: LinearGradient(colors: [Color(red: 0.1, green: 0.75, blue: 0.45), Color(red: 0.0, green: 0.5, blue: 0.4)],
                                       startPoint: .topLeading, endPoint: .bottomTrailing)),
        .init(id: "teal",      displayName: "Türkis",
              primary: .teal,
              gradient: LinearGradient(colors: [.teal, .cyan],
                                       startPoint: .topLeading, endPoint: .bottomTrailing)),
        .init(id: "mint",      displayName: "Mint",
              primary: .mint,
              gradient: LinearGradient(colors: [.mint, Color(red: 0.15, green: 0.75, blue: 0.6)],
                                       startPoint: .topLeading, endPoint: .bottomTrailing)),
        // Schlichte Töne
        .init(id: "slate",     displayName: "Schiefer",
              primary: Color(red: 0.39, green: 0.47, blue: 0.58),
              gradient: LinearGradient(colors: [Color(red: 0.39, green: 0.47, blue: 0.58), Color(red: 0.20, green: 0.27, blue: 0.38)],
                                       startPoint: .topLeading, endPoint: .bottomTrailing)),
        .init(id: "steel",     displayName: "Stahlblau",
              primary: Color(red: 0.35, green: 0.45, blue: 0.60),
              gradient: LinearGradient(colors: [Color(red: 0.45, green: 0.54, blue: 0.66), Color(red: 0.25, green: 0.34, blue: 0.48)],
                                       startPoint: .topLeading, endPoint: .bottomTrailing)),
        .init(id: "charcoal",  displayName: "Anthrazit",
              primary: Color(red: 0.28, green: 0.28, blue: 0.30),
              gradient: LinearGradient(colors: [Color(red: 0.36, green: 0.36, blue: 0.38), Color(red: 0.16, green: 0.16, blue: 0.18)],
                                       startPoint: .topLeading, endPoint: .bottomTrailing)),
        .init(id: "fog",       displayName: "Nebelgrau",
              primary: Color(red: 0.50, green: 0.54, blue: 0.60),
              gradient: LinearGradient(colors: [Color(red: 0.56, green: 0.60, blue: 0.66), Color(red: 0.36, green: 0.40, blue: 0.48)],
                                       startPoint: .topLeading, endPoint: .bottomTrailing)),
    ]

    static func find(_ id: String) -> ColorTheme {
        all.first { $0.id == id } ?? all[0]
    }
}
