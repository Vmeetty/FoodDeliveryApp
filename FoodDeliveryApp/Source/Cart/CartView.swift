//
//  CartView.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/2/23.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var model: Model
    @StateObject var viewModel = CartViewModel()
    
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            
            Group {
//                if model.orderItems.isEmpty {
//                    Text("В корзині нічого немає")
//                        .font(.title2)
//                        .frame(maxHeight: .infinity, alignment: .center)
//                        .offset(y: -200)
//                } else {
//                    ScrollView {
//                        infoSection
//                        itemsSection
//                    }
//                }
                ScrollView {
                    infoSection
                    itemsSection
                    contactsSection
                }
            }
            .safeAreaInset(edge: .top) {
                Color.clear.frame(height: 70)
            }
            .overlay {
                NavigationBar(hasScrolled: .constant(true), title: "Корзина")
            }
            .background(
                Image("Blob 1")
                    .offset(x: -180, y: 300)
            )
            .onTapGesture {
                hideKeyboard()
            }
        }
        .onAppear {
            viewModel.createContacts()
        }
    }
    
    var infoSection: some View {
        VStack {
            ForEach(Array(locationTimePayment.enumerated()), id: \.offset) { index, topic in
                VStack {
                    if index != 0 { Divider() }
                    OrderInfoItem(topic: topic)
                        .padding(.vertical, 10)
                }
            }
        }
        .padding(20)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
        .strokeStyle(cornerRadius: 30)
        .padding(.horizontal, 20)
    }
    
    var itemsSection: some View {
        VStack(alignment: .leading) {
            ForEach(Array(model.orderItems.enumerated()), id: \.offset) { index, orderItem in
                
                if index != 0 { Divider() }
                
                OrderItemRow(orderItem: $model.orderItems[index], count: model.orderItems[index].countSelected, deleteAction: {
                        model.orderItems.remove(at: index)
                    })
                .environmentObject(viewModel)
            }
        }
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
        .strokeStyle(cornerRadius: 30)
        .padding(20)
    }
    
    var contactsSection: some View {
        VStack {
            ForEach(Array(viewModel.contacts.enumerated()), id: \.offset) { index, contact in
                VStack {
                    
                    if index != 0 { Divider() }
                    
                    OrderContactsItem(title: contact.title, answer: $viewModel.contacts[index].answer)
                        .padding(.vertical, 10)
                }
            }
            .onChange(of: viewModel.contacts) { newValue in
                print(viewModel.contacts)
            }
        }
        .padding(20)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
        .strokeStyle(cornerRadius: 30)
        .padding(.horizontal, 20)
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(Model())
    }
}
