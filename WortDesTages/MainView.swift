//
//  MainView.swift
//  WortDesTages
//
//  Created by Raphael Schwarz on 14.03.25.
//

import SwiftUI
import WidgetKit

struct MainView: View {
    @StateObject private var settings = WidgetSettings()
    @State private var showSettings = false

    private var todayWord: (word: String, pronunciation: String, definition: String) {
        dailyWord(for: settings.selectedCategory)
    }

    private var theme: ColorTheme {
        ColorTheme.find(settings.widgetColor)
    }

    private var categoryLabel: String {
        switch settings.selectedCategory {
        case "wirtschaftsWörterListe": return "Wirtschaft"
        case "geschichteWörterListe":  return "Geschichte"
        case "politikWörterListe":     return "Politik"
        case "bildungWörterListe":     return "Bildung"
        default: return ""
        }
    }

    private var categoryIcon: String {
        switch settings.selectedCategory {
        case "wirtschaftsWörterListe": return "chart.line.uptrend.xyaxis"
        case "geschichteWörterListe":  return "building.columns"
        case "politikWörterListe":     return "flag.fill"
        case "bildungWörterListe":     return "graduationcap.fill"
        default: return "book.fill"
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    // Datumszeile
                    Text(Date(), format: Date.FormatStyle()
                        .day().month(.wide).year()
                        .locale(Locale(identifier: "de_DE")))
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.top, 4)
                        .padding(.bottom, 20)

                    // Wort-Karte
                    wordCard
                        .padding(.horizontal)

                    // Kategorie
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Kategorie")
                            .font(.headline)
                        HStack(spacing: 10) {
                            CategoryTile(title: "Wirtschaft", icon: "chart.line.uptrend.xyaxis",
                                         isSelected: settings.selectedCategory == "wirtschaftsWörterListe") {
                                settings.selectedCategory = "wirtschaftsWörterListe"
                                sharedDefaults.synchronize()
                                WidgetCenter.shared.reloadAllTimelines()
                            }
                            CategoryTile(title: "Geschichte", icon: "building.columns",
                                         isSelected: settings.selectedCategory == "geschichteWörterListe") {
                                settings.selectedCategory = "geschichteWörterListe"
                                sharedDefaults.synchronize()
                                WidgetCenter.shared.reloadAllTimelines()
                            }
                            CategoryTile(title: "Politik", icon: "flag.fill",
                                         isSelected: settings.selectedCategory == "politikWörterListe") {
                                settings.selectedCategory = "politikWörterListe"
                                sharedDefaults.synchronize()
                                WidgetCenter.shared.reloadAllTimelines()
                            }
                            CategoryTile(title: "Bildung", icon: "graduationcap.fill",
                                         isSelected: settings.selectedCategory == "bildungWörterListe") {
                                settings.selectedCategory = "bildungWörterListe"
                                sharedDefaults.synchronize()
                                WidgetCenter.shared.reloadAllTimelines()
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top, 28)
                }
                .frame(maxWidth: 640)
                .frame(maxWidth: .infinity)
                .padding(.bottom, 40)
            }
            .background(Color.appGroupedBackground.ignoresSafeArea())
            .navigationTitle("Wort des Tages")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.large)
            #endif
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button { showSettings = true } label: {
                        Image(systemName: "gearshape.fill")
                    }
                }
            }
            .sheet(isPresented: $showSettings) {
                SettingsView()
                    .environmentObject(settings)
            }
        }
    }

    // MARK: Word Card
    private var wordCard: some View {
        ZStack(alignment: .topLeading) {
            theme.gradient
                .clipShape(RoundedRectangle(cornerRadius: 24))

            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Label(categoryLabel, systemImage: categoryIcon)
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.white.opacity(0.9))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(.white.opacity(0.2))
                        .clipShape(Capsule())
                    Spacer()
                    ShareLink(item: "\(todayWord.word) · \(todayWord.pronunciation)\n\n\(todayWord.definition)") {
                        Image(systemName: "square.and.arrow.up")
                            .font(.body.weight(.semibold))
                            .foregroundStyle(.white.opacity(0.9))
                    }
                }

                Spacer()

                Text(todayWord.word)
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)

                Text(todayWord.pronunciation)
                    .font(.callout)
                    .italic()
                    .foregroundStyle(.white.opacity(0.7))
                    .padding(.bottom, 6)

                Text(todayWord.definition)
                    .font(.callout)
                    .foregroundStyle(.white.opacity(0.9))
                    .lineLimit(5)
            }
            .padding(20)
        }
        .frame(maxWidth: .infinity)
        .frame(minHeight: 220)
        .shadow(color: theme.primary.opacity(0.35), radius: 18, x: 0, y: 8)
    }
}

// MARK: - CategoryTile
struct CategoryTile: View {
    let title: String
    let icon: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundStyle(isSelected ? .white : .secondary)
                Text(title)
                    .font(.caption.weight(.medium))
                    .foregroundStyle(isSelected ? .white : .secondary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(isSelected ? Color.accentColor : Color.appSecondaryGroupedBackground)
            .clipShape(RoundedRectangle(cornerRadius: 14))
        }
        .buttonStyle(.plain)
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isSelected)
    }
}

// MARK: - Daily word helper
private func dailyWord(for category: String) -> (word: String, pronunciation: String, definition: String) {
    let lists: [String: [(word: String, pronunciation: String, definition: String)]] = [
        "wirtschaftsWörterListe": wirtschaftsWörterListe,
        "geschichteWörterListe":  geschichteWörterListe,
        "politikWörterListe":     politikWörterListe,
        "bildungWörterListe":     bildungWörterListe
    ]
    guard let words = lists[category], !words.isEmpty else {
        return ("Fehler", "", "Keine Einträge gefunden.")
    }
    let hourOfYear = Calendar.current.ordinality(of: .hour, in: .year, for: Date()) ?? 1
    let w = words[(hourOfYear - 1) % words.count]
    return (w.word, w.pronunciation, w.definition)
}

// MARK: - Platform colors
private extension Color {
    static var appGroupedBackground: Color {
        #if os(macOS)
        Color(NSColor.windowBackgroundColor)
        #else
        Color(UIColor.systemGroupedBackground)
        #endif
    }

    static var appSecondaryGroupedBackground: Color {
        #if os(macOS)
        Color(NSColor.controlBackgroundColor)
        #else
        Color(UIColor.secondarySystemGroupedBackground)
        #endif
    }
}
