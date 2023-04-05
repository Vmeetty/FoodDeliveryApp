//
//  Info.swift
//  DesignCodeiOS15
//
//  Created by admin on 2/28/23.
//

import SwiftUI

struct Info: Identifiable {
    let id = UUID()
    var title: String
    var subtitle: String
    var icon: String
    var infoTab: InfoTab
}

enum InfoTab {
    case location, time, payment
}
