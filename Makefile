# Expense Tracker Lite - Makefile

.PHONY: help install build test clean run docker-build docker-run

# Default target
help:
	@echo "Expense Tracker Lite - Available Commands:"
	@echo ""
	@echo "Development:"
	@echo "  install     - Install Flutter dependencies"
	@echo "  generate    - Generate code (Hive adapters, etc.)"
	@echo "  build       - Build the app for release"
	@echo "  test        - Run all tests"
	@echo "  analyze     - Run code analysis"
	@echo "  clean       - Clean build artifacts"
	@echo "  run         - Run the app in debug mode"
	@echo ""
	@echo "Docker:"
	@echo "  docker-build - Build Docker image"
	@echo "  docker-run   - Run Docker container"
	@echo "  docker-test  - Run tests in Docker"
	@echo ""
	@echo "CI/CD:"
	@echo "  ci-check    - Run CI checks locally"
	@echo "  release     - Prepare release build"

# Development commands
install:
	flutter pub get

generate:
	flutter packages pub run build_runner build --delete-conflicting-outputs

build:
	flutter build apk --release

build-bundle:
	flutter build appbundle --release

test:
	flutter test --coverage

analyze:
	flutter analyze

clean:
	flutter clean
	flutter pub get

run:
	flutter run

# Docker commands
docker-build:
	docker build -t expense-tracker .

docker-run:
	docker run -p 8080:8080 expense-tracker

docker-test:
	docker-compose up expense-tracker-test

# CI/CD commands
ci-check: install generate analyze test
	@echo "All CI checks passed!"

release: clean install generate test build
	@echo "Release build ready!"

# Platform specific builds
build-android:
	flutter build apk --release

build-ios:
	flutter build ios --release --no-codesign

build-web:
	flutter build web --release

# Development helpers
watch:
	flutter packages pub run build_runner watch

format:
	dart format .

# Database operations
db-reset:
	flutter clean
	flutter pub get
	flutter packages pub run build_runner build --delete-conflicting-outputs

# Dependencies
deps-update:
	flutter pub upgrade

deps-outdated:
	flutter pub outdated

# Code quality
lint:
	flutter analyze --fatal-infos

# Coverage
coverage:
	flutter test --coverage
	genhtml coverage/lcov.info -o coverage/html
	@echo "Coverage report generated in coverage/html/"

# Release preparation
release-prep:
	@echo "Preparing release..."
	flutter clean
	flutter pub get
	flutter packages pub run build_runner build --delete-conflicting-outputs
	flutter analyze
	flutter test --coverage
	flutter build apk --release
	flutter build appbundle --release
	@echo "Release preparation complete!"
