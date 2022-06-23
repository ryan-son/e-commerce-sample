//
//  HomeView.swift
//  ECommnerceSample
//
//  Created by Geonhee on 2022/06/19.
//

import SwiftUI

struct HomeView: View {
  @EnvironmentObject var sharedDataViewModel: SharedDataViewModel
  @StateObject var viewModel: HomeViewModel = HomeViewModel()
  var animation: Namespace.ID

  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      VStack(spacing: 15) {
        ZStack {
          if viewModel.searchActivated {
            searchBar()
          } else {
            searchBar()
              .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
          }
        }
        .frame(width: screenRect.width / 1.6)
        .contentShape(Rectangle())
        .onTapGesture {
          withAnimation(.easeInOut) {
            viewModel.searchActivated = true
          }
        }
        
        Text("Order online\ncollect in store")
          .font(.system(size: 28))
          .fontWeight(.bold)
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.top)
          .padding(.horizontal, 25)
        
        ScrollView(.horizontal, showsIndicators: false) {
          HStack(spacing: 18) {
            ForEach(ProductType.allCases, id: \.self) { type in
              productTypeView(type: type)
            }
          }
          .padding(.horizontal, 25)
        }
        .padding(.top, 28)

        ScrollView(.horizontal, showsIndicators: false) {
          HStack(spacing: 25) {
            ForEach(viewModel.filteredProducts) { product in
              productCardView(product: product)
            }
          }
          .padding(.horizontal, 25)
          .padding(.bottom)
          .padding(.top, 80)
        }
        .padding(.top, 30)

        Button(action: { viewModel.showMoreProductsOnType.toggle() }) {
          Label(
            title: {
              Text("see more")
            },
            icon: {
              Image(systemName: "arrow.right")
            }
          )
          .frame(maxWidth: .infinity, alignment: .trailing)
          .padding(.trailing)
          .padding(.top, 10)
          .font(.system(size: 15).bold())
          .foregroundColor(Color(uiColor: .systemIndigo))
        }
      }
      .padding(.vertical)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color(uiColor: .systemGray5))
    .onChange(of: viewModel.productType) { _ in
      viewModel.filterProductByType()
    }
    .sheet(isPresented: $viewModel.showMoreProductsOnType) {
      MoreProductsView()
    }
    .overlay(
      ZStack {
        if viewModel.searchActivated {
          SearchView(animation: animation)
            .environmentObject(viewModel)
        }
      }
    )
  }
  
  @ViewBuilder
  func productTypeView(type: ProductType) -> some View {
    Button(action: {
      withAnimation {
        viewModel.productType = type
      }
    }) {
      Text(type.rawValue)
        .font(.system(size: 15))
        .fontWeight(.semibold)
        .foregroundColor(viewModel.productType == type ? Color(uiColor: .systemIndigo) : Color.gray)
        .padding(.bottom, 10)
        .overlay(
          ZStack {
            if viewModel.productType == type {
              Capsule()
                .fill(Color(uiColor: .systemIndigo))
                .matchedGeometryEffect(id: "PRODUCTTAB", in: animation)
                .frame(height: 2)
            } else {
              Capsule()
                .fill(Color.clear)
                .frame(height: 2)
            }
          }
            .padding(.horizontal, -5)
          ,
          alignment: .bottom
        )
    }
  }
  
  @ViewBuilder
  func productCardView(product: Product) -> some View {
    VStack(spacing: 10) {
//      Image(product.productImage)
//        .resizable()
//        .aspectRatio(contentMode: .fit)
      ZStack {
        if sharedDataViewModel.showDetailProduct {
          Image(product.productImage)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .opacity(0)
        } else {
          Image(product.productImage)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .matchedGeometryEffect(id: "\(product.id)IMAGE", in: animation)
        }
      }
        .frame(width: screenRect.width / 2.5, height: screenRect.width / 2.5)
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
        sharedDataViewModel.detailProduct = product
        sharedDataViewModel.showDetailProduct = true
      }
    }
  }
  
  @ViewBuilder
  func searchBar() -> some View {
    HStack(spacing: 15) {
      Image(systemName: "magnifyingglass")
        .font(.title2)
        .foregroundColor(.gray)

      TextField("Search", text: .constant(""))
        .disabled(true)
    }
    .padding(.vertical, 12)
    .padding(.horizontal)
    .background(
      Capsule()
        .strokeBorder(Color.gray, lineWidth: 0.8)
    )
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    MainPageView()
  }
}

