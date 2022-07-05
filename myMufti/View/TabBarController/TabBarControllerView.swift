//
//  TabBarControllerView.swift
//  BattleRap
//
//  Created by Qazi Ammar Arshad on 08/03/2022.
//

import SwiftUI

struct TabBarControllerView: View {
    
    @State private var tabSelection = 0
    
    init() {
        
        UITabBar.appearance().backgroundColor = .white
        UITabBar.appearance().unselectedItemTintColor = .white
        
    }
    
    var body: some View {
       
        TabView(selection: $tabSelection) {
            
            HideNavbarOf(view: HomeView())
                .tabItem {
                    Label("", image: tabSelection == 0 ? ImageName.home_green.rawValue : ImageName.home.rawValue)
                }
                .tag(0)
            
            HideNavbarOf(view: AskQuestionView())
            
                .tabItem {
                    Label("", image: tabSelection == 1 ? ImageName.mufties_green.rawValue : ImageName.mufties.rawValue)
                }
                .tag(1)
            
            HideNavbarOf(view: Chat())
            
                .tabItem {
                    Label("", image: tabSelection == 2 ? ImageName.chat_green.rawValue : ImageName.chat.rawValue)
                }
                .tag(2)
            
            HideNavbarOf(view: ProfileView())
                .tabItem {
                    Label("", image: tabSelection == 3 ? ImageName.profile_green.rawValue : ImageName.profile.rawValue)
                }
                .tag(3)

            
        }.accentColor(Color.green)
        .onReceive(UserDefaultManager.changeTab, perform: { tag in
            tabSelection = tag
        })
        .navigationBarHidden(true)
            
        
        // fix the backgroud color of tabbar on scrolle
        
    }
}

struct TabBarControllerView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarControllerView()
    }
}
