
Ticketmaster 🎟️
Ticketmaster is a Flutter-based mobile ticketing application that allows users to register, log in, browse events, register for events, and view their tickets—all built using a clean architecture with a feature-first folder structure. This project demonstrates modern state management with Riverpod and routing with GoRouter.

📖 What Is This Project About?
Ticketmaster is a proof-of-concept ticketing system designed to:

1. Register and log in users securely.
2. List events fetched from an API.
3. Allow event registration and ticket generation.
4. Display user tickets in a clean, responsive interface.
5. The project is structured to be scalable and maintainable, making it an ideal starting point for real-world event management applications.

🛠️ Tech Stack
Flutter 📱 – For building the mobile app.
Dart 💻 – The programming language used.
Riverpod 🌊 – For state management.
GoRouter 🧭 – For navigation and routing.
HTTP Package 🌐 – For making API calls.
JSON Serialization 🔧 – Using json_serializable and build_runner for model generation.

📂 Folder Structure
The project follows a feature-first, clean architecture approach with the following structure:

```
ticketmaster/
├── assets/                    # Asset files (images, fonts, etc.) 🎨
├── lib/
│   └── src/
│       ├── common/            # Reusable widgets, constants, and shared code 🧩
│       │   ├── constants/     # Global constants (colors, strings, styles)
│       │   └── widgets/       # Common UI components (buttons, input fields, etc.)
│       │
│       ├── features/          # Feature-specific code
│       │   ├── auth/          # Authentication (login & registration)
│       │   │   ├── application/   # Controllers / use cases
│       │   │   ├── data/          # Repository for API calls
│       │   │   ├── domain/        # Models (UserModel, RegistrationModel)
│       │   │   └── presentation/  # UI screens (LoginScreen, RegisterScreen)
│       │   │
│       │   ├── event/         # Event feature (listing events)
│       │   │   ├── data/          # Repository for event API calls
│       │   │   ├── domain/        # Models (EventModel)
│       │   │   └── presentation/  # UI screens (EventListScreen)
│       │   │
│       │   ├── home/          # Home feature (displaying tickets)
│       │   │   └── presentation/  # UI screens (HomeScreen, MainHomeScreen with bottom navigation)
│       │   │
│       │   └── settings/      # Settings & logout functionality
│       │       └── presentation/  # UI screens (SettingsScreen)
│       │
│       ├── providers/         # Global Riverpod providers for state management
│       ├── routing/           # Routing configuration using GoRouter
│       └── utils/             # Utility functions and helper classes
├── android/                   # Android-specific files and configuration
├── ios/                       # iOS-specific files and configuration
├── pubspec.yaml               # Project configuration and dependencies
├── README.md                  # Project documentation 📄
└── .gitignore                 # Git ignore file
```

🚀 Installations & How to Run the Project
Clone the Repository:
git clone https://github.com/Fundspay/ticketmaster.git
cd ticketmaster

Install Dependencies:
Ensure you have Flutter installed, then run:
flutter pub get

Generate Code (if using JSON serialization and Riverpod codegen):
dart run build_runner build 

Run the App or Launch the app on your emulator or device:
flutter run

Testing Navigation:

The initial route is set to the login screen by default, but for testing you can update the initial route in your routing configuration to directly open the home screen if needed.

🔮 Future Scope
Enhanced Ticketing System:
Implement real-time ticket validation and secure ticket transfers.

Payment Integration:
Integrate payment gateways to allow direct ticket purchases within the app.

User Notifications:
Add push notifications for event reminders, registration confirmations, and updates.

Advanced Authentication:
Implement biometric authentication (e.g., fingerprint or face recognition) for improved security.

Admin Dashboard:
Develop an admin panel for event organizers to manage events, view ticket sales, and gather analytics.

Analytics & Reporting:
Provide detailed insights into event attendance, user engagement, and revenue generation.

