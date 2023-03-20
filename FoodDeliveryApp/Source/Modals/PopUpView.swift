//
//  PopUpView.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/17/23.
//

import SwiftUI

struct PopUpView: View {
    @EnvironmentObject var model: Model
    @State var viewState: CGSize = .zero
    @State var isDismiss = false
    @State var appear = [false, false, false]
    @AppStorage("optionSelected") var optionSelected = false
    
    var body: some View {
        ZStack {
            Color.clear.background(.regularMaterial)
                .ignoresSafeArea()
                .opacity(0.8)
                .onTapGesture {
                    dismissModal()
                }
            
            Group {
                switch model.selectedPopUpView {
                case .date:
                    DeliveryTimeView()
                case .payment:
                    PaymentTypeView()
                default:
                    EmptyView()
                }
            }
            .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .offset(x: viewState.width, y: viewState.height)
            .offset(y: isDismiss ? 1000 : 0)
            .rotationEffect(.degrees(viewState.width / 40))
            .rotation3DEffect(.degrees(viewState.height / 30), axis: (x: 1, y: 0, z: 0))
            .hueRotation(.degrees(viewState.width / 5))
            .gesture(drag)
            .shadow(color: Color("Shadow").opacity(0.2), radius: 30, x: 0, y: 20)
            .opacity(appear[0] ? 1 : 0)
            .offset(y: appear[0] ? 0 : 200)
            .padding(20)
            
            Button {
                dismissModal()
            } label: {
                Image(systemName: "xmark")
                    .font(.body.weight(.bold))
                    .foregroundColor(.secondary)
                    .padding(8)
                    .background(.ultraThinMaterial, in: Circle())
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding(20)
            .opacity(appear[1] ? 1 : 0)
            .offset(y: appear[1] ? 0 : -200)
        }
        .onAppear {
            withAnimation(.easeOut) {
                appear[0] = true
            }
            withAnimation(.easeOut.delay(0.1)) {
                appear[1] = true
            }
            withAnimation(.easeOut(duration: 1).delay(0.2)) {
                appear[2] = true
            }
        }
        .onChange(of: optionSelected) { newValue in
            dismissModalWithDelay()
        }
    }
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                viewState = value.translation
            }
            .onEnded { value in
                if value.translation.height > 200 {
                    dismissModal()
                }
                withAnimation(.openCard) {
                    viewState = .zero
                }
            }
    }
    
    func dismissModal() {
        withAnimation {
            isDismiss = true
        }
        withAnimation(.linear.delay(0.3)) {
            model.showPopUp = false
        }
    }
    
    func dismissModalWithDelay() {
        withAnimation(.linear.delay(0.3)) {
            isDismiss = true
        }
        withAnimation(.linear.delay(0.6)) {
            model.showPopUp = false
        }
    }
}

struct PopUpView_Previews: PreviewProvider {
    static var previews: some View {
        PopUpView()
            .environmentObject(Model())
    }
}
