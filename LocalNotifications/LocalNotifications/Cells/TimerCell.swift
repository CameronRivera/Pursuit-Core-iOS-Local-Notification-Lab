//
//  TimerCell.swift
//  LocalNotifications
//
//  Created by Cameron Rivera on 2/19/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit

class TimerCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public func configureCell(_ request: UNNotificationRequest){
        DispatchQueue.main.async{
            if request.content.body == "" {
                self.textLabel?.text = "No Description Provided"
            }
            
            self.textLabel?.text = request.content.body
            
            if let notificationTrigger = request.trigger as? UNTimeIntervalNotificationTrigger {
                self.detailTextLabel?.text = "".displayHumanReadableDateAndTime(notificationTrigger.timeInterval)
            } else {
                print("Could not downcast as a TimeInteravlNotification")
            }
        }
    }
}
