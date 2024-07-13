//
//  GiveawaysDetailsPage.swift
//  TCA-Giveaway
//
//  Created by Elkilany on 13/07/2024.
//


import SwiftUI
import ComposableArchitecture

struct GiveawaysDetailsPage: View {
    
    @State var isFav = false    
    @State var store: StoreOf<GiveawayDetailsReducer>

    var body: some View {
        VStack{
            ZStack {
                AsyncImage(url: URL(string:store.giveaway?.image ?? ""))
                    .frame( height: 200)
                
                VStack(alignment: .leading) {
                            

                        Spacer()
                        HStack{
                            Text( store.giveaway?.title ?? "")
                                .font(.title2)
                                .foregroundColor(.white)
                                .lineLimit(3)
                            Spacer()
                            FavoriteView(itemID: store.giveaway?.id ?? 0, isFav: $isFav)
                            Spacer().frame(width: 12)
                            Text("Get it")
                                .font(.headline)
                                .padding(10)
                                .foregroundColor(.black)
                                .background(.white)
                                .cornerRadius(15)
                        }
                    }
                    .padding([.top,.horizontal],40)
                    .padding(.bottom,20)
                
                .frame(height: 220)
                .background(Color.black.opacity(0.6))
            }
            
            HStack(alignment: .center, spacing: 20){
                VerticalIconWithTitle(iconName: GivawayesIconConstants.worthIconName, value: store.giveaway?.worth ?? "" )
                Spacer()
                DividerView()
                Spacer()
                VerticalIconWithTitle(iconName: GivawayesIconConstants.usersIconName, value: String(store.giveaway?.users ?? 0 ))
                Spacer()
                DividerView()
                Spacer()
                VerticalIconWithTitle(iconName: GivawayesIconConstants.typeIconName, value: store.giveaway?.type ?? "" )
            }
            .padding(.horizontal,20)
            
            VStack(alignment: .leading,spacing:15) {
                VerticalTitleWithDescription(title: "Platforms", description: store.giveaway?.platforms ?? "" )
                VerticalTitleWithDescription(title: "Giveaway End Date", description:store.giveaway?.endDate?.GivawayesFormattedDate() ?? "-" )
                VerticalTitleWithDescription(title: "Description", description: store.giveaway?.description ?? "" )
            }
            .padding(.horizontal)
            Spacer()
        }
        .padding()
        .ignoresSafeArea()
        
        .onAppear {
            isFav = FavoritesManager.shared.isFavorite(id: store.giveaway?.id ?? 0)

        }
    }
}
