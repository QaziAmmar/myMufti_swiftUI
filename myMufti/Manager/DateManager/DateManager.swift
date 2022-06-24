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
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.date(from: strDate) ?? Date()

        let outformatter = DateFormatter()
        outformatter.dateFormat = "MMMM d yyyy"
        return outformatter.string(from: date)
    }
    
    func timeAgoDisplay(from strDate: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = formatter.date(from: strDate) ?? Date()
        return timeAgoDisplay(from: date)
    }
    
    
    func timeAgoDisplay(from date: Date) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: date, relativeTo: Date())
    }
    
    
    
}


//extension Date {

//}
