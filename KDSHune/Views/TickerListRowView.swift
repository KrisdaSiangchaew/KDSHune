//
//  TickerDataRowView.swift
//  KDSHune
//
//  Created by Kris on 30/6/2566 BE.
//

import SwiftUI

struct TickerListRowView: View {
    let data: TickerListRowData
    
    var body: some View {
        HStack(alignment: .center) {
            if case let .search(isSaved, onButtonTap) = data.type {
                Button {
                    onButtonTap()
                } label: {
                    image(isSaved: isSaved)
                }
            }
            
            VStack(alignment: .leading) {
                Text(data.symbol ?? "").font(.headline.bold())
                if let name = data.name {
                    Text(name)
                        .font(.subheadline)
                        .foregroundColor(Color(uiColor: .secondaryLabel))
                }
            }
            
            Spacer()
            
            if let (price, change) = data.price {
                VStack(alignment: .trailing, spacing: 4) {
                    Text(price)
                    priceChangeView(text: change)
                }
                .font(.headline.bold())
            }
        }
    }
    
    @ViewBuilder
    func image(isSaved: Bool) -> some View {
        if isSaved {
            Image(systemName: "checkmark.circle.fill")
                .symbolRenderingMode(.palette)
                .foregroundStyle(Color.white, Color.accentColor)
                .imageScale(.large)
        } else {
            Image(systemName: "plus.circle.fill")
                .symbolRenderingMode(.palette)
                .foregroundStyle(Color.accentColor, Color.secondary.opacity(0.3))
                .imageScale(.large)
        }
    }
    
    @ViewBuilder
    func priceChangeView(text: String) -> some View {
        if case .main = data.type {
            ZStack(alignment: .trailing) {
                RoundedRectangle(cornerRadius: 4)
                    .foregroundColor(text.hasPrefix("-") ? .red : .green)
                    .frame(height: 24)
                
                Text(text)
                    .foregroundColor(.white)
                    .font(.caption.bold())
                    .padding(.horizontal, 8)
            }.fixedSize()
        } else {
            Text(text)
                .foregroundColor(text.hasPrefix("-") ? .red : .green)
        }
    }
}

struct TickerDataRowView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading) {
            Text("Main List")
            VStack {
                TickerListRowView(data: appleTickerListRowData(rowType: .main))
                TickerListRowView(data: ibmTickerListRowData(rowType: .main))
            }.padding()
            
            Text("Search List")
            VStack {
                TickerListRowView(data: appleTickerListRowData(rowType: .search(isSaved: true, onButtonTap: {})))
                TickerListRowView(data: ibmTickerListRowData(rowType: .search(isSaved: false, onButtonTap: {})))
            }.padding()
        }.previewLayout(.sizeThatFits)
    }
    
    static func appleTickerListRowData(rowType: TickerListRowData.RowType) -> TickerListRowData {
        TickerListRowData(symbol: "AAPL", name: "Apple Inc.", price: ("234.44", "-2.33"), type: rowType)
    }
    
    static func ibmTickerListRowData(rowType: TickerListRowData.RowType) -> TickerListRowData {
        TickerListRowData(symbol: "IBM", name: "International Business Machine Co. Ltd.", price: ("55.21", "0.33"), type: rowType)
    }
}
