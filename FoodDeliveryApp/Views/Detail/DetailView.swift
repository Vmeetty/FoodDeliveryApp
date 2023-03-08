//
//  DetailView.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/2/23.
//

import SwiftUI

struct DetailView: View {
    var namespace: Namespace.ID
    @Binding var food: Food
    @State var isDragble = true
    
    @State var viewState: CGSize = .zero
    @State var showSection = false
    @State var appear = [false, false, false]
    @State var selectedSection = courseSections[0]
    
    @EnvironmentObject var model: Model
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            ScrollView {
                cover
                Group {
                    container
                    additionsSection
                        .opacity(appear[2] ? 1 : 0)
                }
                .offset(y: -30)
            }
            .coordinateSpace(name: "scroll")
            .background(Color("Background"))
            .mask(RoundedRectangle(cornerRadius: appear[0] ? 0 : 30))
            .mask(RoundedRectangle(cornerRadius: viewState.width / 3))
            .modifier(OutlineModifier(cornerRadius: viewState.width / 3))
            .shadow(color: Color("Shadow").opacity(0.5), radius: 30, x: 0, y: 10)
            .scaleEffect(-viewState.width/500 + 1)
            .background(Color("Shadow").opacity(viewState.width / 500))
            .background(.ultraThinMaterial)
            .gesture(isDragble ? drag : nil)
            .ignoresSafeArea()
            
            closeButton
                .opacity(appear[0] ? 1 : 0)
        }
        .zIndex(1)
        .onAppear {
            fadeIn()
        }
    }
    
    var cover: some View {
        GeometryReader { proxy in
            let scrollY = proxy.frame(in: .named("scroll")).minY
            
            VStack {
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .frame(height: scrollY > 0 ? 500 + scrollY : 500)
            .background(
                Image(food.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .matchedGeometryEffect(id: "image\(food.id)", in: namespace)
                    .offset(y: scrollY > 0 ? -scrollY : 0)
                    .accessibility(hidden: true)
            )
            .mask {
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .matchedGeometryEffect(id: "mask\(food.id)", in: namespace)
                    .offset(y: scrollY > 0 ? -scrollY : 0)
            }
        }
        .frame(height: 400)
    }
    
    var closeButton: some View {
        Button {
            isDragble ?
            withAnimation(.closeCard) {
                model.showDetail = false
            }
            : dismiss()
            fadeOut()
        } label: {
            CloseButton()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        .padding(20)
        .ignoresSafeArea()
    }
    
    var addionsContainer: some View {
        VStack(alignment: .leading) {
            ForEach(Array(food.options.enumerated()), id: \.offset) { index, addition in
                if index != 0 { Divider() }
                AdditionRow(addition: addition)
            }
        }
    }
    
    var additionsSection: some View {
        VStack(alignment: .leading) {
            ForEach(Array(food.options.enumerated()), id: \.offset) { index, addition in
                if index != 0 { Divider() }
                AdditionRow(addition: addition)
            }
        }
        .background(.ultraThinMaterial)
        .backgroundStyle(cornerRadius: 30)
        .padding(.horizontal, 20)
    }
    
    var container: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(food.title)
                .font(.title).bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.primary)
                .matchedGeometryEffect(id: "title\(food.id)", in: namespace)
            Text(food.weight.uppercased())
                .font(.footnote).bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.secondary.opacity(0.7))
                .opacity(appear[0] ? 1 : 0)
            Text(food.text)
                .font(.footnote)
                .opacity(appear[0] ? 1 : 0)
            Divider()
                .foregroundColor(.secondary)
                .opacity(appear[1] ? 1 : 0)
            HStack {
                Image(systemName: "hryvniasign")
                    .padding(8)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                    .strokeStyle(cornerRadius: 12)
                    .matchedGeometryEffect(id: "currency\(food.id)", in: namespace)
                Text(food.price)
                    .font(.title2)
                    .foregroundColor(.primary.opacity(0.7))
                    .matchedGeometryEffect(id: "price\(food.id)", in: namespace)
            }
        }
        .padding(20)
        .background(
            Rectangle()
                .fill(.ultraThinMaterial)
                .backgroundStyle(cornerRadius: 30)
                .matchedGeometryEffect(id: "blur\(food.id)", in: namespace)
        )
        .frame(maxHeight: .infinity, alignment: .bottom)
        .padding(20)
    }
    
    var drag: some Gesture {
        DragGesture(minimumDistance: 30, coordinateSpace: .local)
            .onChanged({ newValue in
                guard newValue.translation.width > 0 else { return }
                
                if newValue.startLocation.x < 100 {
                    withAnimation {
                        viewState = newValue.translation
                    }
                }
                
                if viewState.width > 120 {
                    close()
                }
            })
            .onEnded({ newValue in
                if viewState.width > 80 {
                    close()
                } else {
                    withAnimation(.closeCard) {
                        viewState = .zero
                    }
                }
            })
    }
    
    private func close() {
        withAnimation(.closeCard.delay(0.1)) {
            model.showDetail = false
        }
        withAnimation(.closeCard) {
            viewState = .zero
        }
        
        isDragble = false
    }
    
    private func fadeIn() {
        withAnimation(.easeOut.delay(0.3)) {
            appear[0] = true
        }
        withAnimation(.easeOut.delay(0.4)) {
            appear[1] = true
        }
        withAnimation(.easeOut.delay(0.5)) {
            appear[2] = true
        }
    }
    
    private func fadeOut() {
        appear[0] = false
        appear[1] = false
        appear[2] = false
    }
}

struct CourseDetaoleView_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        DetailView(namespace: namespace, food: .constant(Food(title: "MIAMI", weight: "Вага 340 г", text: "Перетерті томати, моцарела, базилік. Алергени: злаки, лактоза.", image: "MIAMI", price: "430", category: "Burger", options: [Addition(title: "Гострий", values: [AdditionValue(title: "Так"), AdditionValue(title: "Ні")])])))
            .environmentObject(Model())
    }
}
