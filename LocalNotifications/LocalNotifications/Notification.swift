//
//  Notification.swift
//  LocalNotifications
//
//  Created by Anthony Gonzalez on 10/29/19.
//  Copyright © 2019 Antnee. All rights reserved.
//

import Foundation

import UserNotifications

struct MakeNotification {
    
    static func configureNotifications(title: String, body: String, time: Double){
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        
        
        content.title = NSString.localizedUserNotificationString(forKey: title, arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: body, arguments: nil)
        content.sound = .defaultCritical
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: false)
        let request = UNNotificationRequest(identifier: title, content: content, trigger: trigger)
        center.add(request) { error in
            if let error = error{
                print(error)
            } else {
                print("added notification for \(time) seconds from now")
            }
        }
    }
}

