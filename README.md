# Task Manager App

A Flutter Task Manager application built using Firebase Authentication and Cloud Firestore.


# Features

* User Signup & Login
* Firebase Authentication
* Add Tasks
* Read Tasks
* Edit Tasks
* Delete Tasks
* Real-time Firestore Updates
* Clean UI
* Task Date Selection
* Delete Confirmation Dialog

---

# Tech Stack

* Flutter
* Dart
* Firebase Authentication
* Cloud Firestore



# Project Structure

lib/
│
├── Screens/
│   ├── auth/
│   │   ├── login_screen.dart
│   │   └── signup_screen.dart
│   │
│   ├── add_task_screen.dart
│   ├── edit_task.dart
│   └── home_screen.dart
│
├── Servise/
│   ├── auth_service.dart
│   └── task_services.dart
│
├── model/
│   └── task_model.dart
│
├── widgets/
│   └── task_tile.dart
│
└── main.dart


# Firebase Setup

## 1. Create Firebase Project

Go to Firebase Console:

[https://console.firebase.google.com](https://console.firebase.google.com)


## 3. Download google-services.json

Place the file inside:


## 4. Enable Authentication

Enable:

* Email/Password Authentication


## 5. Enable Firestore Database

Create Firestore database in test mode.


# Dependencies

Add these packages in `pubspec.yaml`


dependencies:
  flutter:
    sdk: flutter

  firebase_core: ^latest_version
  firebase_auth: ^latest_version
  cloud_firestore: ^latest_version







# CRUD Operations

## Add Task

Creates a new task in Firestore.



## Read Tasks

Uses StreamBuilder with Firestore snapshots.


## Edit Task

Updates existing task data.


## Delete Task

Deletes task from Firestore with confirmation dialog.



# Author

Vikas Sonawane



# Future Improvements

* Task Complete Feature
* Task Priority
* User-specific Tasks
* Riverpod State Management



This project is for learning and internship assignment purposes.
