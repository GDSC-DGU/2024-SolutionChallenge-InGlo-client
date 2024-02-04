import UIKit
import Flutter
import GoogleMaps  // Add this import
import flutter_config // add env

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    // TODO: Add your Google Maps API key
    // env 파일 사용
        GMSServices.provideAPIKey(FlutterConfigPlugin.env(for: "MAP_KEY"))

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}