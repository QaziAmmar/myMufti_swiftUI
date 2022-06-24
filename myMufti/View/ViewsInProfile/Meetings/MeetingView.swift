//
//  MeetingView.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 23/06/2022.
//

import SwiftUI

struct MeetingView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @StateObject var vm = MeetingViewModel()
    
    var body: some View {
        loadView()
            .onAppear() {
                vm.callMyMeetingAPI()
            }
    }
}

extension MeetingView {
    func loadView() -> some View {
        VStack {
            NavBar(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, titile: "Meetings")
            
            ScrollView {
            
                if vm.meetings.count == 0 {
                    Text("No Meeting Found")
                        .font(.custom(Popins.regular.rawValue, size: 24))
                } else {
                    ForEach(vm.meetings) { meeting in
                        VStack {
                            MeetingRow(meeting: meeting)
                        }
                    }
                }
            }
        }
    }
}


struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView()
    }
}
