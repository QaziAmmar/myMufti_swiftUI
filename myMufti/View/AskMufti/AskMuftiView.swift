//
//  AskMuftiView.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 20/06/2022.
//

import SwiftUI

struct AskMuftiView: View {
    
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @StateObject var vm = AskMuftiViewModel()
    
    var body: some View {
        loadView()
            .onAppear() {
                vm.getAllMuftiesApi()
            }
    }
}


// MARK: - View Extension
extension AskMuftiView {
    
    func loadView() -> some View {
        
        VStack {
            Text("Ask Muftis")
                .font(.custom(Popins.bold.rawValue, size: 16))
                .padding([.top])
            
            SearchBar(text: $vm.searchText)
            
            ScrollView {
                if vm.mufties.count == 0 {
                    Text("No Mufti Found")
                        .font(.custom(Popins.regular.rawValue, size: 24))
                } else {
                    ForEach(vm.mufties) { mufti in
                        MuftiRow(mufti: mufti)
                    }
                }
            }
        }.padding()
    }
}

struct AskMuftiView_Previews: PreviewProvider {
    static var previews: some View {
        AskMuftiView()
    }
}
