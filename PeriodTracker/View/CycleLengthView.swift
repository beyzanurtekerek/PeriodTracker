//
//  CycleLengthView.swift
//  PeriodTracker
//
//  Created by Beyza Nur Tekerek on 14.01.2025.
//

import SwiftUI

struct CycleLengthView: View {
    @Binding var cycleLength: Int
    
    var body: some View {
        VStack {
            Spacer()
            Text("Kaç günde bir regl oluyorsunuz?")
                .font(.headline)
            Picker("Döngü Süresi", selection: $cycleLength) {
                ForEach(15..<36, id: \.self) { i in
                    Text("\(i) gün").tag(i)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .padding()
            Spacer()
        }
        .navigationTitle("Döngü Süresi")
    }
}
