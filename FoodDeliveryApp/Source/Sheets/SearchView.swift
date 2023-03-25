//
//  SearchView.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/2/23.
//

import SwiftUI

struct SearchView: View {
    @State var text = ""
    @State var show = false
    @State var selectedDish: Food = Food(title: "", weight: "", text: "", image: "", price: 0.00, category: "", options: [Addition(id: 1, title: "", values: [])], countSelected: 0)
    @Namespace var namespace
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var model: Model
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    content
                }
                .frame(maxWidth: .infinity)
            }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        withAnimation {
                            dismiss()
                        }
                    } label: {
                        Text("Done")
                    }
                }
            }
        }
        .searchable(text: $text, placement: .navigationBarDrawer(displayMode: .always), prompt: "Swift, SwiftUI, Design...") {
            ForEach(suggestions) { suggestion in
                Button {
                    text = suggestion.text
                } label: {
                    Text(suggestion.text)
                }
                .searchCompletion(suggestion.text)
            }
        }
    }
    
    var content: some View {
        VStack {
            ForEach (Array(results.enumerated()), id: \.offset) { index, dish in
                if index != 0 { Divider() }
                Button {
                    show = true
                    selectedDish = dish
                } label: {
                    HStack(alignment: .top, spacing: 12) {
                        Image(dish.image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 44, height: 44)
                            .background(Color("Background"))
                            .mask(Circle())
                        VStack(alignment: .leading, spacing: 4) {
                            Text(dish.title).bold()
                                .foregroundColor(.primary)
                            Text(dish.text)
                                .foregroundColor(.secondary)
                                .font(.footnote)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .multilineTextAlignment(.leading)
                        }
                    }
                    .padding(.vertical, 4)
                    .listRowSeparator(.hidden)
                }
                .buttonStyle(.plain)
            }
            
            if results.isEmpty {
                Text("No results found")
            }
        }
        .padding(20)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
        .strokeStyle(cornerRadius: 30)
        .padding(20)
        .background(
            Rectangle()
                .fill(.regularMaterial)
                .frame(height: 200)
                .frame(maxHeight: .infinity, alignment: .top)
                .blur(radius: 20)
                .offset(y: -200)
        )
        .background(
            Image("Blob 1").offset(x: -100, y: -200)
                .accessibilityHidden(true)
        )
        .sheet(isPresented: $show) {
            DetailView(namespace: namespace, food: selectedDish)
        }
    }
    
    var results: [Food] {
        if text.isEmpty {
            return model.fullMenu
        } else {
            return model.fullMenu.filter { $0.title.contains(text) }
        }
    }
    
    var suggestions: [Suggestion] {
        if text.isEmpty {
            return suggestionsData
        } else {
            return suggestionsData.filter { $0.text.contains(text) }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(selectedDish: Food(title: "MIAMI", weight: "Вага 340 г", text: "Перетерті томати, моцарела, базилік. Алергени: злаки, лактоза.", image: "MIAMI", price: 430.00, category: "Burger", options: [Addition(id: 1, title: "Гострий", values: [AdditionItem(title: "Так"), AdditionItem(title: "Ні")])], countSelected: 0))
            .environmentObject(Model())
    }
}
