//
//  MapPreviewView.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/21/23.
//

import SwiftUI

struct MapPreviewView: View {
    @EnvironmentObject private var vm: MapsViewModel
    @EnvironmentObject var model: Model
    @AppStorage("optionSelected") var optionSelected = false
    let location: Location
    
    var body: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 16.0) {
                imageSection
                titleSection
            }
            
            VStack(spacing: 8) {
                choosePointButton
                nextButton
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(.ultraThinMaterial)
                .offset(y: 50)
        )
        .cornerRadius(30)
    }
}

extension MapPreviewView {
    private var imageSection: some View {
        ZStack {
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .cornerRadius(30)
            }
        }
        .padding(6)
        .background(Color.white)
        .cornerRadius(30)
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 4.0) {
            Text(location.name)
                .font(.title2)
                .fontWeight(.bold)
            Text(location.cityName)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var choosePointButton: some View {
        Button {
            if let mapLocation = vm.mapLocation {
                model.locationTimePayment[0].title = "Самовивіз"
                model.locationTimePayment[0].subtitle = mapLocation.name
//                model.locationTimePayment[0].icon = item.icon
                optionSelected.toggle()
            }
        } label: {
            Text("Забрати тут")
                .frame(width: 125, height: 35)
        }
        .font(.headline)
        .tint(.white)
        .padding()
        .frame(maxWidth: .infinity)
        .frame(height: 50)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.linearGradient(colors: [.purple, .red], startPoint: .topLeading, endPoint: .bottomTrailing))
        )
    }
    
    private var nextButton: some View {
        Button {
            vm.nextButtonPressed()
        } label: {
            Text("Наступний")
                .frame(width: 125, height: 35)
        }
        .font(.headline)
        .tint(.white)
        .padding()
        .frame(maxWidth: .infinity)
        .frame(height: 50)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .foregroundColor(.secondary)
                .opacity(0.5)
        )
    }
}

struct MapPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        MapPreviewView(location: LocationsDataService.locations.first!)
            .padding()
            .environmentObject(MapsViewModel())
    }
}
