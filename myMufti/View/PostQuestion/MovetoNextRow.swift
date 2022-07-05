//
//  MovetoNextRow.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 05/07/2022.
//

import SwiftUI

struct MovetoNextRow: View {
    
    var name = ""
    var image = ""
    var action: () -> Void
    
    
    var body: some View {
        loadView()
    }
}


extension MovetoNextRow {
    
    func loadView() -> some View {
        
        ZStack {
            
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 40)
                .foregroundColor(.white)
                .shadow(color: .gray, radius: 2)
            
            
            Button {
                self.action()
            } label: {
                HStack {
                    Text(name)
                        .font(.system(size: 11))
                    Spacer()
                        Image(image)
                            .resizable()
                            .frame(width: 7, height: 12)
                }
            }
            .foregroundColor(.black)
            .padding()

        }
    }
}


struct MovetoNextRow_Previews: PreviewProvider {
    static var previews: some View {
        MovetoNextRow(action: {
            print("Action btn")
        })
    }
}
