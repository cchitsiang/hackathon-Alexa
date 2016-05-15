import UIKit
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        window?.tintColor = UIColor(red:0.44, green:0.24, blue:0.78, alpha:1)
        UINavigationBar.appearance().titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.whiteColor()
        ]
        
        GMSServices.provideAPIKey("AIzaSyAvVEuU-lsaCGJzmr3cqG0mDbPQ1NyQVKA")
        
        configurePushNotification()
        
        let notification = launchOptions?[UIApplicationLaunchOptionsLocalNotificationKey] as! UILocalNotification!
        if (notification != nil) {
            handleNotification(notification);
        }

        return true
    }
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        handleNotification(notification);
    }
    
    func handleNotification(notification: UILocalNotification) {
        //setFirstView();
        
        self.window!.rootViewController?.performSegueWithIdentifier("NotificationSegue",
                                                                    sender: self.window!.rootViewController )
        
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
    }
    
    func setFirstView () {
        // Show first view controller
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let targetViewController = storyboard.instantiateViewControllerWithIdentifier("MainVC")
        
        self.window!.rootViewController = targetViewController;
    }
    
    private func configurePushNotification () {
        // Configure push notification
        let settings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
        UIApplication.sharedApplication().registerForRemoteNotifications()
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
        
        //if(application.applicationState == UIApplicationState.Active) {
            let dateTime = NSDate(timeIntervalSinceNow: 3)
            let notification = UILocalNotification()
            notification.applicationIconBadgeNumber = 1
            notification.timeZone = NSTimeZone.defaultTimeZone()
            notification.fireDate = dateTime
            notification.alertBody = "We will charge your account to to invest in RHB Focus Income Bond Fund..."
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
        //}
        
    }

}
