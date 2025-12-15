//
//  provider.swift
//  WortDesTages
//
//  Created by Raphael Schwarz on 14.03.25.
//

import WidgetKit
import SwiftUI
import Foundation

struct Entry: TimelineEntry {
    let date: Date
    let word: String
    let definition: String
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> Entry {
        Entry(date: Date(), word: "Beispiel", definition: "Dies ist eine Beispiel-Definition.")
    }

    func getSnapshot(in context: Context, completion: @escaping (Entry) -> Void) {
        completion(getRandomWordEntry())
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        let currentDate = Date()
        let nextUpdate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!

        let entry = getRandomWordEntry()
        let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))

        completion(timeline)
    }
}

func getRandomWordEntry() -> Entry {
    let selectedCategory = UserDefaults.standard.string(forKey: "selectedCategory") ?? "wirtschaftsWörterListe"

    print("Geladene Kategorie: \(selectedCategory)") // DEBUG-LOG

    let wordLists: [String: [(word: String, definition: String)]] = [
        "wirtschaftsWörterListe": wirtschaftsWörterListe,
        "geschichteWörterListe": geschichteWörterListe,
        "politikWörterListe": politikWörterListe
    ]
    
    if let words = wordLists[selectedCategory], !words.isEmpty {
        let randomWord = words.randomElement()!
        return Entry(date: Date(), word: randomWord.word, definition: randomWord.definition)
    }

    return Entry(date: Date(), word: "Fehler", definition: "Keine Einträge gefunden.")
}
