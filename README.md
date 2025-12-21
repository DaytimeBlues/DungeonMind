# DungeonMind - D&D Campaign Manager

A Flutter-based web application for managing D&D campaigns with AI assistance.

🌐 **Live Demo**: https://gen-lang-client-0511073879.web.app

## Features

- 📚 **Campaign Management** - Create and organize multiple campaigns
- 👥 **Entity Tracking** - NPCs, locations, items, and more with wikilink connections
- 🗺️ **Interactive Maps** - Fog of war support for exploration
- 🎲 **AI Assistant** - Gemini-powered suggestions and content generation
- 📖 **SRD Integration** - Import from D&D 5e SRD

## Quick Start

### Run Locally
```bash
flutter run -d chrome
```

### Build for Web
```bash
flutter build web --release
```

### Deploy to Firebase
```bash
firebase deploy --only hosting
```

## Tech Stack

- **Flutter 3.38** - Cross-platform UI framework
- **Riverpod** - State management
- **Drift** - SQLite database with web support
- **go_router** - Navigation
- **Gemini AI** - Content generation

## Project Structure

```
lib/
├── core/           # Theme, utilities, services
├── data/           # Database, models, repositories
├── features/       # Screen implementations
│   ├── campaigns/
│   ├── entities/
│   ├── maps/
│   └── shell/
└── providers/      # Riverpod providers
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## License

MIT License
