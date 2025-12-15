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
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WortDesTagesWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Wort des Tages")
        .description("Zeigt ein tägliches Fachwort an.")
    }
}
