//
//  LocationSearchView.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/25/23.
//

import SwiftUI

struct LocationSearchView: View {
    @Binding var locationTitle: String?
    @Binding var showLocationSearchView: Bool
    @EnvironmentObject var viewModel: LocationSearchViewModel
    
    var body: some View {
        VStack {
            HStack {
                Circle()
                    .fill(.black)
                    .frame(width: 6, height: 6)
                    .padding(.horizontal)
                
                TextField("Вкажіть адресу", text: $viewModel.queryFragment)
                    .frame(height: 32)
            }
            .padding()
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
            .padding()
            
            Divider()
                .padding(.horizontal)
            
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(viewModel.results, id: \.self) { result in
                        LocationSearchResultRow(title: result.title, subtitle: result.subtitle)
                            .onTapGesture {
                                locationTitle = result.title
                                viewModel.selectLocation(result)
                                showLocationSearchView.toggle()
                            }
                    }
                }
            }
        }
    }
}

struct LocationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchView(locationTitle: .constant("Вкажіть адресу"), showLocationSearchView: .constant(true))
    }
}
