//
//  StockTickerView.swift
//  KDSHune
//
//  Created by Kris on 12/7/2566 BE.
//

import SwiftUI
import AlphaVantageStockAPI

struct StockTickerView: View {
    @StateObject var quoteVM: TickerGlobalQuoteViewModel
    @State var selectedRange = SeriesRange.daily
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            headerView.padding(.horizontal)
            
            Divider()
                .padding(.vertical, 8)
                .padding(.horizontal)
            
            scrollView
            
        }
        .padding(.top)
        .background(Color(uiColor: .systemBackground))
        .task { await quoteVM.fetchQuote() }
    }
    
    private var scrollView: some View {
        ScrollView {
            priceDiffRowView
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 8)
                .padding(.horizontal)
            
            Divider()
            
            DateRangePickerView(selectedRange: $selectedRange)
            
        }
        .scrollIndicators(.hidden)
        .frame(width: .infinity, alignment: .leading)
    }
    
    private var priceDiffRowView: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let quote = quoteVM.quoteData {
                HStack {
                    tickerPriceStackView(price: quote.priceText, change: quote.changeText)
                    
                    Spacer()
                }
            }
        }
    }
    
    private func tickerPriceStackView(price: String, change: String) -> some View {
        VStack(alignment: .leading) {
            HStack(alignment: .lastTextBaseline, spacing: 16) {
                Text(price).font(.headline.bold())
                Text(change).font(.subheadline.weight(.semibold))
                    .foregroundColor(change.hasPrefix("-") ? .red : .green)
            }
            
            tickerRegionCurrencyView
        }
    }
    
    private var tickerRegionCurrencyView: some View {
        HStack(spacing: 4) {
            Text("\(quoteVM.ticker.region ?? "unknown") · \(quoteVM.ticker.currency ?? "unknown")" )
        }
        .font(.subheadline.weight(.semibold))
        .foregroundColor(Color(uiColor: .secondaryLabel))
    }
    
    private var headerView: some View {
        HStack(alignment: .lastTextBaseline) {
            Text(quoteVM.ticker.symbol ?? "")
                .font(.title2).bold()
            Text(quoteVM.ticker.name ?? "")
                .font(.subheadline.weight(.semibold))
                .foregroundColor(Color(uiColor: .secondaryLabel))
            Spacer()
            closeButton
        }
    }
    
    private var closeButton: some View {
        Button {
            dismiss()
        } label: {
            Circle()
                .frame(width: 36, height: 36)
                .foregroundColor(.gray.opacity(0.1))
                .overlay {
                    Image(systemName: "xmark")
                        .font(.system(size: 18))
                        .foregroundColor(Color(uiColor: .secondaryLabel))
                }
        }
        .buttonStyle(.plain)
    }
}

struct StockTickerView_Previews: PreviewProvider {
    static var successStubTickerGlobalQuoteVM: TickerGlobalQuoteViewModel = {
        var mockAPI = MockStockAPI()
        mockAPI.stubbedFetchGlobalQuoteCallback = {
            [GlobalQuote.stub]
        }
        return TickerGlobalQuoteViewModel(ticker: .stub, stockAPI: mockAPI)
    }()
    
    static var loadingStubTickerGlobalQuoteVM: TickerGlobalQuoteViewModel = {
        var mockAPI = MockStockAPI()
        mockAPI.stubbedFetchGlobalQuoteCallback = {
            await withCheckedContinuation { _ in
                
            }
        }
        return TickerGlobalQuoteViewModel(ticker: .stub, stockAPI: mockAPI)
    }()
    
    static var errorStubTickerGlobalQuoteVM: TickerGlobalQuoteViewModel = {
        var mockAPI = MockStockAPI()
        mockAPI.stubbedFetchGlobalQuoteCallback = {
            throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "An error occurred"])
        }
        return TickerGlobalQuoteViewModel(ticker: .stub, stockAPI: mockAPI)
    }()
    
    static var previews: some View {
        Group {
            StockTickerView(quoteVM: successStubTickerGlobalQuoteVM)
                .previewDisplayName("Success")
                .frame(height: 700)
            StockTickerView(quoteVM: loadingStubTickerGlobalQuoteVM)
                .previewDisplayName("Loading")
                .frame(height: 700)
            StockTickerView(quoteVM: errorStubTickerGlobalQuoteVM)
                .previewDisplayName("Error")
                .frame(height: 700)
        }.previewLayout(.sizeThatFits)
    }
}
