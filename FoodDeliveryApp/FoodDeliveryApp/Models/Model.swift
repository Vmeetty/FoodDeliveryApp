//
//  Model.swift
//  DesignCodeiOS15
//
//  Created by admin on 2/6/23.
//

import Foundation

class Model: ObservableObject {
    @Published var showDetail = false
    @Published var selectedModalView: ModalEnum = .signIn
}

enum ModalEnum: String {
    case signIn
    case signUp
}
