//
//  TabBar.swift
//  DesignCodeiOS15
//
//  Created by admin on 2/4/23.
//

import SwiftUI

struct TabBar: View {
    @EnvironmentObject private var model: Model
    @AppStorage("selectedTab") var selectedTab: Tab = .home
    @State var selectedColor: Color = .teal
    @State var tabBarItemWidth: CGFloat = 0
    
    var body: some View {
        HStack {
            buttons
        }
        .padding(.horizontal, 8)
        .padding(.top, 14)
        .frame(height: 88, alignment: .top)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 34, style: .continuous))
        .background(
            circleBackground
        )
        .overlay (
            overlay
        )
        .strokeStyle(cornerRadius: 34)
        .frame(maxHeight: .infinity, alignment: .bottom)
        .padding()
        .ignoresSafeArea()
    }
    
    var buttons: some View {
        ForEach(Array(tabBarItems.enumerated()), id: \.offset) { index, item in
            Button {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                    selectedTab = item.tab
                    selectedColor = item.color
                }
            } label: {
                VStack(spacing: 0) {
                    Image(systemName: item.imageName)
                        .symbolVariant(.fill)
                        .font(.body.bold())
                        .frame(width: 44, height: 29)
                    Text(item.title)
                        .font(.caption2)
                        .lineLimit(1)
                }
                .frame(maxWidth: .infinity)
            }
            .foregroundColor(selectedTab == item.tab ? .primary : .secondary)
            .blendMode(selectedTab == item.tab ? .overlay : .normal)
            .overlay {
                GeometryReader { proxy in
                    Color.clear.preference(key: TabItemPreferenceKey.self, value: proxy.size.width)
                }
            }
            .onPreferenceChange(TabItemPreferenceKey.self) { value in
                tabBarItemWidth = value
            }
            .overlay {
                if !model.orderItems.isEmpty {
                    if index == 2 {
                        ZStack {
                            Circle()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.pink)
                            Text(countOfItems())
                                .font(.footnote)
                                .foregroundColor(.white)
                        }
                        .offset(x: 13, y: -15)
                    }
                }
            }
        }
    }
    
    var circleBackground: some View {
        HStack {
            if selectedTab == .library { Spacer() }
            if selectedTab == .explore { Spacer() }
            if selectedTab == .notifications {
                Spacer()
                Spacer()
            }
            Circle().fill(selectedColor).frame(width: tabBarItemWidth)
            if selectedTab == .home { Spacer() }
            if selectedTab == .explore {
                Spacer()
                Spacer()
            }
            if selectedTab == .notifications { Spacer() }
        }
        .padding(.horizontal, 8)
    }
    
    var overlay: some View {
        HStack {
            if selectedTab == .library { Spacer() }
            if selectedTab == .explore { Spacer() }
            if selectedTab == .notifications {
                Spacer()
                Spacer()
            }
            Rectangle()
                .fill(selectedColor)
                .frame(width: 28, height: 5)
                .cornerRadius(3)
                .frame(width: tabBarItemWidth)
                .frame(maxHeight: .infinity, alignment: .top)
            if selectedTab == .home { Spacer() }
            if selectedTab == .explore {
                Spacer()
                Spacer()
            }
            if selectedTab == .notifications { Spacer() }
        }
        .padding(.horizontal, 8)
    }
    
    private func countOfItems() -> String {
        var count = 0
        for item in model.orderItems {
            count += item.countSelected
        }
        return String(count)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
