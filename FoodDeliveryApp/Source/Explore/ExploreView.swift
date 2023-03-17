//
//  ExploreView.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/2/23.
//

import SwiftUI

struct ExploreView: View {
    
    @StateObject var viewModel = ExploreViewModel()
    
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            
            ScrollView {
                coursesSection
                
                Text("Topics".uppercased())
                    .titleStyle()
                
//                topicsSection
                
                Text("Popular".uppercased())
                    .titleStyle()
                
                handbookSection
            }
            .safeAreaInset(edge: .top, content: {
                Color.clear.frame(height: 70)
            })
            .overlay {
                NavigationBar(hasScrolled: .constant(true), title: "Explore")
            }
            .background(Image("Blob 1").offset(x: -100, y: -400))
        }
    }
    
    var coursesSection: some View {
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
    
//    var topicsSection: some View {
//        VStack {
//            ForEach(Array(locationTimePayment.enumerated()), id: \.offset) { index, topic in
//                VStack {
//                    if index != 0 { Divider() }
//                    OrderInfoItem(infoItem: topic)
//                }
//            }
//        }
//        .padding(20)
//        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
//        .strokeStyle(cornerRadius: 30)
//        .padding(.horizontal, 20)
//    }
    
    var handbookSection: some View {
        HStack(alignment: .top, spacing: 16) {
            
            ForEach(handbooks) { handbook in
                HandbookItem(handbook: handbook)
            }
        }
        .padding()
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
