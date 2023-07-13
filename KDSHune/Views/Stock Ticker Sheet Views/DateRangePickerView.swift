//
//  DateRangePickerView.swift
//  KDSHune
//
//  Created by Kris on 13/7/2566 BE.
//

import SwiftUI
import AlphaVantageStockAPI

struct DateRangePickerView: View {
    
    let seriesRange = SeriesRange.allCases
    
    @Binding var selectedRange: SeriesRange
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 16) {
                ForEach(self.seriesRange) { range in
                    Button {
                        self.selectedRange = range
                    } label: {
                        Text(range.title)
                            .font(.callout.bold())
                            .padding(8)
                    }
                    .buttonStyle(.plain)
                    .contentShape(Rectangle())
                    .background {
                        if range == selectedRange {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.gray.opacity(0.6))
                        }
                    }
                }
            }.padding(.horizontal)
        }
        .scrollIndicators(.hidden)
    }
}

struct DateRangePickerView_Previews: PreviewProvider {
    @State static var selectedRange = SeriesRange.daily
    
    static var previews: some View {
        DateRangePickerView(selectedRange: $selectedRange)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
