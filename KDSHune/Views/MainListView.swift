//
//  ContentView.swift
//  KDSHune
//
//  Created by Kris on 30/6/2566 BE.
//

import SwiftUI
import AlphaVantageStockAPI

struct MainListView: View {
    @EnvironmentObject var appVM: AppViewModel
    @StateObject var quotesVM = QuotesViewModel()
    
    var body: some View {
        tickerListView
            .listStyle(.plain)
            .overlay { overlayView }
            .toolbar {
                titleToolbar
            }
    }
    
    @ViewBuilder
    private var overlayView: some View {
        if appVM.tickers.isEmpty {
            EmptyStateView(text: appVM.emptyTickerText)
        }
    }
    
    private var tickerListView: some View {
        List {
            ForEach(appVM.tickers) { ticker in
                TickerListRowView(data: .init(symbol: ticker.symbol, name: ticker.name, price: quotesVM.priceForTicker(ticker), type: .main))
                    .contentShape(Rectangle())
                    .onTapGesture { }
            }
            .onDelete { appVM.removeTickers(atOffsets: $0) }
        }
    }
    
    private var titleToolbar: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            VStack(alignment: .leading, spacing: 4) {
                Text(appVM.titleText)
                Text(appVM.subtitleText)
                    .foregroundColor(Color(uiColor: .secondaryLabel))
            }
            .font(.title2.bold())
        }
    }
}

struct MainListView_Previews: PreviewProvider {
    @StateObject static var appVM: AppViewModel = {
        let vm = AppViewModel()
        vm.tickers = Ticker.stubs
        return vm
    }()
    
    @StateObject static var emptyAppVM: AppViewModel = {
        let vm = AppViewModel()
        vm.tickers = []
        return vm
    }()
    
    @StateObject static var quotesVM: QuotesViewModel = {
        let vm = QuotesViewModel()
        vm.quoteDict = GlobalQuoteData.stubsDict
        return vm
    }()
    
    static var previews: some View {
        Group {
            NavigationStack {
                MainListView(quotesVM: quotesVM)
            }
            .environmentObject(appVM)
            .previewDisplayName("With Tickers")
            
            NavigationStack {
                MainListView(quotesVM: quotesVM)
            }
            .environmentObject(emptyAppVM)
            .previewDisplayName("Without Tickers")
        }
    }
}
