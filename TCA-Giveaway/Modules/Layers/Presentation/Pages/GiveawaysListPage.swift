//
//  GiveawaysListPage.swift
//  TCA-Giveaway
//
//  Created by Elkilany on 13/07/2024.
//

import SwiftUI
import ComposableArchitecture

struct GiveawaysListPage: View {
    
    @State var store: StoreOf<GiveawayReducer>
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    VStack {
                        if store.isLoading {
                            LoadingView()
                        } else if let errorMessage = store.epicGamesStoreErrorMessage {
                            ErrorView(errorMessage: errorMessage)
                        } else {
                            EpicGamesStoreView(giveaways: store.epicGamesStore)
                        }
                    }
                    .frame(height: 250)
                    
                    Spacer()
                    
                    ChoosePlateform(onSelectPlateform: { platform in
                        store.send(.filterGiveaways(platform))
                    })
                    
                    Spacer()
                    
                    if store.isLoading {
                        LoadingView()
                    } else if let errorMessage = store.giveawaysErrorMessage {
                        ErrorView(errorMessage: errorMessage)
                    } else {
                        FilteredGiveawaysView(giveaways: store.filteredGiveaways, store: store)
                    }
                }
            }
            .navigationTitle("Game Giveaways")
            .onAppear {
                sendActions()
            }
            .navigationDestination(item: $store.scope(state:\.destination?.detailsPageState, action: \.destination.detailsPageState)) { store in
                GiveawaysDetailsPage(store:store)
            }
//                                        .sheet(item: $store.scope(state:\.destination?.detailsPageState, action: \.destination.detailsPageState)) { store in
//                                            GiveawaysDetailsPage(store:store)
//                                                .padding(.horizontal,20)
//                                        }
            
        }
    }
}


extension GiveawaysListPage {
    private func sendActions() {
        if store.epicGamesStore.isEmpty {
            store.send(.fetchGiveawaysByPlatform(Constants.epicGamesStore.rawValue))
        }
        
        if store.giveawaysList.isEmpty {
            store.send(.fetchGiveaways)
        }
    }
}
