//
//  DateUtils.swift
//  Assignment
//
//  Created by Abhishek on 18/08/21.
//

import Foundation

class DateUtils {
    
static func stringToDateWithFormat(date: String, format: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    let dateFromString: Date = dateFormatter.date(from: date)! as Date
    return dateFromString
}

    /// get date object in tuples
    /// - parameter date: A date type object
    /// - parameter isUTC: it will decide that is it in UTC format or not
    /// - parameter is24HourFormat: it will decide that time will be in 24 hour format or not.
    /// - returns: It will return most of the required data into tuple format in one call.
    static func getDateDetails( date:Date,_ isUTC: Bool = false, _ is24HourFormat: Bool = false ) -> (dayName:String, month:String, year:String, day:String, monthName: String, fullMonthName:String, hours:String, minutes:String, seconds:String, amPm: String){
        let formatter  = DateFormatter()
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.ISO8601)!
        if isUTC {
            myCalendar.timeZone = TimeZone(abbreviation: "UTC")!
        }
        let myComponents = myCalendar.components([.weekday,.year,.day,.month, .hour, .minute, .second], from: date)
        formatter.dateFormat = "MMMM"
        let monthName = formatter.string(from: date)
        formatter.dateFormat = "EEEE"
        let startIndex = monthName.index(monthName.startIndex, offsetBy: 3)
        var hour = myComponents.hour! < 10 ? "0\(myComponents.hour!)" : "\(myComponents.hour!)"
        if !is24HourFormat {
            if myComponents.hour! > 12 {
                let hr = myComponents.hour! - 12
                hour = hr < 10 ? "0\(hr)" : "\(hr)"
            }
        }
        let minute = myComponents.minute! < 10 ? "0\(myComponents.minute!)" : "\(myComponents.minute!)"
        let second = myComponents.second! < 10 ? "0\(myComponents.second!)" : "\(myComponents.second!)"
        let month = myComponents.month! < 10 ? "0\(myComponents.month!)" : "\(myComponents.month!)"
        let day = myComponents.day! < 10 ? "0\(myComponents.day!)" : "\(myComponents.day!)"

        formatter.dateFormat = "a"
        let amPm = formatter.string(from: date)
        return(dayName: formatter.string(from: date), month: month, year: String(describing: myComponents.year!), day: day, String(monthName[..<startIndex]) ,monthName, hours:hour, minutes:minute, seconds:second, amPm: amPm)
    }
    
}
