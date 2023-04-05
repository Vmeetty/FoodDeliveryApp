//
//  HomeView.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/2/23.
//

import SwiftUI

struct HomeView: View {
    var columns = [GridItem(.adaptive(minimum: 300), spacing: 20)]
    
    @Namespace var namespace
    @EnvironmentObject var model: Model
    @Environment(\.colorScheme) var colorScheme
    @StateObject var viewModel = HomeViewModel()
    @State var selectedPromo = homePromotions[0]
    
    var body: some View {
        ZStack {
            
            Color("Background")
                .ignoresSafeArea()
            
            if model.showDetail {
                DetailView(namespace: namespace, food: viewModel.selectedDish)
            }
            
            ScrollView {
                scrollDetection
//                promo
                featured
                categoriesSection
                
                if model.showDetail {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(viewModel.selectedMenu) { dish in
                            Rectangle()
                                .fill(.white)
                                .frame(height: 300)
                                .cornerRadius(30)
                                .shadow(color: Color("Shadow").opacity(0.2), radius: 20, x: 0, y: 10)
                                .opacity(0.3)
                        }
                    }
                    .padding(.horizontal, 20)
                } else {
                    LazyVGrid(columns: columns, spacing: 20) {
                        listOfItems.frame(height: 300)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical)
                }
            }
            .coordinateSpace(name: "scroll")
            
            .safeAreaInset(edge: .top, content: {
                Color.clear.frame(height: 70)
            })
        }
        .onChange(of: model.showDetail) { newValue in
            withAnimation {
                if newValue {
                    viewModel.showStatusBar = false
                } else {
                    viewModel.showStatusBar = true
                }
                model.showNav.toggle()
            }
        }
        .overlay {
            NavigationBar(hasScrolled: $viewModel.hasScrolled, title: "Меню")
        }
        .statusBarHidden(!viewModel.showStatusBar)
        .onAppear {
            viewModel.menu = model.fullMenu
            viewModel.changeMenuBy(model.categories[viewModel.selectedCategoryIndex])
        }
    }
    
    var listOfItems: some View {
        ForEach(viewModel.selectedMenu) { dish in
            MenuItem(namespace: namespace, dish: dish)
                .accessibilityElement(children: .combine)
                .accessibilityAddTraits(.isButton)
                .onTapGesture {
                    withAnimation(.openCard) {
                        viewModel.selectedDish = dish
                        model.showDetail = true
                    }
                }
        }
    }
    
    var scrollDetection: some View {
        GeometryReader { proxy in
            let offset = proxy.frame(in: .named("scroll")).minY
            Color.clear.preference(key: ScrollPreferenceKey.self, value: offset)
        }
        .onPreferenceChange(ScrollPreferenceKey.self) { value in
            withAnimation(.easeInOut) {
                if value < 0 {
                    viewModel.hasScrolled = true
                } else {
                    viewModel.hasScrolled = false
                }
            }
        }
    }
    
    
    var categoriesSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(Array(model.categories.enumerated()), id: \.offset) { index, category in
                    CategoryItem(category: category, selectedId: $model.categories[viewModel.selectedCategoryIndex].id)
                        .onTapGesture {
                            if viewModel.selectedCategoryIndex != index {
                                withAnimation {
                                    viewModel.selectedCategoryIndex = index
                                }
                                viewModel.changeMenuBy(category)
                            }
                        }
                }
            }
            .padding(20)
            Spacer()
        }
    }
    
    var featured: some View {
        TabView {
            ForEach(homePromotions) { promo in
                GeometryReader { proxy in
                    let minX = proxy.frame(in: .global).minX
                    FeaturedItem(course: promo)
                        .padding(.vertical, 20)
                        .rotation3DEffect(.degrees(minX / -10), axis: (x: 0, y: 1, z: 0))
                        .shadow(color: Color.ShadowColor.opacity(0.2), radius: 5, x: 0, y: 5)
                        .blur(radius: abs(minX) / 40)
                        .overlay {
                            Image(promo.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 200)
                                .offset(x: 100, y: 30)
                                .offset(x: minX / 2)
                        }
                        .onTapGesture {
                            selectedPromo = promo
                            viewModel.showPromotion = true
                        }
                }
            }
        }
        .tabViewStyle(.page)
        .frame(height: 270)
        .background(
            Image("Blob 1")
                .offset(x: -300, y: -110)
        )
        .sheet(isPresented: $viewModel.showPromotion) {
            SectionView(promo: $selectedPromo)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(Model())
    }
}

// MARK: banner style fore promotions

//    var promo: some View {
//        TabView {
//            ForEach(featuredCourses) { course in
//                GeometryReader { proxy in
//                    let minX = proxy.frame(in: .global).minX
//                    PromotionItem(course: course)
//                        .rotation3DEffect(.degrees(minX / -10), axis: (x: 0, y: 1, z: 0))
//                        .shadow(color: Color.ShadowColor.opacity(0.2), radius: 4, x: 0, y: 5)
//                        .blur(radius: abs(minX) / 40)
//                        .onTapGesture {
//                            selectedFeaturedCourse = course
//                            viewModel.showFeaturedCourse = true
//                        }
//                }
//            }
//        }
//        .tabViewStyle(.page)
//        .frame(height: 260)
//        .padding(.vertical)
//        .sheet(isPresented: $viewModel.showFeaturedCourse) {
////            CourseDetaileView(namespace: namespace, course: $selectedFeaturedCourse, show: $viewModel.showFeaturedCourse)
//        }
//    }
