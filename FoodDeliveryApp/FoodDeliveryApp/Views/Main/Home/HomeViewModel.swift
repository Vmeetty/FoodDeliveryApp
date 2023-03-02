//
//  HomeViewModel.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/2/23.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var show = false
    @Published var hasScrolled = false
    @Published var showStatusBar = true
    @Published var showFeaturedCourse = false
    @Published var selectedCategoryIndex = 0
}
