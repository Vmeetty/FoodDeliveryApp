//
//  ContentView.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/2/23.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("selectedTab") var selectedTab: Tab = .home
    @AppStorage("showModal") var showModal = false
    @EnvironmentObject var model: Model
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            switch selectedTab {
            case .home:
                HomeView()
            case .explore:
                PromotionsView()
            case .notifications:
                CartView()
            case .library:
                LibraryView()
            }
            
            TabBar()
                .offset(y: model.showDetail || model.showMap ? 250 : 0)
            
            if showModal {
                ModalView()
                    .zIndex(1)
            }
        }
        .safeAreaInset(edge: .bottom) {
            Color.clear.frame(height: 88)
        }
        .onAppear {
            showModal = false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Model())
    }
}
