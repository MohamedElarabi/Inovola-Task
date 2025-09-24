# Contributing to Expense Tracker Lite

Thank you for your interest in contributing to Expense Tracker Lite! This document provides guidelines and information for contributors.

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [Architecture Overview](#architecture-overview)
- [Coding Standards](#coding-standards)
- [Testing Guidelines](#testing-guidelines)
- [Pull Request Process](#pull-request-process)
- [Issue Reporting](#issue-reporting)

## 🤝 Code of Conduct

This project follows a code of conduct that we expect all contributors to adhere to:

- Be respectful and inclusive
- Use welcoming and inclusive language
- Accept constructive criticism gracefully
- Focus on what's best for the community
- Show empathy towards other community members

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>=3.4.4)
- Dart SDK
- Android Studio / VS Code
- Git

### Development Setup

1. **Fork the repository**
   ```bash
   git clone https://github.com/your-username/expense-tracker-lite.git
   cd expense-tracker-lite
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code**
   ```bash
   flutter packages pub run build_runner build
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

## 🏗️ Architecture Overview

This project follows Clean Architecture principles with the following structure:

```
lib/
├── core/                    # Core functionality
│   ├── constants/          # App constants
│   ├── errors/            # Error handling
│   ├── network/           # Network layer
│   └── utils/             # Utility functions
├── features/              # Feature modules
│   ├── expense/           # Expense management
│   ├── currency/          # Currency conversion
│   ├── dashboard/         # Dashboard UI
│   └── add_expense/       # Add expense UI
└── shared/                # Shared components
    ├── widgets/           # Reusable widgets
    └── services/         # Shared services
```

### State Management

We use the BLoC pattern for state management:
- Each feature has its own BLoC
- Events represent user actions
- States represent UI states
- Repository pattern abstracts data sources

## 📝 Coding Standards

### Dart/Flutter Style

- Follow [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Use `flutter analyze` to check code quality
- Follow the existing code patterns in the project

### File Naming

- Use snake_case for file names
- Use descriptive names that indicate purpose
- Group related files in appropriate directories

### Code Organization

- Keep files focused and single-purpose
- Use meaningful variable and function names
- Add comments for complex logic
- Follow SOLID principles

### Example Code Structure

```dart
// Good example
class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final ExpenseRepository _expenseRepository;

  ExpenseBloc({required ExpenseRepository expenseRepository})
      : _expenseRepository = expenseRepository,
        super(ExpenseInitial()) {
    on<LoadExpenses>(_onLoadExpenses);
  }

  Future<void> _onLoadExpenses(
    LoadExpenses event,
    Emitter<ExpenseState> emit,
  ) async {
    try {
      emit(ExpenseLoading());
      final expenses = await _expenseRepository.getExpenses();
      emit(ExpenseLoaded(expenses: expenses));
    } catch (e) {
      emit(ExpenseError(message: e.toString()));
    }
  }
}
```

## 🧪 Testing Guidelines

### Unit Tests

- Write unit tests for business logic
- Test edge cases and error conditions
- Aim for high test coverage
- Use descriptive test names

### Widget Tests

- Test UI components in isolation
- Test user interactions
- Mock external dependencies
- Verify state changes

### Test Structure

```dart
void main() {
  group('ExpenseBloc', () {
    late ExpenseBloc expenseBloc;
    late MockExpenseRepository mockRepository;

    setUp(() {
      mockRepository = MockExpenseRepository();
      expenseBloc = ExpenseBloc(expenseRepository: mockRepository);
    });

    tearDown(() {
      expenseBloc.close();
    });

    test('should emit loading then loaded when expenses are fetched', () {
      // Arrange
      when(() => mockRepository.getExpenses())
          .thenAnswer((_) async => [testExpense]);

      // Act & Assert
      expectLater(
        expenseBloc.stream,
        emitsInOrder([
          ExpenseLoading(),
          ExpenseLoaded(expenses: [testExpense]),
        ]),
      );

      expenseBloc.add(const LoadExpenses());
    });
  });
}
```

## 🔄 Pull Request Process

### Before Submitting

1. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes**
   - Follow coding standards
   - Add tests for new functionality
   - Update documentation if needed

3. **Test your changes**
   ```bash
   flutter test
   flutter analyze
   ```

4. **Commit your changes**
   ```bash
   git commit -m "feat: add new feature description"
   ```

### Pull Request Guidelines

- Use descriptive titles
- Provide detailed descriptions
- Reference related issues
- Include screenshots for UI changes
- Ensure all tests pass
- Request review from maintainers

### Commit Message Format

Use conventional commits format:

```
type(scope): description

feat(expense): add expense validation
fix(currency): resolve conversion error
docs(readme): update installation guide
test(bloc): add unit tests for expense bloc
```

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`

## 🐛 Issue Reporting

### Bug Reports

When reporting bugs, please include:

- Clear description of the issue
- Steps to reproduce
- Expected vs actual behavior
- Screenshots if applicable
- Device/OS information
- App version

### Feature Requests

For feature requests, please include:

- Clear description of the feature
- Use cases and benefits
- Potential implementation approach
- Any relevant mockups or designs

## 📚 Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [BLoC Pattern](https://bloclibrary.dev/)
- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)

## 🤔 Questions?

If you have questions about contributing:

- Open an issue with the `question` label
- Check existing issues and discussions
- Review the codebase and documentation

Thank you for contributing to Expense Tracker Lite! 🎉
