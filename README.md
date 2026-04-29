# CineBase - Movie Discovery & Watchlist App

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Riverpod](https://img.shields.io/badge/Riverpod-60B5FF?style=for-the-badge&logo=dart&logoColor=white)](https://riverpod.dev)
[![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)](https://firebase.google.com)

**CineBase** is a modern, high-performance movie discovery application built with Flutter. It allows users to browse the latest films, view detailed information, manage their personal watchlist, and maintain their profile—all backed by a robust Firebase integration.

---

## 🚀 Key Features

*   **🎬 Comprehensive Film Catalog**: Browse a wide array of movies with real-time data.
*   **🔍 Detailed Movie Insights**: Deep dive into film summaries, ratings, and release information.
*   **🔐 Secure Authentication**: Full user lifecycle management including Login, Signup, and Password Recovery via Firebase Auth.
*   **🔖 Personal Watchlist**: Save your favorite movies to watch later, synced across devices via Cloud Firestore.
*   **👤 Profile Management**: Customize your user experience with editable profile details.
*   **🎨 Premium UI/UX**: A dark-themed, cinematic interface designed for an immersive viewing experience.

---

## 🛠️ Tech Stack & Architecture

This project follows a **Feature-First Architecture**, ensuring scalability and maintainability.

*   **Frontend Framework**: [Flutter](https://flutter.dev)
*   **State Management**: [Riverpod](https://riverpod.dev) (with code generation)
*   **Navigation**: [Go Router](https://pub.dev/packages/go_router)
*   **Networking**: [Dio](https://pub.dev/packages/dio) for efficient API communication
*   **Backend & Database**: [Firebase](https://firebase.google.com) (Authentication & Cloud Firestore)
*   **Image Caching**: [Cached Network Image](https://pub.dev/packages/cached_network_image)

---

## 📁 Project Structure

The codebase is organized logically into features for maximum clarity:

```text
lib/
├── core/           # Theming, Navigation, and App Constants
├── features/       # Modular Feature Folders
│   ├── auth/       # Login, Signup, Forget Password
│   ├── home/       # Movie Discovery Feed
│   ├── film_page/  # Detailed Movie Information
│   ├── watch_list/ # User's Saved Collections
│   └── profile/    # User Account Management
├── shared/         # Reusable Widgets & Providers
└── main.dart       # Application Entry Point
```

---

## ⚙️ Getting Started

### Prerequisites
*   Flutter SDK: `^3.9.0`
*   Dart SDK
*   Firebase Project Setup

### Installation
1. **Clone the repository:**
   ```bash
   git clone https://github.com/MustafaAdel54/cinebase-flutter-app.git
   ```
2. **Navigate to the project directory:**
   ```bash
   cd cinebase-flutter-app
   ```
3. **Install dependencies:**
   ```bash
   flutter pub get
   ```
4. **Run the application:**
   ```bash
   flutter run
   ```

---

## 🤝 Contact

**Mustafa Adel** - [GitHub](https://github.com/MustafaAdel54)

Project Link: [https://github.com/MustafaAdel54/cinebase-flutter-app](https://github.com/MustafaAdel54/cinebase-flutter-app)

---
*Developed with ❤️ by Mustafa Adel*
