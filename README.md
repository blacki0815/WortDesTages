# Wort des Tages

**Wort des Tages** is a SwiftUI app for iOS, iPadOS, and macOS that teaches you a new German vocabulary word every hour — drawn from four curated categories. Each word comes with a pronunciation guide and a concise definition, displayed in a beautiful gradient card.

The app ships with a fully configurable home screen widget (small, medium, and large) that each update independently, so you can place multiple widgets showing different categories and color themes at the same time.

---

## Features

- **Hourly word rotation** — a new word every hour, selected deterministically so every device shows the same word at the same time
- **Four categories** — Economics (*Wirtschaft*), History (*Geschichte*), Politics (*Politik*), and Education (*Bildung*)
- **Pronunciation guides** — every word includes a syllable-stress notation (e.g. `ka·pi·ta·LIS·mus`)
- **12 color themes** — 8 vivid (Blue, Indigo, Purple, Red, Orange, Green, Teal, Mint) and 4 muted (Slate, Steel, Charcoal, Fog)
- **Per-widget configuration** — long-press any widget → *Edit Widget* to set its own category and color independently
- **Three widget sizes** — small, medium, and large, each with a layout optimised for its dimensions
- **Share sheet** — share the current word directly from the main app card
- **Universal app** — one binary for iPhone, iPad, and Mac (Mac Catalyst)

---

## Screenshots

> <img width="1012" height="562" alt="Screenshot 2026-05-11 at 10 59 49" src="https://github.com/user-attachments/assets/71857658-60e8-4fae-abc9-aaa2647110d2" />
> <img width="1012" height="562" alt="Screenshot 2026-05-11 at 11 00 04" src="https://github.com/user-attachments/assets/b844d407-c86f-4956-8f17-d6b8c7cff489" />
> <img width="1012" height="562" alt="Screenshot 2026-05-11 at 11 00 07" src="https://github.com/user-attachments/assets/a8435540-9b93-4c89-8fc4-751f3c0b84b2" />
> <img width="1012" height="562" alt="Screenshot 2026-05-11 at 11 00 11" src="https://github.com/user-attachments/assets/67d6d2c6-a902-43c4-a71e-8631ab582487" />
> <img width="391" height="387" alt="Screenshot 2026-05-11 at 11 00 27" src="https://github.com/user-attachments/assets/4bd70b11-127b-4a7d-9a40-b9c48131bf42" />


---

## Requirements

| Platform | Minimum version |
|---|---|
| iOS / iPadOS | 17.0 |
| macOS | 14.0 (Sonoma) |
| Xcode | 15.0+ |

---

## Project Structure

```
WortDesTages/
├── WortDesTages/                   # Main app target
│   ├── WortDesTagesApp.swift
│   ├── MainView.swift
│   ├── SettingsView.swift
│   └── WidgetSettings.swift
└── WortDesTagesWidgetExtension/    # Widget extension target
    ├── Provider.swift
    ├── WortDesTagesWidget.swift
    ├── WortDesTagesWidgetEntryView.swift
    ├── AppIntent.swift             # Per-widget configuration
    ├── SharedColors.swift          # Color themes (shared with main app)
    └── WordLists.swift             # Word lists (shared with main app)
```

The two targets share `SharedColors.swift` and `WordLists.swift` via an App Group (`group.DevRaph.WortDesTages`) — no separate framework required.

---

## Getting Started

1. Clone the repository
2. Open `WortDesTages/WortDesTages.xcodeproj` in Xcode
3. Set your **Team** in *Signing & Capabilities* for both the main app target and the widget extension target
4. Make sure the App Group `group.DevRaph.WortDesTages` is enabled (with a checkmark) for both targets under *Signing & Capabilities*
5. Build and run

---

## Adding Words

All word lists live in `WortDesTagesWidgetExtension/WordLists.swift`. Each entry follows this format:

```swift
(word: "Amortisation", pronunciation: "a·mor·ti·sa·TI·on", definition: "Tilgung von Schulden durch regelmäßige Zahlungen.")
```

Add new entries to any of the four arrays (`wirtschaftsWörterListe`, `geschichteWörterListe`, `politikWörterListe`, `bildungWörterListe`) and rebuild. Word selection automatically cycles through the list by hour-of-year index.

---

## License

This project is for personal use. No license is currently provided.
