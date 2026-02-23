# 📸 Instagram Clone - iOS (MVVM & SwiftUI)

[![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)](https://swift.org)
[![Platform](https://img.shields.io/badge/Platform-iOS%2015.0%2B-lightgrey.svg)](https://developer.apple.com/ios/)
[![Architecture](https://img.shields.io/badge/Architecture-MVVM-blue.svg)](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93viewmodel)
[![UI](https://img.shields.io/badge/UI-UIKit%20%2B%20SwiftUI-success.svg)]()
[![Backend](https://img.shields.io/badge/Backend-Firebase-yellow.svg)](https://firebase.google.com/)

An Instagram Clone application built with **Swift**, utilizing **Firebase** for robust backend services. This project demonstrates modern iOS development practices by combining **Programmatic UI** (No Storyboards) with a **Hybrid UI approach** (UIKit + SwiftUI) and utilizing the **MVVM** (Model-View-ViewModel) architectural pattern for clean, scalable code.

## 🌟 Key Features

* **Hybrid UI Integration (NEW):** The Settings screen is built entirely with **SwiftUI** and seamlessly integrated into the UIKit application using `UIHostingController` and Closures for delegation.
* **Programmatic UI:** All main layouts (Login, Feed, Upload, Custom Cells) are built using Auto Layout entirely in code. No Interface Builder or Storyboards are used.
* **MVVM Architecture:** Strict separation of concerns. ViewModels handle all Firebase interactions and business logic.
* **User Authentication:** Secure Sign Up and Login/Logout functionality using Firebase Auth.
* **Real-time Feed:** Fetches posts from Firestore ordered by date using Snapshot Listeners for real-time updates.
* **Media Upload:** Upload photos seamlessly to Firebase Storage and save post metadata to Firestore.
* **Interactive UI:** Real-time "Like" system with immediate UI updates.
* **Image Caching:** Efficient asynchronous image loading and caching using `SDWebImage`.


## 🛠 Tech Stack

* **Language:** Swift 5
* **Frameworks:** UIKit, SwiftUI
* **Architecture:** MVVM (Model-View-ViewModel)
* **Backend:** Firebase (Authentication, Firestore Database, Storage)
* **Dependencies:**
    * [SDWebImage](https://github.com/SDWebImage/SDWebImage)

## 📂 Project Structure

```text
InstagramClone/
├── Models/              # Data structures (Post.swift)
├── ViewModels/          # Business logic & Firebase calls (FeedViewModel, LoginViewModel...)
├── Views/
│   ├── Cells/           # Custom UIKit Cells (FeedCell.swift)
│   ├── Controllers/     # View Controllers (FeedVC, MainTabBarController...)
│   └── SwiftUI/         # SwiftUI Views (SettingsView.swift)
├── Resources/           # Assets, LaunchScreen, GoogleService-Info.plist (Git Ignored)
└── Supporting Files/    # AppDelegate, SceneDelegate, Info.plist
