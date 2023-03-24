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
    @State var selectedFeaturedCourse = featuredCourses[0]
    
    var body: some View {
        ZStack {
            
            Color("Background")
                .ignoresSafeArea()
            
            if model.showDetail {
                DetailView(namespace: namespace, food: viewModel.selectedDish)
                    .zIndex(1)
            }
            
            ScrollView {
                scrollDetaction
//                promo
                featured
                categoriesSection
                
                if model.showDetail {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(courses) { course in
                            Rectangle()
                                .fill(.white)
                                .frame(height: 300)
                                .cornerRadius(30)
                                .shadow(color: Color("Shadow").opacity(0.2), radius: 20, x: 0, y: 10)
                                .opacity(0.3)
                        }
                    }
                    .padding(.horizontal, 20)
                    .offset(y: -80)
                } else {
                    LazyVGrid(columns: columns, spacing: 20) {
                        listOfItems.frame(height: 300)
                    }
                    .padding(.horizontal, 20)
//                    .offset(y: -80)
                }
            }
            .coordinateSpace(name: "Scroll")
            
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
    
    var scrollDetaction: some View {
        GeometryReader { proxy in
            let offset = proxy.frame(in: .named("Scroll")).minY
            Color.clear.preference(key: ScrollPreferenceKey.self, value: offset)
        }
        .onPreferenceChange(ScrollPreferenceKey.self ,perform: { value in
            withAnimation(.easeInOut(duration: 0.2)) {
                viewModel.hasScrolled = value < 0 ? true : false
            }
        })
    }
    
    
    var categoriesSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(Array(model.categories.enumerated()), id: \.offset) { index, category in
                    CategoryItem(category: category, selectedId: $model.categories[viewModel.selectedCategoryIndex].id)
                        .onTapGesture {
                            withAnimation {
                                if viewModel.selectedCategoryIndex != index {
                                    viewModel.selectedCategoryIndex = index
                                    viewModel.changeMenuBy(category)
                                }
                            }
                        }
                }
            }
            .padding(.horizontal, 20)
            Spacer()
        }
    }
    
    var featured: some View {
        TabView {
            ForEach(featuredCourses) { course in
                GeometryReader { proxy in
                    let minX = proxy.frame(in: .global).minX
                    FeaturedItem(course: course)
                        .padding(.vertical, 20)
                        .rotation3DEffect(.degrees(minX / -10), axis: (x: 0, y: 1, z: 0))
                        .shadow(color: Color.ShadowColor.opacity(0.2), radius: 5, x: 0, y: 5)
                        .blur(radius: abs(minX) / 40)
                        .overlay {
                            Image(course.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 240)
                                .offset(x: 90, y: 20)
                                .offset(x: minX / 2)
                        }
//                        .onTapGesture {
//                            selectedFeaturedCourse = course
//                            viewModel.showFeaturedCourse = true
//                        }
                }
            }
        }
        .tabViewStyle(.page)
        .frame(height: 270)
        .background(
            Image("Blob 1")
                .offset(x: -300, y: -110)
        )
        .sheet(isPresented: $viewModel.showFeaturedCourse) {
//                        CourseDetaileView(namespace: namespace, course: $selectedFeaturedCourse, show: $viewModel.showFeaturedCourse)
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
