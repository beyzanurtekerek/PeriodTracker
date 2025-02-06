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
