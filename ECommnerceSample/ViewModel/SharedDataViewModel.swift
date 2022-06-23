//
//  SharedDataViewModel.swift
//  ECommnerceSample
//
//  Created by Geonhee on 2022/06/20.
//

import SwiftUI

class SharedDataViewModel: ObservableObject {
  @Published var detailProduct: Product?
  @Published var showDetailProduct: Bool = false

  @Published var fromSearchPage: Bool = false

  @Published var likedProducts: [Product] = []
  @Published var cartProducts: [Product] = []

  func totalPrice() -> String {
    var totalPrice: Int = 0

    cartProducts.forEach { product in
      let price = product.price.replacingOccurrences(of: "$", with: "") as NSString
      let quantity = product.quantity
      let subtotal = quantity * price.integerValue
      totalPrice += subtotal
    }

    return "$\(totalPrice)"
  }
}
