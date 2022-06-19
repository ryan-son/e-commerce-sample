//
//  MainPageView.swift
//  ECommnerceSample
//
//  Created by Geonhee on 2022/06/19.
//

import SwiftUI

struct MainPageView: View {
  @State var currentTab: Tab = .home
  @StateObject var sharedDataViewModel: SharedDataViewModel = SharedDataViewModel()
  @Namespace var animation
  
  init() {
    UITabBar.appearance().isHidden = true
  }
  
  var body: some View {
    VStack(spacing: 0) {
      TabView(selection: $currentTab) {
        HomeView(animation: animation)
          .environmentObject(sharedDataViewModel)
          .tag(Tab.home)
        
        LikedView()
          .environmentObject(sharedDataViewModel)
          .tag(Tab.liked)
        
        ProfileView()
          .tag(Tab.profile)
        
        CartView()
          .environmentObject(sharedDataViewModel)
          .tag(Tab.cart)
      }
      
      HStack(spacing: 0) {
        ForEach(Tab.allCases, id: \.self) { tab in
          Button(action: { currentTab = tab }) {
            Image(systemName: tab.rawValue)
              .resizable()
              .renderingMode(.template)
              .aspectRatio(contentMode: .fit)
              .frame(width: 22, height: 22)
              .background(
                Color(uiColor: .systemIndigo)
                  .opacity(0.1)
                  .cornerRadius(5)
                  .blur(radius: 5)
                  .padding(-7)
                  .opacity(currentTab == tab ? 1 : 0)
              )
              .frame(maxWidth: .infinity)
              .foregroundColor(
                currentTab == tab ?
                Color(uiColor: .systemIndigo) :
                  Color.black.opacity(0.3)
              )
          }
        }
      }
      .padding([.horizontal, .top])
      .padding(.bottom, 10)
    }
    .background(Color(uiColor: .systemGray5))
    .overlay(
      ZStack {
        if let product = sharedDataViewModel.detailProduct,
           sharedDataViewModel.showDetailProduct {
          ProductDetailView(product: product, animation: animation)
            .environmentObject(sharedDataViewModel)
            .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .opacity))
        }
      }
    )
  }
}

struct MainPageView_Previews: PreviewProvider {
  static var previews: some View {
    MainPageView()
  }
}

enum Tab: String, CaseIterable {
  case home = "house.fill"
  case liked = "heart.fill"
  case profile = "person.crop.circle.fill"
  case cart = "cart.fill"
}
