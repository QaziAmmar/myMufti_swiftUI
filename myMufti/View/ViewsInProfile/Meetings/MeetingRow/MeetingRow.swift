//
//  MeetingRow.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 23/06/2022.
//

import SwiftUI

struct MeetingRow: View {
    
    let meeting: Meeting
    
    var body: some View {
        loadView()
    }
}

extension MeetingRow {
    
    func loadView() -> some View {
        HStack(alignment: .top) {
         
            Text(DateManager.standard.monthNameWithDate(strDate: meeting.createdAt ?? ""))
                .font(.custom(Popins.regular.rawValue, size: 16))
                .padding([.leading], 10)
                .padding([.trailing], 5)
            
            
            VStack(spacing: 0) {
                Rectangle()
                    .foregroundColor(.gray)
                    .frame(height: 1)
                
                HStack {
                    Rectangle()
                        .foregroundColor(Color(ColorName.appGreen.rawValue))
                        .frame(width: 10, height: 80)
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Meeting")
                            .font(.custom(Popins.medium.rawValue, size: 16))
                        Text(meeting.questions)
                            .font(.custom(Popins.regular.rawValue, size: 13))
                        Text("1 pm - 3 pm")
                            .font(.custom(Popins.bold.rawValue, size: 10))
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
            }
        }
    }
    
}

struct MeetingRow_Previews: PreviewProvider {
    static var previews: some View {
        MeetingRow(meeting: Meeting(quesID: "", userID: "", muftiID: "", questions: "", category: "", date: "", createdAt: "", modified: "", status: ""))
    }
}
