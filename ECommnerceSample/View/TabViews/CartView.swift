//
//  CartView.swift
//  ECommnerceSample
//
//  Created by Geonhee on 2022/06/20.
//

import SwiftUI

struct CartView: View {
  @EnvironmentObject var sharedDataViewModel: SharedDataViewModel
  
  @State var showDeleteOption: Bool = false
  
  var body: some View {
    NavigationView {
      VStack(spacing: 10) {
        ScrollView(.vertical, showsIndicators: false) {
          VStack {
            HStack {
              Text("Basket")
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
              .opacity(sharedDataViewModel.cartProducts.isEmpty ? 0 : 1)
            }
            
            if sharedDataViewModel.cartProducts.isEmpty {
              Group {
                Image(systemName: "suitcase.cart")
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                  .frame(width: 100, height: 100)
                  .padding()
                  .padding(.top, 35)
                
                Text("No Items added")
                  .font(.system(size: 25))
                  .fontWeight(.semibold)
                
                Text("Hit the plus button to save into basket.")
                  .font(.system(size: 18))
                  .foregroundColor(.gray)
                  .padding(.horizontal)
                  .padding(.top, 10)
              }
            } else {
              VStack(spacing: 15) {
                ForEach($sharedDataViewModel.cartProducts) { $product in
                  HStack(spacing: 0) {
                    if showDeleteOption {
                      Button(action: { deleteProduct(product: product) }) {
                        Image(systemName: "minus.circle.fill")
                          .font(.title2)
                          .foregroundColor(.red)
                      }
                      .padding(.trailing)
                    }
                    CardView(product: $product)
                  }
                }
              }
              .padding(.top, 25)
              .padding(.horizontal)
            }
          }
          .padding()
        }
        
        
        if !sharedDataViewModel.cartProducts.isEmpty {
          Group {
            HStack {
              Text("Total")
                .font(.system(size: 14))
                .fontWeight(.semibold)
              
              Spacer()
              Text(sharedDataViewModel.totalPrice())
                .font(.system(size: 18))
                .foregroundColor(Color(uiColor: .systemIndigo))
            }
            
            Button(action: {}) {
              Text("Checkout")
                .font(.system(size: 18))
                .foregroundColor(.white)
                .padding(.vertical, 18)
                .frame(maxWidth: .infinity)
                .background(Color(uiColor: .systemIndigo))
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 5, y: 5)
            }
            .padding(.vertical)
          }
          .padding(.horizontal, 25)
        }
      }
      .navigationBarHidden(true)
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(
        Color(uiColor: .systemGray5).ignoresSafeArea()
      )
    }
  }
  
  func deleteProduct(product: Product) {
    if let index = sharedDataViewModel.cartProducts.firstIndex(where: { $0.id == product.id }) {
      _ = withAnimation {
        sharedDataViewModel.cartProducts.remove(at: index)
      }
    }
  }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
        .environmentObject(SharedDataViewModel())
    }
}

struct CardView: View {
  @Binding var product: Product
  
  var body: some View {
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
        
        HStack(spacing: 10) {
          Text("Quantity: ")
            .font(.system(size: 14))
            .foregroundColor(.gray)
          
          Button(action: {
            product.quantity = (product.quantity > 0 ? (product.quantity - 1) : 0)
          }) {
            Image(systemName: "minus")
              .font(.caption)
              .foregroundColor(.white)
              .frame(width: 20, height: 20)
              .background(Color(uiColor: .systemPink))
              .cornerRadius(4)
          }
          
          Text("\(product.quantity)")
            .font(.system(size: 14))
            .fontWeight(.semibold)
            .foregroundColor(.black)
          
          Button(action: {
            product.quantity += 1
          }) {
            Image(systemName: "plus")
              .font(.caption)
              .foregroundColor(.white)
              .frame(width: 20, height: 20)
              .background(Color(uiColor: .systemGreen))
              .cornerRadius(4)
          }
        }
        
      }
    }
    .padding(10)
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(
      Color.white
        .cornerRadius(10)
    )
  }
}

