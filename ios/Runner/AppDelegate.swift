import UIKit
import Flutter;
import Firebase;

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
      _ application: UIApplication,
      didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        //self.window.makeSecure()
        
        
        FirebaseApp.configure();
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
           }
          
        application.registerForRemoteNotifications()
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    };
    
    override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("Registered for Apple Remote Notifications")
        Messaging.messaging().setAPNSToken(deviceToken, type: .unknown)
    }

    /*
    // <Add>
    override func applicationWillResignActive(
      _ application: UIApplication
    ) {
        self.window.endEditing(true)
      self.window.isHidden = true;
    }
    override func applicationDidBecomeActive(

      _ application: UIApplication
    ) {
        self.window.endEditing(true)
      self.window.isHidden = false;
    }

    override func applicationDidEnterBackground(_ application: UIApplication) {
        self.window.endEditing(true)
        print("entered background")
    }*/

}

extension UIWindow{
    func makeSecure() {
        let field = UITextField()
        field.isSecureTextEntry = true;
        self.addSubview(field)
        field.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        field.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.layer.superlayer?.addSublayer(field.layer)
        field.layer.sublayers?.first?.addSublayer(self.layer)
    }
}
