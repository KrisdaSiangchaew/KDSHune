//
//  SearchView.swift
//  KDSHune
//
//  Created by Kris on 3/7/2566 BE.
//

import SwiftUI
import AlphaVantageStockAPI

struct SearchView: View {
    @EnvironmentObject var appVM: AppViewModel
    @StateObject var quotesVM = QuotesViewModel()
    @ObservedObject var searchVM: SearchViewModel
    
    var body: some View {
        List(searchVM.tickers) { ticker in
            TickerListRowView(data:
                    .init(
                        symbol: ticker.symbol,
                        name: ticker.name,
                        price: quotesVM.priceForTicker(ticker),
                        type: .search(
                            isSaved: appVM.isAddedToMyTickers(ticker: ticker),
                            onButtonTap: { appVM.toggleTicker(ticker) }
                        )
                    )
            )
//            .contentShape(Rectangle())
//            .onTapGesture { }
        }
        .listStyle(.plain)
        .refreshable {
            await quotesVM.fetchQuotes(tickers: searchVM.tickers)
        }
        .task(id: searchVM.tickers) {
            await quotesVM.fetchQuotes(tickers: searchVM.tickers)
        }
        .overlay { listSearchOverlay }
    }
    
    @ViewBuilder
    private var listSearchOverlay: some View {
        switch searchVM.phase {
        case .failure(let error):
            ErrorStateView(error: error.localizedDescription) {
                Task {
                    await searchVM.searchTickers()
                }
            }
        case .empty:
            EmptyStateView(text: searchVM.emptyListText)
        case .fetching:
            LoadingStateView()
        default:
            EmptyView()
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    @StateObject static var stubbedSearchVM: SearchViewModel = {
        var mock = MockStockAPI()
        mock.stubbedTickerSearchCallback = { Ticker.stubs }
        return SearchViewModel(query: "Test", stockAPI: mock)
    }()
    
    @StateObject static var emptySearchVM: SearchViewModel = {
        var mock = MockStockAPI()
        mock.stubbedTickerSearchCallback = { [] }
        return SearchViewModel(query: "Empty", stockAPI: mock)
    }()
    
    @StateObject static var loadingSearchVM: SearchViewModel = {
        var mock = MockStockAPI()
        mock.stubbedTickerSearchCallback = {
            await withCheckedContinuation { _ in }
        }
        return SearchViewModel(query: "Loading", stockAPI: mock)
    }()
    
    @StateObject static var errorSearchVM: SearchViewModel = {
        var mock = MockStockAPI()
        mock.stubbedTickerSearchCallback = { throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "An Error Occurred"]) }
        return SearchViewModel(query: "Error", stockAPI: mock)
    }()
    
    @StateObject static var appVM: AppViewModel = {
        var mock = MockTickerListRepository()
        mock.stubbedLoad = { Array(Ticker.stubs.prefix(upTo: 2)) }
        return AppViewModel(repository: mock)
    }()
    
    static var quoteVM: QuotesViewModel = {
        var mock = MockStockAPI()
        mock.stubbedFetchGlobalQuoteCallback = { GlobalQuote.stubs }
        return QuotesViewModel(stockAPI: mock)
    }()
    
    static var previews: some View {
        Group {
            NavigationStack {
                SearchView(quotesVM: quoteVM, searchVM: stubbedSearchVM)
            }
            .searchable(text: $stubbedSearchVM.query)
            .previewDisplayName("Results")
            
            NavigationStack {
                SearchView(quotesVM: quoteVM, searchVM: emptySearchVM)
            }
            .searchable(text: $emptySearchVM.query)
            .previewDisplayName("Empty")
            
            NavigationStack {
                SearchView(quotesVM: quoteVM, searchVM: loadingSearchVM)
            }
            .searchable(text: $loadingSearchVM.query)
            .previewDisplayName("Loading")
            
            NavigationStack {
                SearchView(quotesVM: quoteVM, searchVM: errorSearchVM)
            }
            .searchable(text: $errorSearchVM.query)
            .previewDisplayName("Error")
        }
        .environmentObject(appVM)
    }
}
