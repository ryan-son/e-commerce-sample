//
//  LikedView.swift
//  ECommnerceSample
//
//  Created by Geonhee on 2022/06/20.
//

import SwiftUI


struct LikedView: View {
  @EnvironmentObject var sharedDataViewModel: SharedDataViewModel

  @State var showDeleteOption: Bool = false

  var body: some View {
    NavigationView {
      ScrollView(.vertical, showsIndicators: false) {
        VStack {
          HStack {
            Text("Favourites")
              .font(.system(size: 28).bold())

            Spacer()

            Button(action: {
              withAnimation {
                showDeleteOption.toggle()
              }
            }) {
              Image(systemName: "trash")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
                .foregroundColor(.red)
            }
            .opacity(sharedDataViewModel.likedProducts.isEmpty ? 0 : 1)
          }
          
          if sharedDataViewModel.likedProducts.isEmpty {
            Group {
              Image(systemName: "heart.slash")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .padding()
                .padding(.top, 35)

              Text("No favourites yet")
                .font(.system(size: 25))
                .fontWeight(.semibold)

              Text("Hit the like button on each product page to save favourite ones.")
                .font(.system(size: 18))
                .foregroundColor(.gray)
                .padding(.horizontal)
                .padding(.top, 10)
            }
          } else {
            VStack(spacing: 15) {
              ForEach(sharedDataViewModel.likedProducts) { product in
                HStack(spacing: 0) {
                  if showDeleteOption {
                    Button(action: { deleteProduct(product: product) }) {
                      Image(systemName: "minus.circle.fill")
                        .font(.title2)
                        .foregroundColor(.red)
                    }
                    .padding(.trailing)
                  }
                  cardView(product: product)
                }
              }
            }
            .padding(.top, 25)
            .padding(.horizontal)
          }
        }
        .padding()
      }
      .navigationBarHidden(true)
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(
        Color(uiColor: .systemGray5).ignoresSafeArea()
      )
    }
  }
  
  @ViewBuilder
  func cardView(product: Product) -> some View {
    HStack(spacing: 15) {
      Image(product.productImage)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 100, height: 100)

      VStack(alignment: .leading, spacing: 8) {
        Text(product.title)
          .font(.system(size: 18).bold())
          .lineLimit(1)

        Text(product.subtitle)
          .font(.system(size: 17))
          .fontWeight(.semibold)
          .foregroundColor(Color(uiColor: .systemIndigo))

        Text("Type: \(product.type.rawValue)")
          .font(.system(size: 13))
          .foregroundColor(.gray)        
      }
    }
    .padding(10)
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(
      Color.white
        .cornerRadius(10)
    )
  }
  
  func deleteProduct(product: Product) {
    if let index = sharedDataViewModel.likedProducts.firstIndex(where: { $0.id == product.id }) {
      _ = withAnimation {
        sharedDataViewModel.likedProducts.remove(at: index)
      }
    }
  }
}
struct LikedView_Previews: PreviewProvider {
  static var previews: some View {
    LikedView()
      .environmentObject(SharedDataViewModel())
      .environmentObject(HomeViewModel())
  }
}
