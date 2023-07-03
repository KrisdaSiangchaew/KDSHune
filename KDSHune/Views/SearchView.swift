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
            .contentShape(Rectangle())
            .onTapGesture { }
        }
        .listStyle(.plain)
        .overlay { listSearchOverlay }
    }
    
    @ViewBuilder
    private var listSearchOverlay: some View {
        switch searchVM.phase {
        case .failure(let error):
            ErrorStateView(error: error.localizedDescription) { }
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
        let vm = SearchViewModel()
        vm.phase = .success(Ticker.stubs)
        return vm
    }()
    
    @StateObject static var emptySearchVM: SearchViewModel = {
        let vm = SearchViewModel()
        vm.query = "theranos"
        vm.phase = .empty
        return vm
    }()
    
    @StateObject static var loadingSearchVM: SearchViewModel = {
        let vm = SearchViewModel()
        vm.phase = .fetching
        return vm
    }()
    
    @StateObject static var errorSearchVM: SearchViewModel = {
        let vm = SearchViewModel()
        vm.phase = .failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "An Error Occurred"]))
        return vm
    }()
    
    @StateObject static var appVM: AppViewModel = {
        let vm = AppViewModel()
        vm.tickers = Array(Ticker.stubs.prefix(upTo: 2))
        return vm
    }()
    
    static var quoteVM: QuotesViewModel = {
        let vm = QuotesViewModel()
        vm.quoteDict = GlobalQuoteData.stubsDict
        return vm
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
