//
//  SignUpView.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/2/23.
//

import SwiftUI

struct SignUpView: View {
    
    enum Field {
        case email
        case password
    }
    
    @State var email = ""
    @State var password = ""
    @FocusState var focusedField: Field?
    @State var yCircle: CGFloat = 120
    @State var emailY: CGFloat = 0
    @State var passwordY: CGFloat = 0
    @State var circleColor: Color = .blue
    @State var appear = [false, false, false]
    @EnvironmentObject var model: Model
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Sign up")
                .font(.largeTitle).bold()
                .opacity(appear[0] ? 1 : 0)
                .offset(y: appear[0] ? 0 : 20)
            Text("Access 120+ hours of courses, tutorials and livestreams")
                .font(.headline)
                .opacity(appear[1] ? 1 : 0)
                .offset(y: appear[1] ? 0 : 20)
            Group {
                TextField("Email", text: $email)
                    .inputStyle(icon: "mail")
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .focused($focusedField, equals: .email)
                    .shadow(color: focusedField == .email ? .primary.opacity(0.3) : .clear, radius: 10, x: 0, y: 3)
                    .overlay(geometry)
                    .onPreferenceChange(CirclePreferenceKey.self) { value in
                        emailY = value
                        yCircle = value
                    }
                SecureField("Password", text: $password)
                    .inputStyle(icon: "lock")
                    .textContentType(.password)
                    .focused($focusedField, equals: .password)
                    .shadow(color: focusedField == .password ? .primary.opacity(0.3) : .clear, radius: 10, x: 0, y: 3)
                    .overlay(geometry)
                    .onPreferenceChange(CirclePreferenceKey.self) { value in
                        passwordY = value
                    }
                Button {
                    
                } label: {
                    Text("Create account")
                        .frame(maxWidth: .infinity)
                }
                .font(.headline)
                .blendMode(.overlay)
                .buttonStyle(.angular)
                .tint(.accentColor)
                .controlSize(.large)
                .shadow(color: Color("Shadow").opacity(0.2), radius: 30, x: 0, y: 20)
                
                Text("By clicking on ")
                + Text("_Create account_")
                + Text(", you agree to our __[Terms of Service](https://google.com)__ and **[Privacy Policy](https://google.com)**")
                
                Divider()
                
                HStack {
                    Text("Already have an account?")
                    Button {
                        model.selectedModalView = .signIn
                    } label: {
                        Text("**Sign in**")
                    }
                }
                .font(.footnote)
                .foregroundColor(.secondary)
                .tint(.secondary)
            }
            .opacity(appear[2] ? 1 : 0)
            .offset(y: appear[2] ? 0 : 20)
            
            
        }
        .padding(20)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
        .background(
            Circle().fill(circleColor)
                .frame(width: 68, height: 68)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .offset(y: yCircle)
                .opacity(appear[2] ? 1 : 0)
        )
        .coordinateSpace(name: "container")
        .strokeStyle(cornerRadius: 30)
        .onChange(of: focusedField) { value in
            withAnimation {
                yCircle = focusedField == .email ? emailY : passwordY
                circleColor = focusedField == .email ? .blue : .red
            }
        }
        .onAppear {
            withAnimation(.spring().delay(0.1)) {
                appear[0] = true
            }
            withAnimation(.spring().delay(0.2)) {
                appear[1] = true
            }
            withAnimation(.spring().delay(0.3)) {
                appear[2] = true
            }
        }
    }
    
    var geometry: some View {
        GeometryReader { proxy in
            Color.clear.preference(key: CirclePreferenceKey.self, value: proxy.frame(in: .named("container")).minY)
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject(Model())
    }
}
