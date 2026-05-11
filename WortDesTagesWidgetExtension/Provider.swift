//
//  Provider.swift
//  WortDesTages
//
//  Created by Raphael Schwarz on 14.03.25.
//

import WidgetKit
import AppIntents

struct Entry: TimelineEntry {
    let date: Date
    let word: String
    let pronunciation: String
    let definition: String
    let colorId: String
    let categoryLabel: String
}

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> Entry {
        Entry(date: Date(),
              word: "Kapitalismus",
              pronunciation: "ka·pi·ta·LIS·mus",
              definition: "Ein Wirtschaftssystem, das auf Privatbesitz und Gewinnstreben basiert.",
              colorId: "blue",
              categoryLabel: "Wirtschaft")
    }

    func snapshot(for configuration: WortDesTagesIntent, in context: Context) async -> Entry {
        makeEntry(for: configuration)
    }

    func timeline(for configuration: WortDesTagesIntent, in context: Context) async -> Timeline<Entry> {
        let entry = makeDailyEntry(for: configuration)

        var components = Calendar.current.dateComponents([.year, .month, .day, .hour], from: Date())
        components.hour! += 1
        let nextHour = Calendar.current.date(from: components) ?? Date().addingTimeInterval(3600)

        return Timeline(entries: [entry], policy: .after(nextHour))
    }
}

private func makeEntry(for configuration: WortDesTagesIntent) -> Entry {
    makeDailyEntry(for: configuration)
}

private func makeDailyEntry(for configuration: WortDesTagesIntent) -> Entry {
    let categoryKey   = configuration.category.rawValue
    let colorId       = configuration.farbe.rawValue
    let categoryLabel = configuration.category.displayName

    let wordLists: [String: [(word: String, pronunciation: String, definition: String)]] = [
        "wirtschaftsWörterListe": wirtschaftsWörterListe,
        "geschichteWörterListe":  geschichteWörterListe,
        "politikWörterListe":     politikWörterListe,
        "bildungWörterListe":     bildungWörterListe
    ]

    guard let words = wordLists[categoryKey], !words.isEmpty else {
        return Entry(date: Date(), word: "Fehler", pronunciation: "", definition: "Keine Einträge gefunden.",
                     colorId: colorId, categoryLabel: categoryLabel)
    }

    let hourOfYear = Calendar.current.ordinality(of: .hour, in: .year, for: Date()) ?? 1
    let w = words[(hourOfYear - 1) % words.count]
    return Entry(date: Date(), word: w.word, pronunciation: w.pronunciation, definition: w.definition,
                 colorId: colorId, categoryLabel: categoryLabel)
}
