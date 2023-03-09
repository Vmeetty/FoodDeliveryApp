//
//  DetailView.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/2/23.
//

import SwiftUI

struct DetailView: View {
    var namespace: Namespace.ID
    @Binding var food: Food
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
        }
        .zIndex(1)
        .onAppear {
            viewModel.totalPrice = food.price
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
                Image(food.image)
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
            ForEach(Array(food.options.enumerated()), id: \.offset) { index, addition in
                if index != 0 { Divider() }
                AdditionRow(addition: $food.options[index])
                    .environmentObject(viewModel)
            }
        }
        .background(.ultraThinMaterial)
        .backgroundStyle(cornerRadius: 30)
        .padding(.horizontal, 20)
        .onReceive(viewModel.$foodModelChanged) { newValue in
            if newValue { viewModel.calculateWith(foodItem: food) }
        }
    }
    
    var container: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(food.title)
                .font(.title).bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.primary)
                .matchedGeometryEffect(id: "title\(food.id)", in: namespace)
            Text(food.weight.uppercased())
                .font(.footnote).bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.secondary.opacity(0.7))
                .opacity(viewModel.appear[0] ? 1 : 0)
            Text(food.text)
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
                Text(food.price)
                    .font(.title2)
                    .foregroundColor(.primary.opacity(0.7))
                    .matchedGeometryEffect(id: "price\(food.id)", in: namespace)
                Spacer()
                Text(viewModel.totalPrice)
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
        DetailView(namespace: namespace, food: .constant(Food(title: "MIAMI", weight: "Вага 340 г", text: "Перетерті томати, моцарела, базилік. Алергени: злаки, лактоза.", image: "MIAMI", price: "430", category: "Burger", options: [Addition(title: "Гострий", values: [AdditionItem(title: "Так"), AdditionItem(title: "Ні")])])))
            .environmentObject(Model())
    }
}
