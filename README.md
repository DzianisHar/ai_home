# MealDB Explorer

A Flutter application for exploring meals and recipes from TheMealDB API.

## 1. Concept

MealDB Explorer is a mobile application that allows users to discover, search, and view detailed
information about various meals and recipes. The app provides a clean, intuitive interface for
browsing meals by categories, searching for specific dishes, and viewing detailed cooking
instructions and ingredients.

### Key Features:

- Browse random meals on the home screen
- Search for specific meals by name
- Filter meals by category
- View detailed meal information including ingredients and preparation steps
- Clean, responsive UI with smooth animations
- Offline support for previously viewed meals

## 2. Acceptance Criteria

### Core Functionality

-  Display random meals on the home screen
-  Implement search functionality to find meals by name
-  Allow filtering meals by category
-  Show detailed view for each meal with ingredients and instructions
-  Handle offline scenarios gracefully
-  Implement proper error handling and loading states

### UI/UX Requirements

-  Clean, modern interface following Material Design guidelines
-  Responsive layout that works on different screen sizes
-  Smooth animations for transitions between screens
-  Clear visual feedback for user actions
-  Accessible design with proper contrast and text sizing

### Technical Requirements

-  Implement BLoC pattern for state management
-  Use dependency injection for better testability
-  Implement unit and widget tests
-  Follow clean code principles
-  Support light/dark theme

## 3. Architecture and Navigation

### Application Architecture

The application follows Clean Architecture principles with the following layers:

1. **Presentation Layer**
    - UI Components (Widgets)
    - BLoCs (Business Logic Components)
    - Pages/Screens

2. **Domain Layer**
    - Entities
    - Repository Interfaces
    - Use Cases

3. **Data Layer**
    - Repositories (Implementation)
    - Data Sources (Local/Remote)
    - Models (DTOs)

### Navigation Flow

The app uses a simple navigation structure:

1. **Home Screen**
    - Displays random meals in a scrollable list
    - Search bar at the top
    - Category filter option

2. **Meal Detail Screen**
    - Shows detailed information about a selected meal
    - Ingredients list with measurements
    - Cooking instructions
    - Meal image and basic info (category, area)

3. **Search Screen**
    - Displays search results
    - Shows loading/empty states

### Dependencies

- **State Management**: `flutter_bloc`
- **Dependency Injection**: `get_it`
- **Networking**: `dio`
- **Navigation**: `go_router`
- **Local Storage**: `shared_preferences`
- **Image Loading**: `cached_network_image`
- **Testing**: `mocktail`, `bloc_test`

## Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK (latest stable version)
- Android Studio / VS Code with Flutter extensions

### Installation

1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Run `flutter run` to start the application

## Testing

Run tests using the following commands:

```bash
# Run all tests
flutter test

# Run widget tests
flutter test test/widget_test.dart

# Run bloc tests
flutter test test/features/dishes/presentation/bloc/dishes_bloc_test.dart
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

Video
https://drive.google.com/drive/folders/1k5zoZZo2Xvvi6oWC5-KBZg8bTpntg5ya
