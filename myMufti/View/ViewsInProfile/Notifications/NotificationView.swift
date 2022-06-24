//
//  NotificationView.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 21/06/2022.
//

import SwiftUI

struct NotificationView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        loadView()
    }
}

// MARK: - UIView Extension
extension NotificationView {
    
    func loadView() -> some View {
        
        VStack {
            NavBar(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, titile: "Notifications")
            
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    NotificationRow()
                    NotificationRow()
                }
            }
            
        }
        
        
    }
    
}


struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
