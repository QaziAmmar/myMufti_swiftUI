//
//  HistoryView.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 24/06/2022.
//

import SwiftUI


// view is completed just need to integerate the API

struct HistoryView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @StateObject var vm = HistoryViewModel()
    
    var body: some View {
        loadView()
            .onAppear() {
//                vm.historyApi()
            }
    }
}


// MARK: - View Extension
extension HistoryView {
    
    func loadView() -> some View {
        
        VStack {
            NavBar(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, titile: "History")
            
            ScrollView {
                if vm.history_array.count == 0 {
                    Text("No History Found")
                        .font(.custom(Popins.regular.rawValue, size: 24))
                } else {
                    ForEach($vm.history_array) { history in
                        HistoryRow()
                    }
                }
            }
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
