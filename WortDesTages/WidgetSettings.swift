//
//  WidgetSettings.swift
//  WortDesTages
//
//  Created by Raphael Schwarz on 14.03.25.
//

import SwiftUI

class WidgetSettings: ObservableObject {
    @AppStorage("selectedCategory") var selectedCategory: String = "wirtschaftsWörterListe"
    @AppStorage("widgetColor") var widgetColor: String = "blue"
}
