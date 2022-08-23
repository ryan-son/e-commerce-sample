//
//  ProductDetailView.swift
//  ECommnerceSample
//
//  Created by Geonhee on 2022/06/20.
//

import SwiftUI

struct ProductDetailView: View {
  var product: Product

  var animation: Namespace.ID

  @EnvironmentObject var sharedDataViewModel: SharedDataViewModel
  @EnvironmentObject var homeViewModel: HomeViewModel

  var body: some View {
    VStack {
      VStack {
        HStack {
          Button(action: {
            withAnimation(.easeInOut) {
              sharedDataViewModel.showDetailProduct = false
            }
          }) {
            Image(systemName: "arrow.left")
              .font(.title2)
              .foregroundColor(Color.black.opacity(0.7))
          }

          Spacer()

          Button(action: { addToLiked() }) {
            Image(systemName: "heart.fill")
              .renderingMode(.template)
              .resizable()
              .aspectRatio(contentMode: .fit)
              .frame(width: 22, height: 22)
              .foregroundColor(
                isLiked() ?
                  .red :
                  Color.black.opacity(0.7)
              )
          }
        }
        .padding()

        Image(product.productImage)
          .resizable()
          .aspectRatio(contentMode: .fit)
          .matchedGeometryEffect(
            id: "\(product.id)\(sharedDataViewModel.fromSearchPage ? "SEARCH" : "IMAGE")",
            in: animation
          )
          .padding(.horizontal)
          .offset(y: -12)
          .frame(maxHeight: .infinity)
      }
      .frame(height: screenRect.height / 2.7)
      .zIndex(1)
      
      ScrollView(.vertical, showsIndicators: false) {
        VStack(alignment: .leading, spacing: 15) {
          Text(product.title)
            .font(.system(size: 20))
            .fontWeight(.bold)

          Text(product.subtitle)
            .font(.system(size: 18))
            .fontWeight(.bold)
            .foregroundColor(.gray)

          Text("Get Apple TV+ free for a year")
            .font(.system(size: 16))
            .fontWeight(.bold)
            .padding(.top)

          Text("Available when you purchase any new iPhone, iPad, iPod Touch, Mac or Apple TV, ₩5,000 month after free trial.")
            .font(.system(size: 15))
            .foregroundColor(.gray)

          Button(action: {}) {
            Label(
              title: {
                Image(systemName: "arrow.right")
              },
              icon: {
                Text("Full description")
              }
            )
            .font(.system(size: 15).bold())
            .foregroundColor(Color(uiColor: .systemIndigo))
          }

          HStack {
            Text("Total")
              .font(.system(size: 17))

            Spacer()

            Text("\(product.price)")
              .font(.system(size: 20).bold())
              .foregroundColor(Color(uiColor: .systemIndigo))
          }
          .padding(.vertical, 20)

          Button(action: { addToCart() }) {
            Text("\(isAddedToCart() ? "added" : "add") to basket")
              .font(.system(size: 20).bold())
              .foregroundColor(.white)
              .padding(.vertical, 20)
              .frame(maxWidth: .infinity)
              .background(
                Color(uiColor: .systemIndigo)
                  .cornerRadius(15)
                  .shadow(color: Color.black.opacity(0.06), radius: 5, x: 5, y: 5)
              )
          }
          
        }
        .padding([.horizontal, .bottom], 20)
        .padding(.top, 20)
        .frame(maxWidth: .infinity, alignment: .leading)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .zIndex(0)
      
      .background(
        Color.white
          .clipShape(CustomCorners(corners: [.topLeft, .topRight], radius: 25))
          .ignoresSafeArea(edges: .bottom)
      )
    }
    .animation(.easeInOut, value: sharedDataViewModel.likedProducts)
    .animation(.easeInOut, value: sharedDataViewModel.cartProducts)
    .background(Color(uiColor: .systemGray5).ignoresSafeArea())
  }

  func isLiked() -> Bool {
    return sharedDataViewModel.likedProducts.contains(where: { $0.id == product.id })
  }

  func isAddedToCart() -> Bool {
    return sharedDataViewModel.cartProducts.contains(where: { $0.id == product.id })
  }

  func addToLiked() {
    if let index = sharedDataViewModel
      .likedProducts
      .firstIndex(where: { $0.id == self.product.id }) {
      sharedDataViewModel.likedProducts.remove(at: index)
    } else {
      sharedDataViewModel.likedProducts.append(product)
    }
  }

  func addToCart() {
    if let index = sharedDataViewModel
      .cartProducts
      .firstIndex(where: { $0.id == self.product.id }) {
      sharedDataViewModel.cartProducts.remove(at: index)
    } else {
      sharedDataViewModel.cartProducts.append(product)
    }
  }
}

struct ProductDetailView_Previews: PreviewProvider {
  static var previews: some View {
//    ProductDetailView(product: HomeViewModel().products[0])
//      .environmentObject(SharedDataViewModel())
    MainPageView()
  }
}
