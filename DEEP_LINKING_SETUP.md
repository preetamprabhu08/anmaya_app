# Deep Linking Setup Guide

This guide explains how to complete the setup to enable deep linking between your website (amaya.in) and your mobile app.

## What's Already Set Up

1. **Android Configuration**: `AndroidManifest.xml` has been configured to handle deep links from amaya.in
2. **iOS Configuration**: `Info.plist` has been updated to support Universal Links
3. **App Routing**: The app's go_router has been configured to handle deep links

## Steps to Complete

### 1. Update apple-app-site-association.json

Replace placeholders in the `apple-app-site-association.json` file:
- Replace `YOUR_TEAM_ID` with your actual Apple Developer Team ID

> **Note**: You can find your Apple Team ID in the Apple Developer portal under "Membership" or in Xcode under your signing certificate settings. It's typically a 10-character string with letters and numbers.

### 2. Update assetlinks.json

The `assetlinks.json` file has been updated with your debug keystore SHA-256 fingerprint.

For release builds, you'll need to update this file with your release signing key fingerprint:
```
keytool -list -v -keystore <path-to-release-keystore> -alias <your-key-alias>
```

### 3. Host the Files on Your Website

These files need to be hosted at specific locations on your website:

1. Host the `apple-app-site-association.json` file at:
   `https://amaya.in/.well-known/apple-app-site-association`

2. Host the `assetlinks.json` file at:
   `https://amaya.in/.well-known/assetlinks.json`

### 4. Test Deep Linking

Test HTTP/HTTPS URLs like:
- https://amaya.in/signup
- https://amaya.in/signin
- https://amaya.in/edtech/courses

Also test direct app scheme URLs (which always open your app if installed):
- anmaya://open/signup
- anmaya://open/signin
- anmaya://open/edtech/courses

When a user clicks these links:
- If the app is installed, it will open directly to the correct screen
- If the app is not installed, it will open the website (for HTTP/HTTPS links)

## Adding Deep Links to Your Website

Add these links to your website to help users open content directly in your app:

```html
<!-- Standard web link (falls back to website if app not installed) -->
<a href="https://amaya.in/signin">Sign In</a>

<!-- Intent URL for Android (opens app or Play Store) -->
<a href="intent://anmaya.in/signin#Intent;scheme=https;package=com.anmayatechnologies.anmaya;end">Open in Android App</a>

<!-- Universal Link for iOS + Direct scheme for Android -->
<a href="anmaya://open/signin" id="appLink">Open in App</a>

<script>
// For better cross-platform support
document.getElementById('appLink').onclick = function(e) {
  // Try to open the app with universal link first
  window.location = "https://amaya.in/signin";
  
  // If app doesn't open in 2 seconds, fallback to custom scheme
  setTimeout(function() {
    window.location = "anmaya://open/signin";
  }, 2000);
  e.preventDefault();
};
</script>
```

## Troubleshooting

- For iOS, ensure your app is associated with your Apple Developer account
- For Android, verify your app's package name matches what's in the assetlinks.json file
- Use [Branch.io's deep linking validator](https://branch.io/resources/aasa-validator/) to check your configuration
- Check if Chrome/Safari has blocked the app links - you may need to clear browser settings
- Test both https://anmaya.in (web links) and anmaya://open (direct app scheme)
- Make sure the server sends the correct MIME type for apple-app-site-association (application/json) 