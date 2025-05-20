import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  // Handle incoming Universal Links
  override func application(_ application: UIApplication,
                     continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
    // Get URL components from the incoming user activity
    guard userActivity.activityType == NSUserActivityTypeBrowsingWeb,
          let incomingURL = userActivity.webpageURL,
          let components = NSURLComponents(url: incomingURL, resolvingAgainstBaseURL: true) else {
      return false
    }
    
    // Log the URL for debugging
    print("Received Universal Link: \(incomingURL)")
    
    // Pass the URL to Flutter via the plugin
    return super.application(application, continue: userActivity, restorationHandler: restorationHandler)
  }
  
  // Handle incoming custom URL schemes
  override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
    // Log the URL for debugging
    print("Received Custom URL: \(url)")
    
    // Pass the URL to Flutter via the plugin
    return super.application(app, open: url, options: options)
  }
}
