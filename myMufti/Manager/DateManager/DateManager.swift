//
//  DateManager.swift
//  BattleRap
//
//  Created by Qazi Ammar Arshad on 29/03/2022.
//

import Foundation

class DateManager {
    
    static let standard = DateManager()
    
    
    func monthNameWithDate(strDate: String) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = formatter.date(from: strDate) ?? Date()

        let outformatter = DateFormatter()
        outformatter.dateFormat = "d MMM"
        return outformatter.string(from: date)
    }
   
    func getString(from date: Date) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let strDate = formatter.string(from: date)
        return strDate
    }
    
    
    func timeAgoDisplay(from strDate: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = formatter.date(from: strDate) ?? Date()
        return timeAgoDisplay(from: date)
    }
    
    // 2 days ago
    func timeAgoDisplay(from date: Date) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: date, relativeTo: Date())
    }
    
    // 24 H remaining
    func timeRemaning(from strDate: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        let date = formatter.date(from: strDate) ?? Date()
        return timeAgoDisplay(from: date)
    }
    
    
}


//extension Date {

//}
