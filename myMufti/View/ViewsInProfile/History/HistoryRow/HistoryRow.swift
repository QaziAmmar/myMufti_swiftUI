//
//  HistoryRow.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 24/06/2022.
//

import SwiftUI

struct HistoryRow: View {
    
    //    @Binding var history: History
    
    var body: some View {
        loadView()
    }
}

// MARK: - UIVIew extension
extension HistoryRow {
    
    func loadView() -> some View {
        
        
        VStack {
            
            VStack(alignment: .leading) {
                
                userView()
                
                muftiView()
            }
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.white)
                    .shadow(radius: 1)
        )
            GreenBtn(action: {
                print("Chat Now")
            }, title: "Chat Now")
            .padding([.top])
            
        }.padding([.leading, .trailing, .top])
    }
    
    func userView() -> some View {
        
        VStack {
            
            HStack {
                
                AsyncImageMLB(url: URL(string: ""))
                    .frame(width: 25, height: 25)
                    .clipShape(Circle())
                    .padding(10)
                
                Text("Sikandar bakht")
                    .font(.custom(Popins.semiBold.rawValue, size: 12))
                Text("1st Apr 2022")
                    .font(.custom(Popins.regular.rawValue, size: 8))
                
                Spacer()
                
                Text("Accepted")
                    .font(.custom(Popins.regular.rawValue, size: 8))
                    .padding(10)
                    .foregroundColor(.green)
                
            }
            
            Text("I want to give my Zakat to an Islamic Center, what should I do?")
                .font(.custom(Popins.regular.rawValue, size: 18))
                .padding()
        }
    }
    
    func muftiView() -> some View {
        
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                
                AsyncImageMLB(url: URL(string: ""))
                    .frame(width: 25, height: 25)
                    .clipShape(Circle())
                    .padding(10)
                
                Text("Mufti Ali")
                    .font(.custom(Popins.semiBold.rawValue, size: 12))
                
                Spacer()
                
            }
            
            Text("I want to give my Zakat to an Islamic Center, what should I do?")
                .font(.custom(Popins.regular.rawValue, size: 12))
                .foregroundColor(.gray)
                .padding([.leading, .trailing, .bottom])
        }
        
        
    }
    
}

struct HistoryRow_Previews: PreviewProvider {
    static var previews: some View {
        HistoryRow()
    }
}
