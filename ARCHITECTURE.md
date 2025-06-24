# GymTracker Application Architecture

This document outlines the core architecture of the GymTracker application.

## Modules

The application is divided into the following modules:

*   **UIManager:** Responsible for managing the application's user interface, including screen transitions and displaying data.
*   **DataManager:** Responsible for managing the application's data, including storing and retrieving data from local storage.
*   **WorkoutEngine:** Responsible for managing the active workout session, including tracking progress and calculating stats.
*   **SensorService:** Responsible for managing the application's sensors, including the accelerometer, gyroscope, and heart rate monitor.
*   **SettingsManager:** Responsible for managing the application's settings.

## Screen Transitions

The following screen transitions are planned:

*   Home -> Select Workout -> Active Workout -> Summary

## State Management

State management will be handled by the `DataManager` module. The `DataManager` will be responsible for storing and retrieving all application data, and will provide a consistent interface for other modules to access the data.

## Testability and Maintainability

The application is designed to be testable and maintainable. The modules are loosely coupled, and each module has a well-defined interface. This will make it easy to test each module in isolation, and will also make it easy to make changes to the application without breaking other parts of the application.

We will use Garmin's Page Object Model for the UI views to further improve testability and maintainability.
