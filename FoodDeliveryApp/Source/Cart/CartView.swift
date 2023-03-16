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
                if model.orderItems.isEmpty {
                    Text("В корзині нічого немає")
                        .font(.title2)
                        .frame(maxHeight: .infinity, alignment: .center)
                        .offset(y: -200)
                } else {
                    ScrollView {
                        infoSection
                        itemsSection
                        contactsSection
                        calculationsSection
                        makeOrderButton
                    }
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
            viewModel.modelReference = model
            viewModel.rateValue = model.rateValue
            viewModel.calculate(orderItems: model.orderItems)
        }
    }
    
    var infoSection: some View {
        VStack {
            ForEach(Array(locationTimePayment.enumerated()), id: \.offset) { index, topic in
                VStack {
                    if index != 0 { Divider() }
                    OrderInfoItem(infoItem: topic)
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
                    viewModel.modelIsChanged.toggle()
                })
                .environmentObject(viewModel)
            }
        }
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
        .strokeStyle(cornerRadius: 30)
        .padding(20)
        .onChange(of: viewModel.modelIsChanged) { newValue in
            viewModel.calculate(orderItems: model.orderItems)
        }
    }
    
    var contactsSection: some View {
        VStack {
            ForEach(Array(model.contacts.enumerated()), id: \.offset) { index, contact in
                VStack {
                    if index != 0 { Divider() }
                    OrderContactsItem(title: contact.title, answer: $model.contacts[index].answer)
                        .padding(.vertical, 10)
                }
            }
        }
        .padding(20)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
        .strokeStyle(cornerRadius: 30)
        .padding(.horizontal, 20)
    }
    
    var calculationsSection: some View {
        VStack {
            ForEach(Array(model.calculations.enumerated()), id: \.offset) { index, _ in
                VStack {
                    if index != 0 { Divider() }
                    OrderCalculationView(calculations: $model.calculations, calculation: $model.calculations[index], rate: $viewModel.rateValue)
                        .padding(.vertical, 10)
                }
            }
        }
        .padding(20)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
        .strokeStyle(cornerRadius: 30)
        .padding(.horizontal, 20)
        .onChange(of: viewModel.rateValue) { newValue in
            model.rateValue = newValue
            viewModel.calculate(orderItems: model.orderItems)
        }
        .onChange(of: viewModel.calculations) { calculations in
            model.calculations = calculations
        }
    }
    
    var makeOrderButton: some View {
        Button {
            
        } label: {
            Text("Замовити")
                .fontWeight(.light)
        }
        .font(.headline)
        .tint(.white)
        .padding()
        .frame(maxWidth: .infinity)
        .frame(height: 50)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.linearGradient(colors: [.purple, .red], startPoint: .topLeading, endPoint: .bottomTrailing))
        )
        .padding(20)
//        .padding(.bottom, 10)
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(Model())
    }
}
