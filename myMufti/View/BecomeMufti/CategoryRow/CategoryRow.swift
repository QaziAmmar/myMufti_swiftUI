//
//  CategoryRow.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 04/07/2022.
//

import SwiftUI

struct CategoryRow: View {
    
    
    @Binding var category: MuftiCategory
    
    var body: some View {
        loadView()
    }
}


// MARK: - View extension
extension CategoryRow {
    
    func loadView() -> some View {
        HStack {
            
            Text(category.name)
                .font(.custom(Popins.semiBold.rawValue, size: 17))
                .padding([.leading])
            
            Spacer()
            
            Button {
                category.isSelected.toggle()
            } label: {
                Image(category.isSelected ? ImageName.checkbox_checked.rawValue : ImageName.checkbox_unchecked.rawValue)
                    .resizable()
                    .frame(width: 20, height: 20)
            }.padding()

        }
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.gray.opacity(0.5), lineWidth: 1)
        )
    }
        
    
}


struct CategoryRow_Previews: PreviewProvider {
    static var previews: some View {
        CategoryRow(category: .constant(MuftiCategory(name: "Marriage", isSelected: false)))
    }
}
