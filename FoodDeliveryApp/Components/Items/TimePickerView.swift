//
//  TimePickerView.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/29/23.
//

import SwiftUI

struct TimePickerView: View {
    @Binding var infoItem: Info
    @State var currentTime = Date()
    @EnvironmentObject var model: Model
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: infoItem.icon)
                .frame(width: 36, height: 36)
                .background(.ultraThinMaterial)
                .mask(Circle())
            VStack(alignment: .leading, spacing: 6) {
                Text(infoItem.title)
                    .fontWeight(.bold)
                DatePicker("", selection: $currentTime, in: Date.now.addingTimeInterval(5400)...)
                    .labelsHidden()
            }
            Spacer()
        }
        .onAppear {
            currentTime = model.date
        }
        .onChange(of: currentTime) { _ in
            model.locationTimePayment[1].subtitle = formatDateStr()
            model.date = currentTime
        }
    }
    
    func formatDateStr() -> String {
        let selectedDay = dateFormatter.string(from: currentTime)
        let components = Calendar.current.dateComponents([.hour, .minute], from: currentTime)
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0
        return ("\(selectedDay) o \(hour):\(minute)")
    }
}

struct TimePickerView_Previews: PreviewProvider {
    static var previews: some View {
        TimePickerView(infoItem: .constant(Info(title: "Адреса", subtitle: "Авіаконструктора Сікорського 4Д", icon: "location", infoTab: .location)))
    }
}
