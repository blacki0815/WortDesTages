//
//  AppIntent.swift
//  WortDesTages
//
//  Created by Raphael Schwarz on 14.03.25.
//

import AppIntents
import WidgetKit

struct WortDesTagesIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Wort des Tages"
    static var description = IntentDescription("Wähle Kategorie und Farbe für dieses Widget.")

    @Parameter(title: "Kategorie", default: .wirtschaft)
    var category: KategorieOption

    @Parameter(title: "Farbe", default: .blue)
    var farbe: FarbOption
}

// MARK: - Kategorie

enum KategorieOption: String, AppEnum {
    case wirtschaft = "wirtschaftsWörterListe"
    case geschichte = "geschichteWörterListe"
    case politik    = "politikWörterListe"
    case bildung    = "bildungWörterListe"

    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Kategorie"
    static var caseDisplayRepresentations: [KategorieOption: DisplayRepresentation] = [
        .wirtschaft: "Wirtschaft",
        .geschichte: "Geschichte",
        .politik:    "Politik",
        .bildung:    "Bildung"
    ]

    var displayName: String {
        switch self {
        case .wirtschaft: return "Wirtschaft"
        case .geschichte: return "Geschichte"
        case .politik:    return "Politik"
        case .bildung:    return "Bildung"
        }
    }
}

// MARK: - Farbe

enum FarbOption: String, AppEnum {
    case blue, indigo, purple, red, orange, green, teal, mint
    case slate, steel, charcoal, fog

    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Farbe"
    static var caseDisplayRepresentations: [FarbOption: DisplayRepresentation] = [
        .blue:     "Blau",
        .indigo:   "Indigo",
        .purple:   "Violett",
        .red:      "Rot",
        .orange:   "Orange",
        .green:    "Grün",
        .teal:     "Türkis",
        .mint:     "Mint",
        .slate:    "Schiefer",
        .steel:    "Stahlblau",
        .charcoal: "Anthrazit",
        .fog:      "Nebelgrau"
    ]
}
