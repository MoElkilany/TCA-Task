//
//  TCA_GiveawayApp.swift
//  TCA-Giveaway
//
//  Created by Elkilany on 13/07/2024.
//

import SwiftUI
import ComposableArchitecture

@main
struct TCA_GiveawayApp: App {
    var body: some Scene {
        WindowGroup {
            GiveawaysListPage(store: Store(initialState: GiveawayReducer.State(), reducer: {
                GiveawayReducer()
            }))
        }
    }
}
