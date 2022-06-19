//
//  OnboardingPageView.swift
//  ECommnerceSample
//
//  Created by Geonhee on 2022/06/19.
//

import SwiftUI

struct OnboardingPageView: View {
  @State var showLoginPage: Bool = false
  
  var body: some View {
    VStack(alignment: .leading) {
      
      Text("Find your\nGadget")
        .font(.system(size: 45))
        .fontWeight(.bold)
        .padding()
        .foregroundColor(.white)
      
      Image(systemName: "swift")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .foregroundColor(.orange)
        .padding()
        .padding(.bottom, 30)
      
      Button(action: {
        withAnimation {
          showLoginPage = true
        }
      }) {
        Text("Get Started")
          .font(.title2)
          .fontWeight(.semibold)
          .padding(.vertical, 18)
          .frame(maxWidth: .infinity)
          .background(Color.white)
          .cornerRadius(10)
          .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
          .foregroundColor(Color(uiColor: .systemIndigo))
      }
      .padding(.horizontal, 30)
      .offset(y: screenRect.height < 750 ? 20 : 40)
      
      Spacer()
    }
    .padding()
    .padding(.top, screenRect.height < 750 ? 20 : 0)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(
      Color(uiColor: .systemIndigo)
    )
    .overlay(
      Group {
        if showLoginPage {
          LoginPageView()
            .transition(.move(edge: .bottom))
        }
      }
    )
  }
}

struct OnboardingPageView_Previews: PreviewProvider {
  static var previews: some View {
    OnboardingPageView()
  }
}
