//
//  WidgetSettingsView.swift
//  WortDesTages
//
//  Created by Raphael Schwarz on 14.03.25.
//

import SwiftUI
import WidgetKit

struct WidgetSettingsView: View {
    @ObservedObject var settings = WidgetSettings()
    let colors = ["blue", "red", "green", "yellow", "purple"]

    var body: some View {
        VStack {
            Picker("Kategorie", selection: $settings.selectedCategory) {
                Text("Wirtschaft").tag("wirtschaftsWörterListe")
                Text("Geschichte").tag("geschichteWörterListe")
                Text("Politik").tag("politikWörterListe")
            }
            .pickerStyle(SegmentedPickerStyle())

            Picker("Farbe", selection: $settings.widgetColor) {
                ForEach(colors, id: \.self) { color in
                    Text(color.capitalized).tag(color)
                }
            }
            .pickerStyle(MenuPickerStyle())

            Button("Speichern") {
                UserDefaults.standard.set(settings.widgetColor, forKey: "widgetColor")
                UserDefaults.standard.set(settings.selectedCategory, forKey: "selectedCategory")
                
                WidgetCenter.shared.reloadAllTimelines()
            }
            .padding()
        }
        .padding()
    }
}
