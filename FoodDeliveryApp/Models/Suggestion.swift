//
//  Suggestion.swift
//  DesignCodeiOS15
//
//  Created by admin on 2/8/23.
//

import SwiftUI

struct Suggestion: Identifiable {
    var id = UUID()
    var text: String
}

let suggestionsData = [
    Suggestion(text: "Swift"),
    Suggestion(text: "React"),
    Suggestion(text: "Design")
]
