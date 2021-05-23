import UIKit
import Flutter
import GoogleMaps
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
      if #available(iOS 13.0, *) {

         } else {
             FirebaseApp.configure()
         }
     GMSServices.provideAPIKey("AIzaSyDH_1MBUwgEPyoiwWdjJELlRr8YXy3XAuA")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
