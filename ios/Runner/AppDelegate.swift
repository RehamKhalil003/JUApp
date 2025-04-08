import UIKit
import Flutter
import OneSignalFramework


@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
      // Register plugins
      GeneratedPluginRegistrant.register(with: self)

        OneSignal.Debug.setLogLevel(.LL_VERBOSE)

        OneSignal.initialize("f23e3c05-7911-4b35-a371-075f196c41fd", withLaunchOptions: launchOptions)

        OneSignal.Notifications.requestPermission({ accepted in
          print("User accepted notifications: \(accepted)")
        }, fallbackToSettings: true)
        
        print(OneSignal.User.onesignalId ?? "" , "OneSignal.User.onesignalId")

//      if let appSettings = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(appSettings) {
//          UIApplication.shared.open(appSettings)
//      }
      
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
