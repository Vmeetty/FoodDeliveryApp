//
//  HomeView.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/2/23.
//

import SwiftUI

struct HomeView: View {
    @Namespace var namespace
    @State var selectedCourse = courses[0]
    @State var selectedFeaturedCourse = featuredCourses[0]
    @State var selectedCategoryId = categories[0].id
    @EnvironmentObject var model: Model
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        ZStack {
            
            Color("Background")
                .ignoresSafeArea()
            
            ScrollView {
                
                scrollDetaction
                featured
                categoriesSection
                
                Text("courses".uppercased())
                    .titleStyle()
                
                if !viewModel.show {
                    ForEach(courses) { course in
                        CourseItem(namespace: namespace, course: course, show: $viewModel.show)
                            .onTapGesture {
                                withAnimation(.openCard) {
                                    viewModel.show.toggle()
                                    selectedCourse = course
                                    model.showDetail = true
                                }
                            }
                    }
                } else {
                    ForEach(courses) { course in
                        Rectangle()
                            .fill(.white)
                            .frame(height: 300)
                            .cornerRadius(30)
                            .shadow(color: Color("Shadow"), radius: 20, x: 0, y: 10)
                            .opacity(0.3)
                        .padding(.horizontal, 30)
                    }
                }
            }
            .coordinateSpace(name: "Scroll")
            
            .safeAreaInset(edge: .top, content: {
                Color.clear.frame(height: 70)
            })
            .overlay {
                NavigationBar(hasScrolled: $viewModel.hasScrolled, title: "Featured")
            }
            
            if viewModel.show {
                ForEach(courses) { course in
                    if selectedCourse.id == course.id {
                        CourseDetaileView(namespace: namespace, course: $selectedCourse, show: $viewModel.show)
                            .zIndex(1)
                            .transition(.asymmetric(
                                insertion: .opacity.animation(.easeInOut(duration: 0.1)),
                                removal: .opacity.animation(.easeInOut(duration: 0.3).delay(0.2))
                            ))
                    }
                }
            }
        }
        .statusBarHidden(!viewModel.showStatusBar)
        .onChange(of: viewModel.show) { newValue in
            withAnimation(.closeCard) {
                if newValue {
                    viewModel.showStatusBar = false
                } else {
                    viewModel.showStatusBar = true
                }
            }
        }
    }
    
    var scrollDetaction: some View {
        GeometryReader { proxy in
            Color.clear.preference(key: ScrollPreferenceKey.self, value: proxy.frame(in: .named("Scroll")).minY)
        }
        .frame(height: 0)
        .onPreferenceChange(ScrollPreferenceKey.self ,perform: { value in
            withAnimation(.easeInOut(duration: 0.2)) {
                viewModel.hasScrolled = value < 0 ? true : false
            }
        })
    }
    
    var featured: some View {
        TabView {
            ForEach(featuredCourses) { course in
                GeometryReader { proxy in
                    let minX = proxy.frame(in: .global).minX
                    FeaturedItem(course: course)
                        .padding(.vertical, 40)
                        .rotation3DEffect(.degrees(minX / -10), axis: (x: 0, y: 1, z: 0))
                        .shadow(color: Color.ShadowColor.opacity(0.3), radius: 10, x: 0, y: 10)
                        .blur(radius: abs(minX) / 40)
                        .overlay {
                            Image(course.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 230)
                                .offset(x: 32, y: -80)
                                .offset(x: minX / 2)
                        }
                        .onTapGesture {
                            selectedFeaturedCourse = course
                            viewModel.showFeaturedCourse = true
                        }
                }
            }
        }
        .tabViewStyle(.page)
        .frame(height: 430)
        .background(
            Image("Blob 1")
                .offset(x: 250, y: -100)
        )
        .sheet(isPresented: $viewModel.showFeaturedCourse) {
            CourseDetaileView(namespace: namespace, course: $selectedFeaturedCourse, show: $viewModel.showFeaturedCourse)
        }
    }
    
    var categoriesSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(Array(categories.enumerated()), id: \.offset) { index, category in
                    CategoryItem(category: category, selectedId: $selectedCategoryId)
                        .onTapGesture {
                            withAnimation {
                                selectedCategoryId = category.id
                                if viewModel.selectedCategoryIndex != index {
                                    viewModel.selectedCategoryIndex = index
                                }
                            }
                        }
                }
            }
            .padding(.horizontal, 20)
            Spacer()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(Model())
    }
}

