//
//  LoginPageViewModel.swift
//  ECommnerceSample
//
//  Created by Geonhee on 2022/06/19.
//

import SwiftUI

final class LoginPageViewModel: ObservableObject {
  @Published var email: String = ""
  @Published var password: String = ""
  @Published var showPassword: Bool = false
  
  @Published var registerUser: Bool = false
  @Published var reenterPassword: String = ""
  @Published var showReenterPassword: Bool = false
  
  @AppStorage("logStatus") var logStatus: Bool = false
  
  func login() {
    withAnimation {
      logStatus = true
    }
  }
  
  func register() {
    withAnimation {
      logStatus = true
    }
  }
  
  func forgotPassword() {
    
  }
}

