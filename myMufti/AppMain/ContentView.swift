//
//  ContentView.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 20/06/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State var isAuthenticated = UserDefaultManager.IsAuthenticated()
    
    var body: some View {
        Group {
            // if isAuthenticated then move to tabBarController
            isAuthenticated ? AnyView(NavigationView(content: {
                TabBarControllerView()
            })) :
//            else move to loginView
            AnyView(
                NavigationView {
                    HideNavbarOf(view: LoginView())
                })
            
        }.onReceive(UserDefaultManager.Authenticated, perform: { newValue in
            isAuthenticated = newValue
        })
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
