//
//  DateExtension.swift
//  Kundelik
//
//  Created by Темирлан Алпысбаев on 2/6/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import Foundation

extension Date {
    
    var day: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: self as Date)
    }
    
    var month: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: self as Date)
    }
    
    var year: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: self as Date)
    }
    
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM. yyyy"
        return dateFormatter.string(from: self)
    }
    
    func toStringDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
    
    func dayMonth() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM"
        return dateFormatter.string(from: self)
    }
    
    func toStringWithTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM HH:mm:ss"
        return dateFormatter.string(from: self)
    }
    
    func toTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self)
    }
    
    var startOfWeek: Date? {
        var gregorian = Calendar(identifier: .gregorian)
        gregorian.firstWeekday = 2
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 1, to: sunday)
    }
    
    var endOfWeek: Date? {
        var gregorian = Calendar(identifier: .gregorian)
        gregorian.firstWeekday = 2
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 7, to: sunday)
    }
    
    var yearsBefore: Date {
        return Calendar.current.date(byAdding: .year, value: -2, to: noon)!
    }
    
    var yearsAfter: Date {
        return Calendar.current.date(byAdding: .year, value: 2, to: noon)!
    }
    
    var weekBefore: Date {
        return Calendar.current.date(byAdding: .weekOfYear, value: -1, to: noon)!
    }
    
    var weekAfter: Date {
        return Calendar.current.date(byAdding: .weekOfYear, value: 1, to: noon)!
    }
    
    var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    
    var tomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
    }
    
    func dayNumberOfWeek() -> Int {
        guard let num = Calendar.current.dateComponents([.weekday], from: self).weekday else {
            return 0
        }
        
        switch num {
        case 2, 3, 4, 5, 6, 7:
            return num - 1
        case 1:
            return 7
        default:
            return 0
        }
    }
    
}
