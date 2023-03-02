//
//  SearchView.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/2/23.
//

import SwiftUI

struct SearchView: View {
    @State var text = ""
    @State var show = false
    @State var selectedCourse = courses[0]
    @Namespace var namespace
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    content
                }
                .frame(maxWidth: .infinity)
            }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss.callAsFunction()
                    } label: {
                        Text("Done")
                    }
                }
            }
        }
        .searchable(text: $text, placement: .navigationBarDrawer(displayMode: .always), prompt: "Swift, SwiftUI, Design...") {
            ForEach(suggestions) { suggestion in
                Button {
                    text = suggestion.text
                } label: {
                    Text(suggestion.text)
                }
                .searchCompletion(suggestion.text)
            }
        }
    }
    
    var content: some View {
        VStack {
            ForEach (Array(results.enumerated()), id: \.offset) { index, course in
                if index != 0 { Divider() }
                Button {
                    show = true
                    selectedCourse = course
                } label: {
                    HStack(alignment: .top, spacing: 12) {
                        Image(course.image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 44, height: 44)
                            .background(Color("Background"))
                            .mask(Circle())
                        VStack(alignment: .leading, spacing: 4) {
                            Text(course.title).bold()
                                .foregroundColor(.primary)
                            Text(course.text)
                                .foregroundColor(.secondary)
                                .font(.footnote)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .multilineTextAlignment(.leading)
                        }
                    }
                    .padding(.vertical, 4)
                    .listRowSeparator(.hidden)
                }
                .buttonStyle(.plain)
            }
            
            if results.isEmpty {
                Text("No results found")
            }
        }
        .padding(20)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
        .strokeStyle(cornerRadius: 30)
        .padding(20)
        .background(
            Rectangle()
                .fill(.regularMaterial)
                .frame(height: 200)
                .frame(maxHeight: .infinity, alignment: .top)
                .blur(radius: 20)
                .offset(y: -200)
        )
        .background(
            Image("Blob 1").offset(x: -100, y: -200)
                .accessibilityHidden(true)
        )
        .sheet(isPresented: $show) {
            CourseDetaileView(namespace: namespace, course: $selectedCourse, show: $show)
        }
    }
    
    var results: [Course] {
        if text.isEmpty {
            return courses
        } else {
            return courses.filter { $0.title.contains(text) }
        }
    }
    
    var suggestions: [Suggestion] {
        if text.isEmpty {
            return suggestionsData
        } else {
            return suggestionsData.filter { $0.text.contains(text) }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
