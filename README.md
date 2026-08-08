# Flutter Assessment Task: E-Commerce App

A modern, production-ready Flutter e-commerce application developed as part of a Junior Flutter Developer Assessment. This project demonstrates API integration, navigation, advanced state management, error handling, clean architecture, and modern UI/UX practices.

---

## Objective
Build a Flutter app demonstrating API integration, navigation, state management, error handling, and clean code.

## Features Implemented
- **Products Listing**: Fetches and displays products with images, titles, and prices.
- **Search Functionality**: Users can search for specific products seamlessly.
- **Product Details**: Comprehensive details screen for each product including ratings, stock status, and discount information.
- **Cart Management**: Fetches and displays cart details including individual items and total pricing.
- **State States**: Comprehensive handling of **Loading**, **Error**, and **Empty** states using modern UI patterns (e.g., Shimmer loading, Retry Error Cards).
- **Pull-to-Refresh**: Integrated in both the Home and Cart screens.

## Bonus Requirements Achieved
- **Pagination**: Infinite scrolling implemented on the Home screen to fetch subsequent products seamlessly.
- **State Management (Riverpod)**: Utilized `flutter_riverpod` (Notifier & StateNotifier) for scalable and predictable state management.
- **Cached Images**: Implemented `cached_network_image` for optimized and offline-ready image rendering.
- **Dark Mode**: Fully supports System Dark Mode with a manual toggle in the AppBar.
- **Unit Tests**: Domain layer business logic (UseCases) thoroughly tested with Flutter's built-in testing suite.

## Performance Optimizations
To ensure the app maintains a buttery-smooth 60fps even on lower-end devices, the following optimizations were implemented:
- **Background JSON Parsing**: Leveraged Flutter's `compute` function to parse large API responses on a separate Isolate, guaranteeing the main UI thread is never blocked.
- **Lazy Rendering**: Utilized `GridView.builder` and `ListView.builder` for efficient, on-demand UI rendering.
- **Image Caching**: Integrated `cached_network_image` to prevent re-fetching heavy image assets during scrolling.

## Architecture & Code Quality
The project strictly follows **Clean Architecture** principles, dividing the application into feature-based modules. This ensures scalability, maintainability, and separation of concerns.

```text
lib/
├── core/             # Core utilities (Networking, Errors, Theme, Navigation)
└── feature/
    ├── product/      # Product feature (Domain, Data, Presentation)
    └── cart/         # Cart feature (Domain, Data, Presentation)
```

- **Data Layer**: API calls, JSON parsing (run in background `Isolates/compute` to prevent UI jank), and models.
- **Domain Layer**: Repositories interfaces and UseCases (Business logic).
- **Presentation Layer**: UI screens, Widgets, and Riverpod Notifiers.

## Tech Stack & Packages
- **Flutter SDK**: Stable channel
- **Navigation**: `go_router` for robust, declarative routing.
- **State Management**: `flutter_riverpod`
- **Networking**: `dio` with `pretty_dio_logger` and Connectivity interceptors.
- **Functional Programming**: `dartz` (Either types for Failure/Success handling).
- **UI Enhancements**: `shimmer` (for skeleton loading), `cached_network_image`.

## Build & Test Instructions

### Running the App Locally
```bash
# 1. Get packages
flutter pub get

# 2. Run the application
flutter run
```

### Running Automated Tests
The project includes unit tests for the domain layer (UseCases) to ensure business logic remains robust.
```bash
flutter test
```

### Building for Production (Release)
To build a release APK for Android testing:
```bash
flutter build apk --release
```

To build a release AppBundle for the Google Play Store:
```bash
flutter build appbundle --release
```

To build for iOS (Requires macOS and Xcode):
```bash
flutter build ios --release
```

---
*Developed with a focus on writing clean, scalable, and production-level Flutter code.*
