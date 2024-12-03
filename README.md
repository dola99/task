# Order Insights App

A Flutter application that displays insights from e-commerce order data. The app provides a clean, modern interface inspired by leading FinTech applications.

## Features

- Display key metrics about orders:
  - Total number of orders
  - Average order price
  - Number of returned orders
- Interactive graph showing order trends over time
- Modern, user-friendly interface
- Cross-platform support (iOS, Android, Web)

## Getting Started

### Prerequisites

- Flutter SDK (latest version)
- Dart SDK (latest version)
- iOS Simulator/Android Emulator for mobile testing
- Chrome/Firefox for web testing

### Installation

1. Clone the repository
2. Navigate to the project directory
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run
   ```

## Architecture

The app follows a clean architecture pattern using Provider for state management. Key components include:

- `OrderProvider`: Manages the state and business logic for orders
- `MetricsScreen`: Displays key order metrics
- `GraphScreen`: Shows order trends over time

## Dependencies

- `provider`: State management
- `fl_chart`: Chart visualization
- `intl`: Date and number formatting
- `google_fonts`: Typography

## License

This project is licensed under the MIT License.
