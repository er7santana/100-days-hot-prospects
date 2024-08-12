//
//  LocalNotificationsContentView.swift
//  HotProspects
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 11/08/24.
//

import SwiftUI
import UserNotifications

struct LocalNotificationsContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            Button("Request permission") {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("All set!")
                    } else if let error {
                        print(error.localizedDescription)
                    }
                }
            }
            
            Button("Schedule Notification") {
                let content = UNMutableNotificationContent()
                content.title = "Feed the cat"
                content.subtitle = "It looks hungry"
                content.sound = UNNotificationSound.default
                
                // shows this notification five seconds from now
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                
                // choose a random identifier
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
                // add out notification request
                UNUserNotificationCenter.current().add(request)
            }
        }
    }
}

#Preview {
    LocalNotificationsContentView()
}
