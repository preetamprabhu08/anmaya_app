import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:anmaya/screens/settings.dart';
import 'dart:io' show Platform;

/// A utility class for handling deep link related functionality
class DeepLinkHelper {
  /// Prompts the user to enable app links by opening the app's settings
  /// This will take the user to the "Open by default" screen where they can
  /// enable automatic handling of anmaya.in links
  static Future<void> promptUserToEnableAppLinks() async {
    try {
      if (Platform.isAndroid) {
        // Try to launch the Android app settings for "Open by default"
        final Uri settingsUri = Uri.parse(
          'package:com.anmayatechnologies.anmaya',
        );
        
        final bool launched = await launchUrl(settingsUri);
        if (!launched) {
          debugPrint('Could not launch settings directly');
          
          // Fallback to general app settings
          final Uri appSettingsUri = Uri.parse(
            'package:com.anmayatechnologies.anmaya/settings',
          );
          await launchUrl(appSettingsUri);
        }
      } else if (Platform.isIOS) {
        // On iOS, we can only open the Settings app
        final Uri settingsUri = Uri.parse('app-settings:');
        await launchUrl(settingsUri);
      }
    } catch (e) {
      debugPrint('Error opening app settings: $e');
    }
  }

  /// Shows a dialog asking the user if they want to enable deep links
  static void showEnableDeepLinksDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enable Direct Links'),
        content: const Text(
          'Would you like to open anmaya.in links directly in this app? '
          'This will allow you to tap on links from messages, emails, or websites '
          'and open them directly in the Anmaya app.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Not Now'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              promptUserToEnableAppLinks();
            },
            child: const Text('Enable'),
          ),
        ],
      ),
    );
  }
  
  /// Shows instructions for enabling deep links manually
  static void showManualInstructionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enable Direct Links'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('To enable opening anmaya.in links directly in this app:'),
            SizedBox(height: 8),
            Text('1. Go to your device Settings'),
            Text('2. Open Apps > Anmaya'),
            Text('3. Tap on "Open by default"'),
            Text('4. Enable "Open supported links"'),
            Text('5. Make sure "anmaya.in" is selected'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Later'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              promptUserToEnableAppLinks();
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }
  
  /// Checks if a URI is a deep link that this app can handle
  static bool canHandleDeepLink(Uri uri) {
    // Handle custom scheme links
    if (uri.scheme == 'anmaya' && uri.host == 'open') {
      return true;
    }
    
    // Handle web URL links
    if ((uri.scheme == 'http' || uri.scheme == 'https') && uri.host == 'anmaya.in') {
      return true;
    }
    
    return false;  
  }
} 