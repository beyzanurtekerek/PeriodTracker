//
//  FirstPeriodDateView.swift
//  PeriodTracker
//
//  Created by Beyza Nur Tekerek on 14.01.2025.
//

import SwiftUI

struct FirstPeriodDateView: View {
    @Binding var firstPeriodDate: Date // DatePicker ile bağlanan değişken
    
    var body: some View {
        VStack {
            Text("İlk Regl Tarihinizi Girin")
                .font(.headline)
                .padding(.top, 10)
            
            DatePicker("İlk Regl Tarihi", selection: $firstPeriodDate, displayedComponents: .date)
                .datePickerStyle(WheelDatePickerStyle())
                .padding()
        }
        .navigationTitle("İlk Regl Tarihi")
        .navigationBarTitleDisplayMode(.inline)
        .environment(\.locale, Locale(identifier: "tr_TR"))
    }
}
