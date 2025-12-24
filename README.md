# TapKit

Calculator, Notes & QR Scanner — all in one tap.

TapKit is a fast, flat-UI utility app that provides Calculator, Notes, and QR Scanner in one place with a one-tap experience. The app is minimal, premium, and extremely fast. It's fully offline-first, requires no login, no cloud sync, and no ads.

## Features

### Calculator
- Flat UI calculator
- Supports basic arithmetic, percentage, and GST calculation
- Local calculation history
- One-tap "Save to Notes" for any result
- Copy result button
- Subtle haptic feedback

### Notes
- Quick text notes with auto timestamp
- Pin notes
- Search notes by keyword
- Save calculator results into notes
- Save QR scan results into notes
- Optional note lock using simple PIN
- Optional temporary notes that auto-delete after user-defined time
- Local storage only (no cloud, no login)

### QR Scanner
- Scan QR codes only
- Clean scanning UI
- Show scanned result clearly
- Actions: Copy, Open link (if URL), Save to Notes
- Optional QR scan history with clear option
- Camera permission used only when user taps scan

## Signature Feature – Chain Actions
- Calculator result → auto save to Notes
- QR scan result → auto save to Notes
- Notes → detect numbers and allow quick calculation

## Getting Started

1. Ensure Flutter is installed (latest stable version)
2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

## Permissions

- **Camera**: Required only for QR Scanner feature. Permission is requested when the user opens the QR Scanner screen.

## Architecture

The app follows clean architecture principles with feature-based folder structure:

```
lib/
  core/
    models/
    services/
    theme/
  features/
    calculator/
    notes/
    qr_scanner/
  screens/
  main.dart
```

## State Management

The app uses Provider for state management.

## Local Storage

The app uses Hive for local storage of notes, calculator history, and QR scan history.

## Requirements

- Flutter SDK: >=3.0.0 <4.0.0
- Android: Minimum SDK 21
- iOS: iOS 11.0+

## License

This project is created for demonstration purposes.

