# DungeonMind 🎲

A neuro-inclusive, cross-platform Campaign Management System for Dungeon Masters with ADHD.

## Features

- **ECS Database Architecture** – Polymorphic entities (NPCs, Locations, Items, Lore, Events, Factions) with bi-directional wiki-style linking
- **Reactive State Management** – Riverpod providers for real-time updates
- **Adaptive UI** – NavigationRail on desktop, BottomNavBar on mobile
- **Catppuccin Theme** – Calm pastel colors for reduced cognitive load
- **Completeness Scoring** – Visual progress indicators to encourage filling in lore
- **Calendar Presets** – Gregorian, Harptos (Forgotten Realms), Exandrian (Critical Role)

## Tech Stack

- **Flutter** – Cross-platform native performance
- **Drift (SQLite)** – Local-first relational database with graph capabilities
- **Riverpod** – Reactive state management
- **go_router** – Type-safe navigation
- **Material 3** – Modern design system

## Getting Started

### Prerequisites

- Flutter SDK 3.24+
- Windows Developer Mode enabled (for Windows builds)

### Run

```bash
flutter pub get
dart run build_runner build
flutter run
```

## Roadmap

- [ ] Phase 4: `[[wikilink]]` parsing with auto-linking
- [ ] Phase 5: Interactive maps with Fog of War
- [ ] Phase 6: Gemini AI logic checker
- [ ] Phase 7: Gamification (streaks, animations)

## License

MIT
