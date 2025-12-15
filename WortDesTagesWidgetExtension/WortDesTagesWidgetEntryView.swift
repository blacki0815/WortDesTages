//
//  WortDesTagesWidgetEntryView.swift
//  WortDesTages
//
//  Created by Raphael Schwarz on 14.03.25.
//

import SwiftUI

struct WortDesTagesWidgetEntryView: View {
    var entry: Entry

    var body: some View {
        let savedColor = UserDefaults.standard.string(forKey: "widgetColor") ?? "#0000FF"
        let backgroundColor = hexToColor(savedColor)

        return VStack {
            Text(entry.word)
                .font(.headline)
            Text(entry.definition)
                .font(.subheadline)
        }
        .padding()
        .background(backgroundColor) // Hintergrundfarbe setzen
        .cornerRadius(10)
    }

    // Funktion zur Umwandlung von Hex in Color
    func hexToColor(_ hex: String) -> Color {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if hexSanitized.hasPrefix("#") {
            hexSanitized.removeFirst()
        }

        if hexSanitized.count == 6 {
            let scanner = Scanner(string: hexSanitized)
            var hexNumber: UInt64 = 0
            if scanner.scanHexInt64(&hexNumber) {
                let r = Double((hexNumber & 0xFF0000) >> 16) / 255.0
                let g = Double((hexNumber & 0x00FF00) >> 8) / 255.0
                let b = Double(hexNumber & 0x0000FF) / 255.0
                return Color(red: r, green: g, blue: b)
            }
        }

        return Color.blue // Standardfarbe
    }
}
