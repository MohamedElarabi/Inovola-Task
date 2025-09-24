# Changelog

All notable changes to the Expense Tracker Lite project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2024-01-XX

### Added
- **Initial Release**: Complete expense tracking application
- **Dashboard Screen**: 
  - User welcome message and profile display
  - Total balance, income, and expenses summary
  - Filter options (This Month, Last 7 Days, This Year, All Time)
  - Recent expenses list with pagination
  - Floating action button for adding expenses
- **Add Expense Screen**:
  - Category selection with visual icons
  - Amount input with currency selection
  - Date picker functionality
  - Receipt attachment simulation
  - Currency conversion to USD
- **Currency Conversion**:
  - Real-time exchange rate fetching from open.er-api.com
  - Support for multiple currencies (USD, EUR, GBP, JPY, EGP, SAR, etc.)
  - Automatic conversion to USD for storage
  - Offline caching of exchange rates (1-hour validity)
- **Pagination**:
  - 10 items per page implementation
  - "Load More" button functionality
  - Filter support with pagination
  - Loading and error states handling
- **Local Storage**:
  - Hive database for offline persistence
  - Expense data storage and retrieval
  - Currency rate caching
  - Settings storage
- **Architecture**:
  - Clean Architecture implementation
  - BLoC pattern for state management
  - Repository pattern for data abstraction
  - Dependency injection setup
- **Testing**:
  - Unit tests for expense validation
  - Unit tests for currency calculation
  - Widget tests for UI components
- **UI/UX**:
  - Material 3 design system
  - Custom blue theme (#2196F3)
  - Card-based layout with rounded corners
  - Category-specific icons with color coding
  - Responsive design for different screen sizes

### Technical Details
- **Dependencies**:
  - flutter_bloc: ^8.1.3 (State management)
  - equatable: ^2.0.5 (Value equality)
  - hive: ^2.2.3 (Local storage)
  - hive_flutter: ^1.1.0 (Hive Flutter integration)
  - dio: ^5.3.2 (HTTP client)
  - image_picker: ^1.0.4 (Image selection)
  - intl: ^0.18.1 (Internationalization)
  - uuid: ^4.1.0 (Unique ID generation)
- **Development Dependencies**:
  - hive_generator: ^2.0.1 (Code generation)
  - build_runner: ^2.4.7 (Build tools)
  - bloc_test: ^9.1.5 (BLoC testing)
  - mockito: ^5.4.2 (Mocking framework)

### Features
- **Offline Support**: Full offline functionality with local data persistence
- **Real-time Currency Conversion**: Live exchange rates with fallback to cached data
- **Efficient Pagination**: Memory-efficient data loading
- **Error Handling**: Comprehensive error handling with user-friendly messages
- **Performance**: Optimized for smooth scrolling and fast data access
- **Accessibility**: Material 3 accessibility features

### Known Limitations
- Receipt upload is simulated (no actual file picker integration)
- Limited to predefined expense categories
- No user authentication system
- No data export functionality (CSV/PDF)
- No advanced analytics or charts

### Future Enhancements
- Real image picker integration for receipts
- Custom category creation functionality
- User authentication and multi-user support
- Data export capabilities (CSV/PDF)
- Advanced filtering and search options
- Expense analytics and visualization charts
- Dark mode support
- Multi-language support
- Push notifications for expense reminders

## [Unreleased]

### Planned
- Dark mode implementation
- Advanced expense analytics
- Data export functionality
- Custom category management
- User authentication
- Multi-language support
- Push notifications
- Expense sharing features
- Budget tracking
- Recurring expense management
