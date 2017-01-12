//
//  AppDelegate.swift
//  testDb
//
//  Created by 李小明 on 2016/12/16.
//  Copyright © 2016年 李小明. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import UserNotifications
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var isfirst = true
    var data:String!
    var newMessage = 0
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FIRApp.configure()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: { granted, error in
            
            //completionHandler: (Bool, Error?) 用closure傳入判斷是否允許通知。
            if granted {
                print("使用者同意了，每天都能收到來自米花兒的幸福訊息")
            }
            else {
                print("使用者不同意，不喜歡米花兒，哭哭!")
            }
            
        })
        
        //將 AppDelegate 物件設為 UNUserNotificationCenter 物件的代理人
        UNUserNotificationCenter.current().delegate = self
        
        //設定通知中的按鈕
        /*
         options 有四種：
         .init(rawValue: UInt)：自訂囉。
         .authenticationRequired：是否在操作之前解鎖。
         .destructive：此舉動是否被判定有破壞性，警告意味。
         .foreground：此舉動會使應用程式在前景啟動。
         */
        let likeAction = UNNotificationAction(identifier: "like", title: "進入程式", options: [.foreground])
        let dislikeAction = UNNotificationAction(identifier: "dislike", title: "沒興趣", options: [])
        
        //用UNNotificationCategory 跟通知中心註冊包含客製按鈕的特別通知，收到通知時會對照identifier產生按鈕。
        let category = UNNotificationCategory(identifier: "luckyMessage", actions: [likeAction, dislikeAction], intentIdentifiers: [], options: [])
        
        UNUserNotificationCenter.current().setNotificationCategories([category])
        readWnater()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        //readWnater()
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
         //self.isfirst = false
        //readWnater()
        
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
       application.applicationIconBadgeNumber = 0
      //  isFirst = false
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    func pushNoti(){
        let content = UNMutableNotificationContent()
        
        //設定標題
        content.title = "體驗過了，才是你的。"
        
        //副標題
        content.subtitle = "米花兒"
        
        //內文
        content.body = "不要追問為什麼，就笨拙地走入未知。感受眼前的怦然與顫抖，聽聽左邊的碎裂和跳動。不管好的壞的，只有體驗過了，才是你的。"
        
        //app Icon 外的數字。
        content.badge = 2
        
        //設定通知的聲音，音檔這部分一定得是 aiff，wav 或 caf，而且長度不能超過 30 秒。
        content.sound = UNNotificationSound.default()
        //客製化聲音
        //        content.sound = UNNotificationSound(named: "小幸運.wav")
        
        //設定通知Action按鈕組的ID
        content.categoryIdentifier = "luckyMessage"
        
        //設定圖片
        let imageURL = Bundle.main.url(forResource: "pic", withExtension: "jpg")
        let attachment = try! UNNotificationAttachment(identifier: "", url: imageURL!, options: nil)
        content.attachments = [attachment]
        
        //發送通知時，在通知裡包含客製化資訊：
        content.userInfo = ["link":"https://www.facebook.com/himinihana/photos/a.104501733005072.5463.100117360110176/981809495274287"]
        
        //通知的設定
        //幾秒鐘後觸發。(repeats: true時 秒數不能低於60秒 會閃退）
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
        
        //指定某個時刻觸發。
        //        let trigger = UNCalendarNotificationTrigger(dateMatching: DateComponents, repeats: false)
        
        //使用者靠近某個位置時觸發。
        //        let trigger = UNLocationNotificationTriggerㄦ
        
        //後台傳送到使用者手機的通知。
        //        let trigger = UNPushNotificationTrigger
        
        //如果trigger傳入nil 通知就會立即通知。
        let request = UNNotificationRequest(identifier: "notification1", content: content, trigger: trigger)
        //        let request = UNNotificationRequest(identifier: "notification1", content: content, trigger: nil)
        
        
        //呼叫add方法，跟通知中心請求發送通知。（completionHandler: ((Error?) 可使用closure判斷請求是否成功，目前先傳入nil）
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)

    }
    func readWnater(){
        
        let ref = FIRDatabase.database().reference()
        var notificationName =  Notification.Name("NewApplicantNoti")
        NotificationCenter.default.post(name: notificationName, object: nil, userInfo: ["data":"12self.3"])

        //let a = (ref.child("data1").queryEqual(toValue: "5039022111632"))
        //        print("=============")
        //        print("=============")
        //print(a.v)
        //ref.removeAllObservers()
        //ref.child("data1").observe
        ref.child("testdb").observe(.childAdded, with: { (snapshot) in
            // Get user value
            // self.data = snapshot.value as! [Dictionary<String, String>]!
            //let postDict = snapshot.value as? [String : AnyObject] ?? [:]
            //let snap = snapshot.value as! String
            if self.isfirst == false {
            self.data = snapshot.value as! String
            self.newMessage += 1
            self.pushNoti()
            
                
                NotificationCenter.default.post(name: notificationName, object: nil, userInfo: ["data":"12self.3"])
                

                
            }
           
            
            
        }) { (error) in
            //print(error.localizedDescription)
        }
        
        ref.child("testdb").observeSingleEvent(of: .value, with: { (snapshot) in
                      self.isfirst = false
        })

    
    
    }
    

    

}
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    //這個function是讓app在前景接收到通知時，透過代理人 呼叫function裡的completionHandler即可顯示通知。
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.badge, .sound, .alert])
    }
    
    
    //判斷使用者點擊通知，解析通知內容（按了通知後要做什麼事）：
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler:  @escaping () -> Void) {
        
        let content = response.notification.request.content
        print("title \(content.title)")
        print("userInfo \(content.userInfo)")
        
        //判斷使用者點選哪一個按鈕，會顯示按鈕的Identifier，進而做更進階的功能。
        print("actionIdentifier \(response.actionIdentifier)")
        
        completionHandler()
    }
}

