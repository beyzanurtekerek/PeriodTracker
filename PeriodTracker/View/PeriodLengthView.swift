//
//  PeriodLengthView.swift
//  PeriodTracker
//
//  Created by Beyza Nur Tekerek on 14.01.2025.
//

import SwiftUI

struct PeriodLengthView: View {
    @Binding var periodLength: Int
    
    var body: some View {
        VStack {
            Spacer()
            Text("Regliniz kaç gün sürüyor?")
                .font(.headline)
            Picker("Regl Süresi", selection: $periodLength) {
                ForEach(1..<31, id: \.self) { i in
                    Text("\(i) gün").tag(i)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .padding()
            Spacer()
        }
        .navigationTitle("Regl Süresi")
    }
}

