//
//  String+Extensions.swift
//  LocalNotifications
//
//  Created by Cameron Rivera on 2/20/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import Foundation

extension String {
    func displayHumanReadableDateAndTime(_ interval: TimeInterval) -> String{
        let humanDate = NSDate(timeIntervalSinceNow: interval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM d, YYYY h:mm a"
        return dateFormatter.string(from: humanDate as Date)
    }
}
