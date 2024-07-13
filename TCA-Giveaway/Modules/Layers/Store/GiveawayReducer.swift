//
//  GiveawayReducer.swift
//  TCA-Giveaway
//
//  Created by Elkilany on 13/07/2024.
//

import Foundation
import ComposableArchitecture
import Combine

@Reducer
struct GiveawayReducer:Reducer {
    
    @Dependency(\.apiClient) var apiClient
    @Dependency(\.favoritesManager) var favoritesManager
    
    @ObservableState
    struct State: Equatable {
        @Presents var destination: Destination.State?
        var epicGamesStore: [Giveaway] = []
        var giveawaysList: [Giveaway] = []
        var filteredGiveaways: [Giveaway] = []
        var isLoading: Bool = false
        var epicGamesStoreErrorMessage: String?
        var giveawaysErrorMessage: String?
        var favoriteGiveaways: [Int] = []
    }
    
    @Reducer(state:.equatable)
    enum Destination {
        case detailsPageState(GiveawayDetailsReducer)
    }
    
    enum Action: BindableAction {
        case fetchGiveaways
        case fetchGiveawaysByPlatform(String)
        case giveawaysResponse(Result<[Giveaway], APIError>)
        case giveawaysByPlatformResponse(Result<[Giveaway], APIError>)
        case filterGiveaways(String)
        case setLoading(Bool)
        case binding(BindingAction<State>)
        case destination(PresentationAction<Destination.Action>)
        case push(Giveaway)
        case toggleFavorite(Int)
        case loadFavorites
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .fetchGiveaways:
                state.isLoading = true
                return .run { send in
                    do {
                        let giveaways = try await apiClient.fetchGiveaways()
                        await send(.giveawaysResponse(.success(giveaways)))
                    } catch {
                        await send(.giveawaysResponse(.failure(APIError())))
                    }
                }
                
            case .fetchGiveawaysByPlatform(let platform):
                state.isLoading = true
                return .run { send in
                    do {
                        let giveaways = try await apiClient.fetchGiveawaysByPlatform(platform: platform)
                        await send(.giveawaysByPlatformResponse(.success(giveaways)))
                    } catch {
                        await send(.giveawaysByPlatformResponse(.failure(APIError())))
                    }
                }
                
                
            case .giveawaysResponse(.success(let giveaways)):
                state.giveawaysList = giveaways
                state.filteredGiveaways = giveaways
                state.isLoading = false
                return .none
                
            case .giveawaysResponse(.failure(let error)):
                state.giveawaysErrorMessage = "Error fetching giveaways: \(error.localizedDescription)"
                state.isLoading = false
                return .none
                
            case .giveawaysByPlatformResponse(.success(let giveaways)):
                state.epicGamesStore = giveaways
                state.isLoading = false
                return .none
                
            case .giveawaysByPlatformResponse(.failure(let error)):
                state.epicGamesStoreErrorMessage = "Error fetching giveaways: \(error.localizedDescription)"
                state.isLoading = false
                return .none
                
            case .filterGiveaways(let platform):
                if platform == "All" {
                    state.filteredGiveaways = state.giveawaysList
                } else {
                    state.filteredGiveaways = state.giveawaysList.filter {
                        $0.platforms?.contains(platform) ?? false
                    }
                }
                return .none
                
            case .setLoading(let isLoading):
                state.isLoading = isLoading
                return .none
                
            case .binding:
                return .none
            case .destination:
                return .none
            case .push(let item):
                state.destination = .detailsPageState(GiveawayDetailsReducer.State(giveaway: item))
                return .none
            case .toggleFavorite(let id):
                if state.favoriteGiveaways.contains(id) {
                    favoritesManager.removeFavorite(id: id)
                } else {
                    favoritesManager.saveFavorite(id: id)
                }
                return .send(.loadFavorites)
                
            case .loadFavorites:
                state.favoriteGiveaways = favoritesManager.getFavorites()
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
    }
}




