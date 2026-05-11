//
//  WortDesTagesWidgetEntryView.swift
//  WortDesTages
//
//  Created by Raphael Schwarz on 14.03.25.
//

import SwiftUI
import WidgetKit

struct WortDesTagesWidgetEntryView: View {
    var entry: Entry
    @Environment(\.widgetFamily) private var family

    private var theme: ColorTheme { ColorTheme.find(entry.colorId) }

    var body: some View {
        if #available(iOSApplicationExtension 17.0, macOSApplicationExtension 14.0, *) {
            widgetContent
                .containerBackground(for: .widget) { theme.gradient }
        } else {
            ZStack {
                theme.gradient.ignoresSafeArea()
                widgetContent
            }
        }
    }

    @ViewBuilder
    private var widgetContent: some View {
        switch family {
        case .systemSmall:  smallLayout
        case .systemLarge:  largeLayout
        default:            mediumLayout
        }
    }

    // MARK: Small
    private var smallLayout: some View {
        VStack(alignment: .leading, spacing: 3) {
            badge
            (Text(entry.word).font(.system(size: 14, weight: .bold, design: .rounded))
             + Text("  \(entry.pronunciation)").font(.system(size: 9)).italic())
                .foregroundStyle(.white)
                .lineLimit(2)
            Text(entry.definition)
                .font(.system(size: 9))
                .foregroundStyle(.white.opacity(0.85))
                .lineLimit(4)
        }
        .padding(.horizontal, 10)
        .padding(.top, 10)
        .padding(.bottom, 6)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }

    // MARK: Medium
    private var mediumLayout: some View {
        VStack(alignment: .leading, spacing: 6) {
            badge
            (Text(entry.word).font(.system(size: 22, weight: .bold, design: .rounded))
             + Text("  \(entry.pronunciation)").font(.subheadline).italic())
                .foregroundStyle(.white)
            Text(entry.definition)
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.9))
                .lineLimit(3)
        }
        .padding(14)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }

    // MARK: Large
    private var largeLayout: some View {
        VStack(alignment: .leading, spacing: 12) {
            badge
            Spacer()
            Text(entry.word)
                .font(.largeTitle.weight(.bold))
                .foregroundStyle(.white)
            Text(entry.pronunciation)
                .font(.callout)
                .italic()
                .foregroundStyle(.white.opacity(0.75))
            Text(entry.definition)
                .font(.body)
                .foregroundStyle(.white.opacity(0.9))
        }
        .padding(20)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }

    // MARK: Badge
    private var badge: some View {
        Text(entry.categoryLabel)
            .font(.caption2.weight(.semibold))
            .foregroundStyle(.white.opacity(0.9))
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(.white.opacity(0.2))
            .clipShape(Capsule())
    }
}
