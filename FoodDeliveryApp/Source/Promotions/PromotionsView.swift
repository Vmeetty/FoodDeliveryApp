//
//  PromotionsView.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/2/23.
//

import SwiftUI

struct PromotionsView: View {
    
    @StateObject var viewModel = PromotionsViewModel()
    @State var showInfo = false
    
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            
            ScrollView {
                HStack {
                    HStack {
                        Text("Бонуси".uppercased())
                            .font(.footnote.weight(.semibold))
                            .foregroundColor(.secondary)
                        Image(systemName: "info.circle")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .offset(y: -1)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                    .onTapGesture {
                        withAnimation {
                            showInfo.toggle()
                        }
                    }
                    
                    HStack {
                        Text("Баланс: 27")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.secondary)
                        Image(systemName: "star.fill")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .offset(y: -1)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing, 20)
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
            .overlay {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(bonusInfo) { bonus in
                        Text(bonus.title)
                    }
                }
                .padding()
                .foregroundColor(.white)
                .background(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(.linearGradient(colors: [.purple, .pink], startPoint: .topLeading, endPoint: .bottomTrailing))
                )
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .frame(maxHeight: .infinity, alignment: .top)
                .offset(x: 20, y: 110)
                .opacity(showInfo ? 1 : 0)
            }
            .background(Image("Blob 1").offset(x: -100, y: -400))
        }
        .onTapGesture {
            withAnimation {
                showInfo = false
            }
        }
    }
    
    var promotionsSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 25) {
                ForEach(promos) { promo in
                    HandbookItem(promo: promo)
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
