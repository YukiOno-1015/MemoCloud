//
//  AppDelegateExtension.swift
//  MemoCloud
//
//  Created by Yuki Ono on 2023/01/16.
//

import Foundation
import UIKit


extension AppDelegate{
    
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
        
        guard let vc = window?.rootViewController as? ViewController else {
            completionHandler(.failed)
            return
        }
        
        if !Apns.dialogBox(vc:vc, userInfo:userInfo){
            completionHandler(.failed)
            return
        }
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
