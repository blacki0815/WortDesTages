//
//  WortDesTagesWidget.swift
//  WortDesTages
//
//  Created by Raphael Schwarz on 14.03.25.
//

import WidgetKit
import SwiftUI

struct WortDesTagesWidget: Widget {
    let kind: String = "WortDesTagesWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: WortDesTagesIntent.self, provider: Provider()) { entry in
            WortDesTagesWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Wort des Tages")
        .description("Täglich ein neues Fachwort – individuell pro Widget konfigurierbar.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}
