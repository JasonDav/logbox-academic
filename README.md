# logbox_academic

A flutter **POC** of Logbox Academic's mobile app.

## Getting Started

### Install Flutter
Head to https://flutter.dev/docs/get-started/install and follow the instructions.

### Setup the project
Run `flutter pub get` to pull the necessary dependencies.

This project uses [Json Serializable](https://pub.dev/packages/json_serializable) to handle generating biolerplate for serializing and deserializing DTOs.

Run `flutter pub run build_runner <build|watch>` to generate this boilerplate. Use `build` to build once. Use `watch` to have it monitor files for changes.

## Running the application

To run the application run `flutter run`.

Flutter can run on many different platforms. To see which devices are currently available to run on on your system. Run `flutter devices`.
To target a device to run on use the `-d` option followed by the device name from the device list.

## Testing
Flutter provides support for unit, widget and integration testing.
Integration tests are kept in the ./integration_test directory.
To run tests run the command `flutter drive --driver=test_driver/integration_test.dart --target=integration_test/<integration_test>.dart -d <DEVICE_ID>`

## Getting Started with Flutter

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
