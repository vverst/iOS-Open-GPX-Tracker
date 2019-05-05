//
//  Notifications.swift
//  OpenGpxTracker
//
//  Created by merlos on 05/05/2019.
//

import Foundation
import UserNotifications

@available(iOS 10.0, *)
class Notifications: NSObject, UNUserNotificationCenterDelegate {
    
    static var center: Notifications = Notifications()
    
    private let notificationsCenter = UNUserNotificationCenter.current()
    
    private override init() {
        super.init()
        notificationsCenter.requestAuthorization(options: [.alert, .sound])
        { (granted, error) in
            // Enable or disable features based on authorization.
        }
        notificationsCenter.delegate = self
    }
    
    func showFileNotification(_ notification: Notification) {
        
        guard let fileName = notification.userInfo?["fileName"] as? String? else { return }
        
        notificationsCenter.getNotificationSettings { (settings) in
            // Do not schedule notifications if not authorized.
            guard settings.authorizationStatus == .authorized else {return}
            if settings.alertSetting == .enabled {
                // Schedule an alert-only notification.
                self.fileAlertNotification(fileName ?? "???.gpx")
            } else {
                // Schedule a notification with a badge and sound.
                //self.badgeAppAndPlaySound()
                print("badgeAppPlaySound")
            }
        }
    }
    
    private func fileAlertNotification(_ fileName: String, title: String = "Saved file") {
        print("Notifications::fileReceivedAlertNotification: \(fileName)")
        let content = UNMutableNotificationContent()
        content.title = "Saved file"
        content.body = fileName
        content.sound = UNNotificationSound.default
        
        let date = Date(timeIntervalSinceNow: 1)
        let triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second,], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate,
                                                    repeats: false)
        let identifier = UUID().uuidString
        let request = UNNotificationRequest(identifier: identifier,
                                            content: content, trigger: trigger)
        notificationsCenter.add(request, withCompletionHandler: { (error) in
            if let error = error {
                print("Notifications:: Error requesting notification: \(error)")
            }
        })
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(.alert)
    }
}


