//
//  HomePageViewModel.swift
//  PeriodTracker
//
//  Created by Beyza Nur Tekerek on 14.01.2025.
//

import SwiftUI

class HomePageViewModel: ObservableObject {
    @Published var homePageModel: HomePageModel
    @Published var isAnimation: Bool = false

    // Bugün itibariyle döngüdeki günün hesaplanması
    var currentDay: Int {
        let today = Date()
        let calendar = Calendar.current
        let daysBetween = calendar.dateComponents([.day], from: homePageModel.firstPeriodDate, to: today).day ?? 0
        let cycleDay = (daysBetween % homePageModel.cycleLength) + 1 // Döngü uzunluğu ile mod alıyoruz
        return cycleDay
    }
    
    init(homePageModel: HomePageModel) {
        self.homePageModel = homePageModel
    }

    func updatePeriodLength(_ length: Int) {
        homePageModel.periodLength = length
    }

    func updateCycleLength(_ length: Int) {
        homePageModel.cycleLength = length
    }

    func updateFirstPeriodDate(_ date: Date) {
        homePageModel.firstPeriodDate = date
    }
    
    func startAnimation() {
        withAnimation {
            isAnimation = true
        }
    }
    
}
