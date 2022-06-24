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
                 Image(ImageName.person_placeholder.rawValue)
                                .resizable()
                                .frame(width: 25, height: 25)
                                .padding(10)
                                .clipShape(Circle())
             case .success(let image):
                 image
                     .resizable()
                     .transition(.scale(scale: 0.1, anchor: .center))
             case .failure:
                 Image(systemName: "wifi.slash")
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
