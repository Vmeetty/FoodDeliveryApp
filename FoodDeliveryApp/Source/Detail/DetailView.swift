//
//  DetailView.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/2/23.
//

import SwiftUI

struct DetailView: View {
    var namespace: Namespace.ID
    @State var food: Food
    @EnvironmentObject var model: Model
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = DetailViewModel()
    
    var body: some View {
        ZStack {
            ScrollView {
                cover
                Group {
                    container
                    additionsSection
                        .opacity(viewModel.appear[2] ? 1 : 0)
                }
                .offset(y: -30)
            }
            .padding(.bottom, 90)
            .coordinateSpace(name: "scroll")
            .background(Color("Background").opacity(viewModel.appear[3] ? 1 : 0))
            .mask(RoundedRectangle(cornerRadius: viewModel.appear[0] ? 0 : 30))
            .mask(RoundedRectangle(cornerRadius: viewModel.viewState.width / 3))
            .modifier(OutlineModifier(cornerRadius: viewModel.viewState.width / 3))
            .shadow(color: Color("Shadow").opacity(0.5), radius: 30, x: 0, y: 10)
            .scaleEffect(-viewModel.viewState.width/500 + 1)
            .background(Color("Shadow").opacity(viewModel.viewState.width / 500))
            .background(.ultraThinMaterial)
            .gesture(viewModel.isDragble ? drag : nil)
            .ignoresSafeArea()
            
            closeButton
                .opacity(viewModel.appear[0] ? 1 : 0)
            
            addContainer
                .opacity(viewModel.appear[2] ? 1 : 0)
        }
        .zIndex(1)
        .onAppear {
            viewModel.createLocalItem(food: food)
            fadeIn()
        }
    }
    
