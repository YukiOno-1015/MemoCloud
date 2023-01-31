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
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        // Override point for customization after application launch.
        if launchOptions != nil {
            
            // MARK: 01. get notification payload
            if let notificationOptions = launchOptions?[.remoteNotification] as? [String: AnyObject] {
                
                guard let vc = window?.rootViewController as? ViewController else {
                    return true
                }
                
                if !Apns.dialogBox(vc:vc, userInfo:notificationOptions){
                    return true
                }
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
}
