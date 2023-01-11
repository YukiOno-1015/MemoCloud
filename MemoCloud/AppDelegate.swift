//
//  AppDelegate.swift
//  MemoCloud
//
//  Created by Yuki Ono on 2023/01/07.
//

import UIKit
import UserNotifications
import Foundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        // Override point for customization after application launch.
        if launchOptions != nil {
            if let _ = launchOptions?[UIApplication.LaunchOptionsKey.remoteNotification] as? Dictionary<String, Any?> {
                // 未起動時に通知から起動したとき。
            }
        }
        // プッシュ通知の許可を要求
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if let error = error {
                print("プッシュ通知許可要求エラー : \(error.localizedDescription)")
                return
            }
            if !granted {
                print("プッシュ通知が拒否されました。")
                return
            }
            DispatchQueue.main.async {
                // APNs への登録
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    // MARK: - Push Notifications
    // Remote Notification の device token を表示
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%.2hhx", data)
        }
        let token = tokenParts.joined()
        print("Device Token: \(token)")
    }
    
    
    // APNs 登録失敗時に呼ばれる
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("APNs 登録に失敗しました : \(error.localizedDescription)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {

        // MARK: 04. get notification payload
        guard let apsPart = userInfo["aps"] as? [String: AnyObject] else {
            completionHandler(.failed)
            return
        }
        print(apsPart)
        let text = apsPart.map { (key, value) in "\(key): \(value)" }.joined(separator: "\n")
        print(text)
        print(userInfo["call"])
        guard let call = userInfo["call"] as? [String: AnyObject] else {
            completionHandler(.failed)
            return
        }
        print(call);
        let text2 = call.map { (key, value) in "\(key): \(value)" }.joined(separator: "\n")
        print(call);
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print("フォアグラウンド通知")
        if #available(iOS 14.0, *) {
            completionHandler([.badge, .banner])
        }
        else {
            completionHandler([.badge, .alert])
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        print("バックグラウンド通知")
        completionHandler()
    }
    
}