    var cover: some View {
        GeometryReader { proxy in
            let scrollY = proxy.frame(in: .named("scroll")).minY
            
            VStack {
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .frame(height: scrollY > 0 ? 500 + scrollY : 500)
            .background(
                Image(viewModel.localDishItem.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .matchedGeometryEffect(id: "image\(food.id)", in: namespace)
                    .offset(y: scrollY > 0 ? -scrollY : 0)
                    .accessibility(hidden: true)
            )
            .mask {
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .matchedGeometryEffect(id: "mask\(food.id)", in: namespace)
                    .offset(y: scrollY > 0 ? -scrollY : 0)
            }
        }
        .frame(height: 400)
    }
    
    var closeButton: some View {
        Button {
            viewModel.isDragble ?
            withAnimation(.closeCard) {
                model.showDetail = false
            }
            : dismiss()
            fadeOut()
        } label: {
            CloseButton()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        .padding(20)
        .ignoresSafeArea()
    }
    
    var additionsSection: some View {
        VStack(alignment: .leading) {
            ForEach(Array(viewModel.localDishItem.options.enumerated()), id: \.offset) { index, addition in
                if index != 0 { Divider() }
                AdditionRow(addition: $viewModel.localDishItem.options[index])
                    .environmentObject(viewModel)
            }
        }
        .background(.ultraThinMaterial)
        .backgroundStyle(cornerRadius: 30)
        .padding(.horizontal, 20)
        .onReceive(viewModel.$foodModelChanged) { newValue in
            if newValue { viewModel.calculateWith() }
        }
    }
    
    var container: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(viewModel.localDishItem.title)
                .font(.title).bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.primary)
                .matchedGeometryEffect(id: "title\(food.id)", in: namespace)
            Text(viewModel.localDishItem.weight.uppercased())
                .font(.footnote).bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.secondary.opacity(0.7))
                .opacity(viewModel.appear[0] ? 1 : 0)
            Text(viewModel.localDishItem.text)
                .font(.footnote)
                .opacity(viewModel.appear[0] ? 1 : 0)
            Divider()
                .foregroundColor(.secondary)
                .opacity(viewModel.appear[1] ? 1 : 0)
            HStack {
                Image(systemName: "hryvniasign")
                    .padding(8)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                    .strokeStyle(cornerRadius: 12)
                    .matchedGeometryEffect(id: "currency\(food.id)", in: namespace)
                Text(String(format: "%.2f", viewModel.localDishItem.price))
                    .font(.title2)
                    .foregroundColor(.primary.opacity(0.7))
                    .matchedGeometryEffect(id: "price\(food.id)", in: namespace)
            }
        }
        .padding(20)
        .background(
            Rectangle()
                .fill(.ultraThinMaterial)
                .backgroundStyle(cornerRadius: 30)
                .matchedGeometryEffect(id: "blur\(food.id)", in: namespace)
        )
        .frame(maxHeight: .infinity, alignment: .bottom)
        .padding(20)
    }
    
    var addContainer: some View {
        HStack(spacing: 15) {
            HStack(spacing: 15) {
                Button {
                    if viewModel.count > 1 {
                        viewModel.count -= 1
                        viewModel.calculateWith()
                    }
                } label: {
                    Image(systemName: "minus")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(.secondary)
                        .padding(8)
                        .frame(width: 30, height: 30)
                        .background(.ultraThinMaterial, in: Circle())
                        .backgroundStyle(cornerRadius: 18)
                }
                Text("\(viewModel.count)")
                    .lineLimit(1)
                Button {
                    viewModel.count += 1
                    viewModel.calculateWith()
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(.secondary)
                        .padding(8)
                        .frame(width: 30, height: 30)
                        .background(.ultraThinMaterial, in: Circle())
                        .backgroundStyle(cornerRadius: 18)
                }
            }
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .opacity(0.05)
            )
            .frame(height: 50)
            
            Button {
//                food.countSelected = String(viewModel.count)
                viewModel.addItemToCart(item: food)
                close()
            } label: {
                HStack {
                    Text("\(String(format: "%.2f", viewModel.totalPrice)) грн")
                        .fontWeight(.light)
                    Spacer()
                    Text("Додати")
                }
            }
            .font(.headline)
            .tint(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(.linearGradient(colors: [.purple, .red], startPoint: .topLeading, endPoint: .bottomTrailing))
            )
        }
        .padding()
        .frame(height: 92, alignment: .top)
        .background(
            RoundedRectangle(cornerRadius: 34)
                .fill(.ultraThinMaterial)
                .strokeStyle(cornerRadius: 34)
                .shadow(color: Color("Shadow").opacity(0.2), radius: 5, x: 0, y: 0)
        )
        .frame(maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        .onChange(of: viewModel.orderItem) { newOrderItem in
            if model.orderItems.isEmpty {
                model.orderItems.append(newOrderItem)
            } else {
                var matchedIndex: Int?
                for (index, item) in model.orderItems.enumerated() {
                    if item.id == newOrderItem.id {
                        if item.options == newOrderItem.options {
                            matchedIndex = index
                        }
                    }
                }
                if let matchedIndex = matchedIndex {
                    model.orderItems[matchedIndex].price += newOrderItem.price
                    model.orderItems[matchedIndex].countSelected += newOrderItem.countSelected
                } else {
                    model.orderItems.append(newOrderItem)
                }
            }
            print(model.orderItems.map({ $0.title }))
        }
    }
    
    var drag: some Gesture {
        DragGesture(minimumDistance: 30, coordinateSpace: .local)
            .onChanged({ newValue in
                guard newValue.translation.width > 0 else { return }
                
                if newValue.startLocation.x < 100 {
                    withAnimation {
                        viewModel.viewState = newValue.translation
                    }
                }
                
                if viewModel.viewState.width > 120 {
                    close()
                }
            })
            .onEnded({ newValue in
                if viewModel.viewState.width > 80 {
                    close()
                } else {
                    withAnimation(.closeCard) {
                        viewModel.viewState = .zero
                    }
                }
            })
    }
    
    private func close() {
        withAnimation(.closeCard.delay(0.1)) {
            model.showDetail = false
        }
        withAnimation(.closeCard) {
            viewModel.viewState = .zero
        }
        
        viewModel.isDragble = false
    }
    
    private func fadeIn() {
        withAnimation(.easeOut.delay(0.3)) {
            viewModel.appear[0] = true
        }
        withAnimation(.easeOut.delay(0.4)) {
            viewModel.appear[1] = true
        }
        withAnimation(.easeOut.delay(0.5)) {
            viewModel.appear[2] = true
        }
        withAnimation(.easeOut) {
            viewModel.appear[3] = true
        }
    }
    
    private func fadeOut() {
        viewModel.appear[0] = false
        viewModel.appear[1] = false
        viewModel.appear[2] = false
        viewModel.appear[3] = false
    }
}

struct CourseDetaoleView_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        DetailView(namespace: namespace, food: Food(title: "MIAMI", weight: "Вага 340 г", text: "Перетерті томати, моцарела, базилік. Алергени: злаки, лактоза.", image: "MIAMI", price: 430.00, category: "Burger", options: [Addition(id: 3, title: "Гострий", values: [AdditionItem(title: "Так"), AdditionItem(title: "Ні")]), Addition(id: 4, title: "Бекон", values: [AdditionItem(title: "3гр", price: "10"), AdditionItem(title: "7гр", price: "15")])], countSelected: 0))
    }
}
