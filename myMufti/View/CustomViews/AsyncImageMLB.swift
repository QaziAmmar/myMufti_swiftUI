//
//  AsyncImageMLB.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 23/06/2022.
//

import SwiftUI

struct AsyncImageMLB: View {
    
    let url: URL?
    
    var body: some View {
        
        AsyncImage(
            url: url,
            transaction: Transaction(animation: .easeInOut)
        ) { phase in
            switch phase {
            case .empty:
                //                     ProgressView()
                Image(systemName: "person.circle")
                    .foregroundColor(.black)
                    .padding(10)
                
            case .success(let image):
                image
                    .resizable()
                    .transition(.scale(scale: 0.1, anchor: .center))
            case .failure:
                //                 Image(systemName: "wifi.slash")
                Image(systemName: "person.circle")
                    .foregroundColor(.black)
                    .padding(10)
                
            @unknown default:
                EmptyView()
            }
        }
    }
}

struct AsyncImageMLB_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageMLB(url: URL(string: "www.google.com")!)
    }
}
