//
//  SettingsView.swift
//  WortDesTages
//
//  Created by Raphael Schwarz on 14.03.25.
//

import SwiftUI
import WidgetKit

struct SettingsView: View {
    @EnvironmentObject private var settings: WidgetSettings
    @Environment(\.dismiss) private var dismiss

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 3)

    var body: some View {
        NavigationStack {
            Form {
                // Widget-Farbe
                Section {
                    LazyVGrid(columns: columns, spacing: 12) {
                        ForEach(ColorTheme.all, id: \.id) { theme in
                            ColorSwatch(theme: theme, isSelected: settings.widgetColor == theme.id) {
                                settings.widgetColor = theme.id
                            }
                        }
                    }
                    .padding(.vertical, 8)
                } header: {
                    Text("Widget-Farbe")
                }

                // Kategorie
                Section(header: Text("Kategorie")) {
                    Picker("Kategorie", selection: $settings.selectedCategory) {
                        Label("Wirtschaft", systemImage: "chart.line.uptrend.xyaxis")
                            .tag("wirtschaftsWörterListe")
                        Label("Geschichte", systemImage: "building.columns")
                            .tag("geschichteWörterListe")
                        Label("Politik", systemImage: "flag.fill")
                            .tag("politikWörterListe")
                        Label("Bildung", systemImage: "graduationcap.fill")
                            .tag("bildungWörterListe")
                    }
                    .pickerStyle(.inline)
                    .labelsHidden()
                }

                // Widget neu laden
                Section {
                    Button {
                        sharedDefaults.synchronize()
                        WidgetCenter.shared.reloadAllTimelines()
                    } label: {
                        Label("Widget aktualisieren", systemImage: "arrow.clockwise")
                    }
                } footer: {
                    Text("Tippe hier, um das Widget nach einer Änderung sofort neu zu laden.")
                }
            }
            .navigationTitle("Einstellungen")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Fertig") { dismiss() }
                        .fontWeight(.semibold)
                }
            }
        }
    }
}

// MARK: - ColorSwatch
struct ColorSwatch: View {
    let theme: ColorTheme
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 6) {
                ZStack {
                    theme.gradient
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .frame(height: 44)
                    if isSelected {
                        Image(systemName: "checkmark")
                            .font(.caption.weight(.bold))
                            .foregroundStyle(.white)
                    }
                }
                Text(theme.displayName)
                    .font(.caption2)
                    .foregroundStyle(isSelected ? .primary : .secondary)
            }
        }
        .buttonStyle(.plain)
        .animation(.spring(response: 0.25, dampingFraction: 0.7), value: isSelected)
    }
}
