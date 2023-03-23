//
//  PromotionsView.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/2/23.
//

import SwiftUI

struct PromotionsView: View {
    
    @StateObject var viewModel = PromotionsViewModel()
    
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            
            ScrollView {
                HStack {
                    Text("Бонуси".uppercased())
                        .titleStyle()
                    Text("Баланс: 27")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)
                    Image(systemName: "star.fill")
                        .font(.subheadline)
                        .padding(.trailing, 20)
                        .foregroundColor(.secondary)
                        .offset(y: -1)
                }
                bonusSection
                
                Text("Акції".uppercased())
                    .titleStyle()
                promotionsSection
            }
            .safeAreaInset(edge: .top, content: {
                Color.clear.frame(height: 70)
            })
            .overlay {
                NavigationBar(hasScrolled: .constant(true), title: "Акції і бонуси")
            }
            .background(Image("Blob 1").offset(x: -100, y: -400))
        }
    }
    
    var promotionsSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 25) {
                ForEach(handbooks) { handbook in
                    HandbookItem(handbook: handbook)
                }
            }
            .padding(.horizontal, 20)
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
        }
    }
    
    var bonusSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(courses) { course in
                    SmallCourseItem(course: course)
                }
            }
            .padding(.horizontal, 20)
            Spacer()
        }
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        PromotionsView()
    }
}
