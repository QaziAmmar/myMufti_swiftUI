//
//  CategoryListView.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 05/07/2022.
//

import SwiftUI

struct CategoryListView: View {
    
    @ObservedObject var vm: PostQuestionViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        loadView()
    }
}


extension CategoryListView {
    func loadView() -> some View {
        VStack {
            NavBar(action: {
                presentationMode.wrappedValue.dismiss()
            }, titile: "Categories")
            
            ScrollView {
                LazyVStack {
                    
                    ForEach($vm.categories) { category in
                        CategoryRow(category: category)
                    }
                    
                }
            }.padding()
        }
    }
}


struct CategoryListView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryListView(vm: PostQuestionViewModel())
    }
}
