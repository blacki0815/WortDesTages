//
//  WidgetSettings.swift
//  WortDesTages
//
//  Created by Raphael Schwarz on 14.03.25.
//

import SwiftUI

class WidgetSettings: ObservableObject {
    @AppStorage("selectedCategory", store: sharedDefaults)
    var selectedCategory: String = "wirtschaftsWörterListe"

    @AppStorage("widgetColor", store: sharedDefaults)
    var widgetColor: String = "blue"
}
