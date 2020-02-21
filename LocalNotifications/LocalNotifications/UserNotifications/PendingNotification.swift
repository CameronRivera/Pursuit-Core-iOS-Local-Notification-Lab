//
//  PendingNotification.swift
//  LocalNotifications
//
//  Created by Cameron Rivera on 2/20/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import Foundation
import UserNotifications

class PendingNotification {
    public func getPendingNotification(completion: @escaping ([UNNotificationRequest]) -> ()){
        UNUserNotificationCenter.current().getPendingNotificationRequests { request in
            completion(request)
        }
    }
}
