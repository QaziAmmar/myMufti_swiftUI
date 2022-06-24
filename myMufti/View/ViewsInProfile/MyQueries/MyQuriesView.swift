//
//  MyQuriesView.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 21/06/2022.
//

import SwiftUI

struct MyQuriesView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @StateObject var vm = MyQueriesViewModel()
    
    var body: some View {
        loadView()
            .onAppear() {
                vm.callMyQueryAPI()
            }
    }
}


// MARK: - View Extension
extension MyQuriesView {
    
    func loadView() -> some View {
        
        VStack {
            NavBar(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, titile: "My Queries")
            
            ScrollView {
                VStack {
                    ForEach($vm.myQueries) { myQuery in
                        MyQueryRow(query: myQuery)
                    }
                }
            }
        }
    }
}


struct MyQuriesView_Previews: PreviewProvider {
    static var previews: some View {
        MyQuriesView()
    }
}
