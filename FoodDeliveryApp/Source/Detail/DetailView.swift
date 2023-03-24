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
    var isAnimated = true
    
    @State var viewState: CGSize = .zero
    @State var showSection = false
    @State var appear = [false, false, false]
    @State var selectedSection = courseSections[0]
    
    @EnvironmentObject var model: Model
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = DetailViewModel()
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        ZStack {
            ScrollView {
                cover
                additionsSection
                    .padding(.bottom, 220)
                    .opacity(appear[2] ? 1 : 0)
            }
            .coordinateSpace(name: "scroll")
            .background(Color("Background"))
            .mask(RoundedRectangle(cornerRadius: appear[0] ? 0 : 30))
            .mask(RoundedRectangle(cornerRadius: viewState.width / 3))
            .modifier(OutlineModifier(cornerRadius: viewState.width / 3))
            .shadow(color: Color("Shadow").opacity(0.5), radius: 30, x: 0, y: 10)
            .scaleEffect(-viewState.width/500 + 1)
            .background(Color("Shadow").opacity(viewState.width / 500))
            .background(.ultraThinMaterial)
            .gesture(isAnimated ? drag : nil)
            .ignoresSafeArea()
            
            closeButton
                .opacity(appear[0] ? 1 : 0)
            
            addContainer
                .opacity(appear[2] ? 1 : 0)
        }
        .zIndex(1)
        .onAppear {
            viewModel.modelReference = model
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
                Image(food.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .matchedGeometryEffect(id: "background\(food.id)", in: namespace)
                    .offset(y: scrollY > 0 ? -scrollY : 0)
                    .scaleEffect(scrollY > 0 ? scrollY / 1000 + 1 : 1)
                    .accessibility(hidden: true)
            )
            .mask(
                RoundedRectangle(cornerRadius: appear[0] ? 0 : 30)
                    .matchedGeometryEffect(id: "mask\(food.id)", in: namespace)
                    .offset(y: scrollY > 0 ? -scrollY : 0)
            )
            .overlay(
                Image(horizontalSizeClass == .compact ? "Waves 1" : "Waves 2")
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .offset(y: scrollY > 0 ? -scrollY : 0)
                    .scaleEffect(scrollY > 0 ? scrollY / 500 + 1 : 1)
                    .opacity(1)
                    .opacity(appear[1] ? 1 : 0)
                    .accessibility(hidden: true)
            )
            .overlay(
                VStack(alignment: .leading, spacing: 16) {
                    Text(food.title)
                        .font(.title3).bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.primary)
                        .matchedGeometryEffect(id: "title\(food.id)", in: namespace)
                    
                    Text(food.text)
                        .font(.footnote)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.primary.opacity(0.7))
                        .opacity(appear[1] ? 1 : 0)
                    
                    HStack {
                        IconView(image: "hryvniasign.circle")
                            .matchedGeometryEffect(id: "currency\(food.id)", in: namespace)
                        Text(String(format: "%.2f", food.price))
                            .font(.body)
                            .foregroundColor(.primary)
                            .matchedGeometryEffect(id: "price\(food.id)", in: namespace)
                    }
                    .opacity(appear[1] ? 1 : 0)
                    .accessibilityElement(children: .combine)
                }
                .padding(20)
                .padding(.vertical, 10)
                .background(
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                        .cornerRadius(30)
                        .blur(radius: 30)
                        .matchedGeometryEffect(id: "blur\(food.id)", in: namespace)
                )
                .background(
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .backgroundStyle(cornerRadius: 30)
                        .opacity(appear[0] ? 1 : 0)
                )
                .offset(y: scrollY > 0 ? -scrollY : 0)
                .frame(maxHeight: .infinity, alignment: .bottom)
                .offset(y: 100)
                .padding(20)
            )
        }
        .frame(height: 500)
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
        .offset(y: 90)
        .onReceive(viewModel.$foodModelChanged) { newValue in
            if newValue { viewModel.calculateWith() }
        }
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
                viewModel.startAddingItemToCart(item: food)
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
    }
    
    var closeButton: some View {
        Button {
            isAnimated ?
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
    
    func close() {
        withAnimation {
            viewState = .zero
        }
        withAnimation(.closeCard.delay(0.2)) {
            model.showDetail = false
//            model.selectedCourse = 0
        }
    }
    
    var drag: some Gesture {
        DragGesture(minimumDistance: 30, coordinateSpace: .local)
            .onChanged { value in
                guard value.translation.width > 0 else { return }
                
                if value.startLocation.x < 100 {
                    withAnimation {
                        viewState = value.translation
                    }
                }
                
                if viewState.width > 120 {
                    close()
                }
            }
            .onEnded { value in
                if viewState.width > 80 {
                    close()
                } else {
                    withAnimation(.openCard) {
                        viewState = .zero
                    }
                }
            }
    }
    
    func fadeIn() {
        withAnimation(.easeOut.delay(0.3)) {
            appear[0] = true
        }
        withAnimation(.easeOut.delay(0.4)) {
            appear[1] = true
        }
        withAnimation(.easeOut.delay(0.5)) {
            appear[2] = true
        }
    }
    
    func fadeOut() {
        appear[0] = false
        appear[1] = false
        appear[2] = false
//        withAnimation(.easeIn(duration: 0.1)) {
//        }
    }
}

struct CourseDetaileView_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        DetailView(namespace: namespace, food: Food(title: "MIAMI", weight: "Вага 340 г", text: "Перетерті томати, моцарела, базилік. Алергени: злаки, лактоза.", image: "burg_1", price: 430.00, category: "Burger", options: [Addition(id: 3, title: "Гострий", values: [AdditionItem(title: "Так"), AdditionItem(title: "Ні")]), Addition(id: 4, title: "Бекон", values: [AdditionItem(title: "3гр", price: "10"), AdditionItem(title: "7гр", price: "15")])], countSelected: 0))
            .environmentObject(Model())
    }
}
