//
//  KDSHuneApp.swift
//  KDSHune
//
//  Created by Kris on 30/6/2566 BE.
//

import SwiftUI
import AlphaVantageStockAPI

@main
struct KDSHuneApp: App {
    @StateObject var appVM = AppViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MainListView()
            }
            .environmentObject(appVM)
        }
    }
}
