//
//  HomePageModel.swift
//  PeriodTracker
//
//  Created by Beyza Nur Tekerek on 14.01.2025.
//

import Foundation
import SwiftUI

class HomePageModel: ObservableObject {
    @Published var periodLength: Int
    @Published var cycleLength: Int
    @Published var firstPeriodDate: Date
    let ovulationLength: Double = 3.0  // Sabit Ovulasyon Süresi

    // Init methodu ile başlangıç değerlerini alıyoruz
    init(periodLength: Int, cycleLength: Int, firstPeriodDate: Date) {
        self.periodLength = periodLength
        self.cycleLength = cycleLength
        self.firstPeriodDate = firstPeriodDate
    }

    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM"
        dateFormatter.locale = Locale(identifier: "tr_TR")
        return dateFormatter.string(from: Date())
    }

    var formattedFirstPeriodDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM"
        dateFormatter.locale = Locale(identifier: "tr_TR")
        return dateFormatter.string(from: firstPeriodDate)
    }

    var nextPeriodDate: String {
        guard cycleLength > 0 else { return "" }
        let nextPeriod = Calendar.current.date(byAdding: .day, value: cycleLength, to: firstPeriodDate)!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM"
        dateFormatter.locale = Locale(identifier: "tr_TR")
        return dateFormatter.string(from: nextPeriod)
    }

    var ovulationStart: CGFloat {
        guard cycleLength > 0 else { return 0 }
        let startDay = (Double(cycleLength) / 2) - 1
        return CGFloat(startDay) / CGFloat(cycleLength)
    }

    var ovulationEnd: CGFloat {
        guard cycleLength > 0 else { return 0 }
        let startDay = (Double(cycleLength) / 2) - 1
        let endDay = startDay + ovulationLength
        return CGFloat(endDay) / CGFloat(cycleLength)
    }
}
