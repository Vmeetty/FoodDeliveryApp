//
//  AccountView.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/2/23.
//

import SwiftUI

struct AccountView: View {
    
    @State var webIsDeleted = false
    @State var youtubeIsDeleted = false
    @Environment(\.dismiss) var dismiss
    @AppStorage("isLogged") var isLogged = true
    @State var addressModel = AddressModel(id: 1, country: "UA")
    @ObservedObject var coinViewModel = CoinViewModel()
    
    func fetchAddres() async {
        do {
            if let url = URL(string: "https://random-data-api.com/api/address/random_address") {
                let (data, _) = try await URLSession.shared.data(from: url)
                addressModel = try JSONDecoder().decode(AddressModel.self, from: data)
            }
        } catch {
            // Show errors
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                profile
                menu
                links
                coins
                Button {
                    isLogged = false
                    dismiss()
                } label: {
                    Text("Sign out")
                }
                .tint(.red)
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Account")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Done")
                    }
                }
            }
            .task {
                await fetchAddres()
                await coinViewModel.fetchCoins()
            }
            .refreshable {
                await fetchAddres()
                await coinViewModel.fetchCoins()
            }
        }
    }
    
    var profile: some View {
        VStack {
            Image(systemName: "person.crop.circle.fill.badge.checkmark")
                .symbolVariant(.circle.fill)
                .font(.system(size: 32))
                .symbolRenderingMode(.palette)
                .foregroundStyle(.blue, .blue.opacity(0.3))
                .padding()
                .background(Circle().fill(.ultraThinMaterial))
                .background(
                    BlobView()
                        .offset(x: 300, y: 0)
                        .scaleEffect(0.5)
                )
            Text("Vlad Chuvashov")
                .font(.title.weight(.semibold))
            HStack {
                Image(systemName: "location")
                    .imageScale(.small)
                    .foregroundColor(.secondary)
                Text(addressModel.country)
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    var menu: some View {
        Section {
            NavigationLink {
                HomeView()
            } label: {
                Label("Settings", systemImage: "gear")
            }
            NavigationLink {
                HomeView()
            } label: {
                Label("Billing", systemImage: "creditcard")
            }
            NavigationLink {
                ContentView()
            } label: {
                Label("Help", systemImage: "questionmark")
            }
        }
        .listRowSeparator(.hidden)
        .listItemTint(.primary)
    }
    
    var links: some View {
        Section {
            if !webIsDeleted {
                Link(destination: URL(string: "http://apple.com")!) {
                    HStack {
                        Label("Website", systemImage: "house")
                        Spacer()
                        Image(systemName: "link")
                            .foregroundColor(.secondary)
                    }
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                    Button {
                        webIsDeleted = true
                    } label: {
                        Image(systemName: "trash")
                            .foregroundColor(.white)
                    }
                    .tint(.red)
                }
            }
            if !youtubeIsDeleted {
                Link(destination: URL(string: "http://youtube.com")!) {
                    HStack {
                        Label("YouTube", systemImage: "tv")
                        Spacer()
                        Image(systemName: "link")
                            .foregroundColor(.secondary)
                    }
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                    Button {
                        youtubeIsDeleted = true
                    } label: {
                        Image(systemName: "trash")
                            .foregroundColor(.white)
                    }
                    .tint(.red)
                }
            }
        }
        .listRowSeparator(.hidden)
        .foregroundColor(.primary)
    }
    
    var coins: some View {
        Section {
            ForEach(coinViewModel.coins) { coin in
                HStack {
                    AsyncImage(url: URL(string: coin.logo)) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        case .empty:
                            ProgressView()
                        case .failure(_):
                            Color.gray
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .frame(width: 32, height: 32)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(coin.coin_name)
                        Text(coin.acronym)
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
