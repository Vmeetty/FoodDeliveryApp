//
//  OrderContactsItem.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/14/23.
//

import SwiftUI

struct OrderContactsItem: View {
    var title: String
    @Binding var answer: String
    @Binding var showAlert: Bool
    @State private var count: Int = 1
    @State private var phoneAlertMessage = "Ваша відповідь"
    @FocusState private var fieldIsFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            switch title {
            case "Поверх":
                Text(title)
                    .fontWeight(.medium)
                TextField("Ваша відповідь", text: $answer)
                    .textContentType(.oneTimeCode)
                    .keyboardType(.numberPad)
            case "Телефон для зв‘язку":
                Text(title)
                    .fontWeight(.medium)
                TextField("", text: $answer)
                    .placeholder(when: answer.isEmpty, placeholder: {
                        Text(phoneAlertMessage).foregroundColor(showAlert ? .pink : .secondary)
                    })
                    .textContentType(.telephoneNumber)
                    .keyboardType(.phonePad)
                    .overlay {
                        Circle()
                            .foregroundColor(showAlert ? .pink : .secondary)
                            .frame(width: 7, height: 7)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .focused($fieldIsFocused)
                    .onChange(of: fieldIsFocused, perform: { isFocused in
                        if !isFocused {
                            if answer == "" {
                                phoneAlertMessage = "Будь ласка, вкажіть телефон"
                                showAlert = true
                            } else {
                                showAlert = false
                            }
                        }
                    })
//                    .onSubmit {
//                        if answer == "" {
//                            showAlert = true
//                        }
//                    }
                
            case "Прибори":
                HStack(spacing: 0) {
                    Text(title)
                        .fontWeight(.medium)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                    CounterView(count: $count) {
                        if count > 0 {
                            count -= 1
                            answer = String(count)
                        }
                    } plusAction: {
                        count += 1
                        answer = String(count)
                    }
                    .padding(2)
                    .background(
                        RoundedRectangle(cornerRadius: 30, style: .continuous)
                            .opacity(0.05)
                    )
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .onAppear {
                        if let intAnswer = Int(answer) {
                            count = intAnswer
                        }
                    }
                }
            default:
                Text(title)
                TextField("Ваша відповідь", text: $answer)
            }
            
        }
    }
}

struct OrderContactsItem_Previews: PreviewProvider {
    static var previews: some View {
        OrderContactsItem(title: "Квартира/офіс", answer: .constant("№4"), showAlert: .constant(false))
    }
}
