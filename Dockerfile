# Use the official Flutter image
FROM ghcr.io/cirruslabs/flutter:stable AS build

# Set working directory
WORKDIR /app

# Copy pubspec files
COPY pubspec.yaml pubspec.lock ./

# Install dependencies
RUN flutter pub get

# Copy source code
COPY . .

# Generate code
RUN flutter packages pub run build_runner build --delete-conflicting-outputs

# Build the app
RUN flutter build apk --release

# Use a smaller image for the final stage
FROM alpine:latest

# Install necessary packages
RUN apk --no-cache add ca-certificates

# Copy the built APK
COPY --from=build /app/build/app/outputs/flutter-apk/app-release.apk /app/app-release.apk

# Set working directory
WORKDIR /app

# Expose port (if needed for web version)
EXPOSE 8080

# Command to run the app (this would be different for mobile apps)
CMD ["echo", "Flutter app built successfully. APK available at /app/app-release.apk"]
