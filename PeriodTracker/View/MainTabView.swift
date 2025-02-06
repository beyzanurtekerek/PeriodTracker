//
//  MainTabView.swift
//  PeriodTracker
//
//  Created by Beyza Nur Tekerek on 6.01.2025.
//

import SwiftUI

struct MainTabView: View {
    var firstName : String
    // @StateObject kullanıyoruz, çünkü burada ilk başlatma işlemi yapılacak.
    @StateObject var homePageViewModel = HomePageViewModel(homePageModel: HomePageModel(periodLength: 5, cycleLength: 28, firstPeriodDate: Date()))

    @State private var selectedTab: Int = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomePageView(firstName: firstName, viewModel: homePageViewModel)
                .tabItem {
                    Image(selectedTab == 0 ? "homeSelectedIcon" : "homeIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                }
                .tag(0)
            
            RecipesView()
                .tabItem {
                    Image(selectedTab == 1 ? "recipeSelectedIcon" : "recipeIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                }
                .tag(1)
            
            SettingsView()
                .tabItem {
                    Image(selectedTab == 2 ? "settingsSelectedIcon" : "settingsIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                }
                .tag(2)
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    MainTabView(firstName: "Beyza")
}
