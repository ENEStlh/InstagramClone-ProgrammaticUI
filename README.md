# 📸 Instagram Clone - iOS (MVVM)

[![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)](https://swift.org)
[![Platform](https://img.shields.io/badge/Platform-iOS%2015.0%2B-lightgrey.svg)](https://developer.apple.com/ios/)
[![Architecture](https://img.shields.io/badge/Architecture-MVVM-blue.svg)](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93viewmodel)
[![Firebase](https://img.shields.io/badge/Backend-Firebase-yellow.svg)](https://firebase.google.com/)

An Instagram Clone application built with **Swift 5**, using **Firebase** for backend services. This project demonstrates modern iOS development practices, including **Programmatic UI** (No Storyboard) and the **MVVM** (Model-View-ViewModel) architectural pattern for clean, testable, and maintainable code.

## 🌟 Features

* **User Authentication:** Secure Sign Up and Login/Logout functionality using Firebase Auth.
* **Real-time Feed:** Fetches posts from Firestore ordered by date.
* **Media Upload:** Upload photos with comments to Firebase Storage & Firestore.
* **Interaction:** Real-time "Like" system with immediate UI updates.
* **Caching:** Efficient image loading and caching using `SDWebImage`.
* **Programmatic UI:** All layouts are built with Auto Layout in code (no Interface Builder).

## 🛠 Tech Stack

* **Language:** Swift 5
* **Framework:** UIKit
* **Architecture:** MVVM (Model-View-ViewModel)
* **Backend:** Firebase (Auth, Firestore, Storage)
* **Dependencies:**
    * [SDWebImage](https://github.com/SDWebImage/SDWebImage) (for asynchronous image loading)
    * Firebase SDK

## 📂 Project Structure (MVVM)

The project is structured to separate concerns and improve scalability:

```text
InstagramClone/
├── Models/              # Data structures (Post.swift)
├── ViewModels/          # Business logic & Firebase calls (FeedViewModel, LoginViewModel...)
├── Views/
│   ├── Cells/           # Custom UI Cells (FeedCell.swift)
│   └── Controllers/     # View Controllers (FeedVC, UploadVC...)
├── Supporting Files/    # AppDelegate, SceneDelegate, Info.plist
└── Extensions/          # Helper extensions
