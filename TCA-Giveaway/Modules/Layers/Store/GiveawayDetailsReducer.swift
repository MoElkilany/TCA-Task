//
//  GiveawayDetailsReducer.swift
//  TCA-Giveaway
//
//  Created by Elkilany on 13/07/2024.
//

import Foundation
import ComposableArchitecture

@Reducer
struct GiveawayDetailsReducer : Reducer {
    
    @ObservableState
    struct State: Equatable {
        var giveaway: Giveaway?
    }
    
    enum Action {}
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            return .none
        }
    }
}
