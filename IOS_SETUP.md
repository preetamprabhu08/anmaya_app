# iOS Setup Guide for Anmaya App

This guide outlines the necessary steps to set up and run the iOS version of the Anmaya app.

## Prerequisites

1. macOS computer with Xcode installed (latest version recommended)
2. Apple Developer account
3. Flutter SDK installed

## Configuration Steps

### 1. Bundle Identifier

The app has been configured to use the bundle identifier `com.anmayatechnologies.anmaya`. This matches the Android package name and is used for deep links and app identification.

### 2. Apple Developer Account Setup

Before you can test Universal Links and deploy the app, you need to:

1. Log in to your [Apple Developer Account](https://developer.apple.com)
2. Register an App ID with the following capabilities:
   - Associated Domains (for Universal Links)

### 3. App Store Connect Setup

1. Create a new app in App Store Connect
2. Set the bundle ID to match your configuration: `com.anmayatechnologies.anmaya`
3. Complete all required information (description, screenshots, etc.)

### 4. Provisioning Profile and Certificates

1. Create a development and distribution certificate
2. Create a provisioning profile for your app
3. Download and install both in Xcode

### 5. Universal Links Configuration

The app is already configured to support Universal Links. However, you need to:

1. Host the `apple-app-site-association` file at `https://anmaya.in/.well-known/apple-app-site-association`
2. Update the Team ID in this file with your actual Apple Developer Team ID
3. Ensure the website is accessible via HTTPS

### 6. App Icons

The app comes with standard Flutter-generated app icons. To replace them with your own:

1. Create icons in all required sizes (see iOS Human Interface Guidelines)
2. Replace the files in `ios/Runner/Assets.xcassets/AppIcon.appiconset/`
3. Alternatively, use a tool like [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) to generate all sizes

Example flutter_launcher_icons configuration:
```yaml
# Add to pubspec.yaml
dev_dependencies:
  flutter_launcher_icons: ^0.13.1

flutter_launcher_icons:
  ios: true
  image_path: "assets/icon/ios-icon.png"
  remove_alpha_ios: true
```

Then run:
```
flutter pub get
flutter pub run flutter_launcher_icons
```

### 7. Testing Deep Links

You can test Universal Links and custom URL schemes using:

#### Universal Links (HTTP/HTTPS):
- https://anmaya.in/signup
- https://anmaya.in/signin
- https://anmaya.in/edtech/courses

#### Custom URL Scheme:
- anmaya://open/signup
- anmaya://open/signin
- anmaya://open/edtech/courses

### 8. Building and Running

1. Open the iOS directory in Xcode:
   ```
   cd ios && open Runner.xcworkspace
   ```

2. Select your target device/simulator and run the app

3. For release builds, configure code signing with your provisioning profile

## Troubleshooting

- If Universal Links don't work, verify your apple-app-site-association file is properly formatted and accessible
- If you encounter code signing issues, check your certificates and provisioning profiles
- For build errors, try `flutter clean` followed by `flutter pub get`

## Resources

- [Flutter Deep Linking Documentation](https://docs.flutter.dev/development/ui/navigation/deep-linking)
- [Apple Universal Links Documentation](https://developer.apple.com/documentation/xcode/supporting-universal-links-in-your-app)
- [iOS Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/app-icons) 