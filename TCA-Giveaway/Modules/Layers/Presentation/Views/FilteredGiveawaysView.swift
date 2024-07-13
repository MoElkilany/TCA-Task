//
//  FilteredGiveawaysView.swift
//  Givawayes
//
//  Created by Elkilany on 13/07/2024.
//

import SwiftUI
import ComposableArchitecture

struct FilteredGiveawaysView: View {
    let giveaways: [Giveaway]
    @State var store: StoreOf<GiveawayReducer>
    
    var body: some View {
        if !giveaways.isEmpty {
            ForEach(giveaways) { item in
                Button {
                    store.send(.push(item))
                } label: {
                    GiveawayList(giveaway: item)
                        .padding(.bottom, 12)
                }
            }
            
        } else {
            Text("No Giveaways Available, the result will appear here!!")
                .padding()
                .multilineTextAlignment(.center)
        }

        
    }
}
