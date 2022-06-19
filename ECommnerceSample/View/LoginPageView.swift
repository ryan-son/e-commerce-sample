//
//  LoginPageView.swift
//  ECommnerceSample
//
//  Created by Geonhee on 2022/06/19.
//

import SwiftUI

struct LoginPageView: View {
  @StateObject var loginViewModel: LoginPageViewModel = LoginPageViewModel()
  
  var body: some View {
    VStack {
      Text("Welcome\nback")
        .font(.system(size: 55).bold())
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: screenRect.height / 3.5)
        .padding()
        .background(
        
          ZStack {
            LinearGradient(
              colors: [
                Color(uiColor: .systemPink),
                Color(uiColor: .systemPink).opacity(0.8),
                Color(uiColor: .systemIndigo)
              ],
              startPoint: .top,
              endPoint: .bottom
            )
            .frame(width: 100, height: 100)
            .clipShape(Circle())
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding(.trailing)
            .offset(y: -25)
            .ignoresSafeArea()
            
            Circle()
              .strokeBorder(Color.white.opacity(0.3), lineWidth: 3)
              .frame(width: 23, height: 23)
              .blur(radius: 2)
              .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
              .padding(30)
            
            Circle()
              .strokeBorder(Color.white.opacity(0.3), lineWidth: 3)
              .frame(width: 23, height: 23)
              .blur(radius: 2)
              .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
              .padding(.leading, 30)
          }
        )
      
      ScrollView(.vertical, showsIndicators: false) {
        VStack(spacing: 15) {
          Text(loginViewModel.registerUser ? "Register" : "Login")
            .font(.system(size: 22).bold())
            .frame(maxWidth: .infinity, alignment: .leading)
          
          customTextField(
            icon: "envelope",
            title: "Email",
            hint: "ryan.son1002@gmail.com",
            value: $loginViewModel.email,
            showPassword: $loginViewModel.showPassword
          )
          .padding(.top, 30)
          
          customTextField(
            icon: "lock",
            title: "Password",
            hint: "123456",
            value: $loginViewModel.password,
            showPassword: $loginViewModel.showPassword
          )
          .padding(.top, 10)
          
          if loginViewModel.registerUser {
            customTextField(
              icon: "lock",
              title: "Re-enter Password",
              hint: "123456",
              value: $loginViewModel.reenterPassword,
              showPassword: $loginViewModel.showReenterPassword
            )
            .padding(.top, 10)
          }
          
          Button(action: { loginViewModel.forgotPassword() }) {
            Text("Forgot Password?")
              .font(.system(size: 14))
              .fontWeight(.semibold)
              .foregroundColor(Color(uiColor: .systemIndigo))
          }
          .padding(.top, 8)
          .frame(maxWidth: .infinity, alignment: .leading)
          
          Button(action: {
            if loginViewModel.registerUser {
              loginViewModel.register()
            } else {
              loginViewModel.login()
            }
           }) {
            Text("Login")
              .font(.system(size: 17))
              .fontWeight(.bold)
              .padding(.vertical, 20)
              .frame(maxWidth: .infinity)
              .foregroundColor(.white)
              .background(Color(uiColor: .systemIndigo))
              .cornerRadius(15)
              .shadow(color: Color.black.opacity(0.07), radius: 5, x: 5, y: 5)
          }
           .padding(.top, 25)
           .padding(.horizontal)
          
          Button(action: {
            withAnimation {
              loginViewModel.registerUser.toggle()
            }
          }) {
            Text(loginViewModel.registerUser ? "Back to login" : "Create account")
              .font(.system(size: 14))
              .fontWeight(.semibold)
              .foregroundColor(Color(uiColor: .systemIndigo))
          }
          .padding(.top, 8)
        }
        .padding(30)
        
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(Color.white)
      .clipShape(CustomCorners(corners: [.topLeft, .topRight], radius: 25))
      .ignoresSafeArea()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color(uiColor: .systemIndigo))
    .onChange(of: loginViewModel.registerUser) { newValue in
      loginViewModel.email = ""
      loginViewModel.password = ""
      loginViewModel.reenterPassword = ""
      loginViewModel.showPassword = false
      loginViewModel.showReenterPassword = false
    }
  }
  
  @ViewBuilder
  func customTextField(
    icon: String,
    title: String,
    hint: String,
    value: Binding<String>,
    showPassword: Binding<Bool>
  ) -> some View {
    VStack(alignment: .leading, spacing: 12) {
      Label(
        title: {
          Text(title)
            .font(.system(size: 14))
        },
        icon: {
          Image(systemName: icon)
        }
      )
      .foregroundColor(Color.black.opacity(0.8))
      
      if title.contains("Password") && !showPassword.wrappedValue {
        SecureField(hint, text: value)
          .padding(.top, 2)
      } else {
        TextField(hint, text: value)
          .padding(.top, 2)
      }
      
      Divider()
        .background(Color.black.opacity(0.4))
    }
    .overlay(
      Button(action: {
        showPassword.wrappedValue.toggle()
      }) {
        Group {
          if title.contains("Password") {
            Text(showPassword.wrappedValue ? "Hide" : "Show")
              .font(.system(size: 13).bold())
              .foregroundColor(Color(uiColor: .systemIndigo))
            
          }
        }
      }
        .offset(y: 8)
      ,
      alignment: .trailing
    )
  }
}

struct LoginPageView_Previews: PreviewProvider {
  static var previews: some View {
    LoginPageView()
  }
}
