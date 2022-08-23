//
//  SearchView.swift
//  ECommnerceSample
//
//  Created by Geonhee on 2022/06/19.
//

import SwiftUI

struct SearchView: View {
  @EnvironmentObject var homeViewModel: HomeViewModel
  @EnvironmentObject var sharedDataViewModel: SharedDataViewModel
  @FocusState var startTextField: Bool

  var animation: Namespace.ID

  var body: some View {
    VStack(spacing: 0) {
      HStack(spacing: 20) {
        Button(action: {
          withAnimation {
            homeViewModel.searchActivated = false
          }
          homeViewModel.searchText = ""
          sharedDataViewModel.fromSearchPage = false
        }) {
          Image(systemName: "arrow.left")
            .font(.title2)
            .foregroundColor(Color.black.opacity(0.7))
        }

        HStack(spacing: 15) {
          Image(systemName: "magnifyingglass")
            .font(.title2)
            .foregroundColor(.gray)
          
          TextField("Search", text: $homeViewModel.searchText)
            .focused($startTextField)
            .textCase(.lowercase)
            .disableAutocorrection(true)
        }
        .padding(.vertical, 12)
        .padding(.horizontal)
        .background(
          Capsule()
            .strokeBorder(Color(uiColor: .systemIndigo), lineWidth: 1.5)
        )
        .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
        .padding(.trailing, 20)
      }
      .padding([.horizontal, .vertical])
      
      if let products = homeViewModel.searchedProducts {
        if products.isEmpty {
          VStack(spacing: 10) {
            Image(systemName: "nosign")
              .resizable()
              .aspectRatio(contentMode: .fit)
              .frame(width: 100, height: 100)
              .padding(.vertical, 60)

            Text("Item Not Found")
              .font(.system(size: 22))
              .fontWeight(.bold)

            Text("Try a more generic search term or try looking for alternative products.")
              .font(.system(size: 16))
              .fontWeight(.bold)
              .foregroundColor(.gray)
              .multilineTextAlignment(.center)
              .padding(.horizontal, 30)
          }
          .padding()
        } else {
          ScrollView(.vertical, showsIndicators: false) {
            VStack {
              Text("Found \(products.count) results")
                .font(.system(size: 22))
                .fontWeight(.semibold)
                .padding(.vertical, 20)
              
              productCardsGridView(products: products)
                .padding(.top, 10)
            }
          }
        }
      } else {
        ProgressView()
          .padding(.top, 30)
          .opacity(homeViewModel.searchText.isEmpty ? 0 : 1)
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    .background(
      Color(uiColor: .systemGray5)
    )
    .onAppear {
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
        startTextField = true
      }
    }
  }
  
  @ViewBuilder
  func productCardsGridView(products: [Product]) -> some View {
      LazyVGrid(
        columns: [
          GridItem(.flexible()),
          GridItem(.flexible())
        ],
        spacing: 20
      ) {
        ForEach(products) { product in
        productCardView(product: product)
          .padding(.top, 80)
      }
    }
  }
  
  @ViewBuilder
  func productCardView(product: Product) -> some View {
    VStack(spacing: 10) {
      ZStack {
        if sharedDataViewModel.showDetailProduct {
          Image(product.productImage)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: screenRect.width / 3, height: screenRect.width / 3)
            .opacity(0)
        } else {
          Image(product.productImage)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: screenRect.width / 3, height: screenRect.width / 3)
            .matchedGeometryEffect(id: "\(product.id)SEARCH", in: animation)
        }
      }
      .offset(y: -80)
      .padding(.bottom, -80)

      Text(product.title)
        .font(.system(size: 18))
        .fontWeight(.semibold)
        .padding(.top)

      Text(product.subtitle)
        .font(.system(size: 14))

      Text(product.price)
        .font(.system(size: 16))
        .fontWeight(.semibold)
        .foregroundColor(Color(uiColor: .systemIndigo))
        .padding(.top, 5)
    }
    .padding(.horizontal, 20)
    .padding(.bottom, 22)
    .background(
      Color.white
        .cornerRadius(25)
    )
    .onTapGesture {
      withAnimation(.easeInOut) {
        sharedDataViewModel.fromSearchPage = true
        sharedDataViewModel.detailProduct = product
        sharedDataViewModel.showDetailProduct = true
      }
    }
  }
}

struct SearchView_Previews: PreviewProvider {
  static var previews: some View {
    MainPageView()
  }
}
