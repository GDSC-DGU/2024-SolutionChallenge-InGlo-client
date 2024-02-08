import UIKit
import Flutter
import GoogleMaps  // Add this import
import flutter_config // add env
import Firebase
import FirebaseMessaging

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, MessagingDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    //Firebase 초기화
    FirebaseApp.configure()
    
    //사용자 권한 요청
    if #available(iOS 10.0, *) {
      //ios 10 이상
      UNUserNotificationCenter.current().delegate = self
      let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
      UNUserNotificationCenter.current().requestAuthorization(
        options: authOptions,
        completionHandler: {_, _ in })
    } else {
      //ios 10 미만
      let settings: UIUserNotificationSettings =
      UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
      application.registerUserNotificationSettings(settings)
    }
    
    application.registerForRemoteNotifications()
    
    //FCM 대리자 설정
    Messaging.messaging().delegate = self
    
    GeneratedPluginRegistrant.register(with: self)

    // TODO: Add your Google Maps API key
    // env 파일 사용
        GMSServices.provideAPIKey(FlutterConfigPlugin.env(for: "MAP_KEY"))

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
<<<<<<< HEAD
}
=======
  
  // MARK: UNUserNotificationCenterDelegate
  
  //포그라운드 상태에서 알림 수신 처리(ios 10 이상)
  @available(iOS 10, *)
  override func userNotificationCenter(_ center: UNUserNotificationCenter,
                                       willPresent notification: UNNotification,
                                       withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    completionHandler([.alert, .sound, .badge])
  }
  
  // MARK: MessagingDelegate
  
  //FCM 토큰 갱신 감지
  func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
    print("Firebase registration token: \(String(describing: fcmToken))")
    let dataDict: [String: String] = ["token": fcmToken ?? ""]
    NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
  }
}
>>>>>>> main
