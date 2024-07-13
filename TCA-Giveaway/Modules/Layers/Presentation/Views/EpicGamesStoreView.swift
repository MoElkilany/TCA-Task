//
//  EpicGamesStoreView.swift
//  Givawayes
//
//  Created by Elkilany on 13/07/2024.
//

import SwiftUI

struct EpicGamesStoreView: View {
    let giveaways: [Giveaway]

    var body: some View {
        if !giveaways.isEmpty {
            CarouselView(items: giveaways) { giveaway in
                CarouselRow(giveaway: giveaway)
            }
        } else {
            Text("No Giveaways Available, the result will appear here!")
                .padding()
                .multilineTextAlignment(.center)
        }
    }
}
