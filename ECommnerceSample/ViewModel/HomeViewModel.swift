//
//  HomeViewModel.swift
//  ECommnerceSample
//
//  Created by Geonhee on 2022/06/19.
//

import Combine
import SwiftUI

class HomeViewModel: ObservableObject {
  @Published var productType: ProductType = .wearable
  @Published var products: [Product] = [
    Product(type: .wearable, title: "Apple Watch", subtitle: "Series 5", price: "$259", productImage: "AppleWatch5"),
    Product(type: .wearable, title: "Apple Watch", subtitle: "Series 6", price: "$359", productImage: "AppleWatch6"),
    Product(type: .wearable, title: "Samsung Galaxy Watch", subtitle: "46 mm", price: "$250", productImage: "GalaxyWatch46"),
    Product(type: .tablets, title: "iPad Air", subtitle: "A14", price: "$699", productImage: "ipadair"),
    Product(type: .tablets, title: "iPad Pro", subtitle: "M1", price: "$999", productImage: "ipadpro"),
    Product(type: .phones, title: "iPhone 13", subtitle: "A15", price: "$699", productImage: "iphone13"),
    Product(type: .phones, title: "iPhone 12", subtitle: "A14", price: "$599", productImage: "iphone12"),
    Product(type: .phones, title: "iPhone 11", subtitle: "A13", price: "$499", productImage: "iphone11"),
    Product(type: .phones, title: "iPhone SE2", subtitle: "A13", price: "$399", productImage: "iphonese2"),
    Product(type: .laptops, title: "MacBook Air", subtitle: "M1", price: "$999", productImage: "macbookair"),
    Product(type: .laptops, title: "MacBook Pro", subtitle: "M1", price: "$1299", productImage: "macbookpro"),
  ]
  
  @Published var showMoreProductsOnType: Bool = false

  @Published var filteredProducts: [Product] = []

  @Published var searchText: String = ""
  @Published var searchActivated: Bool = false
  @Published var searchedProducts: [Product]?

  var searchCancellable: AnyCancellable?

  init() {
    filterProductByType()
    
    searchCancellable = $searchText.removeDuplicates()
      .debounce(for: 0.5, scheduler: RunLoop.main)
      .sink(receiveValue: { text in
        guard !text.isEmpty else {
          self.searchedProducts = nil
          return
        }
        self.filterProductBySearch()
      })
  }

  func filterProductByType() {
    DispatchQueue.global(qos: .userInteractive).async {
      let results = self.products
        .lazy
        .filter { product in
          return product.type == self.productType
        }
        .prefix(4)
      
      DispatchQueue.main.async {
        self.filteredProducts = results.compactMap { $0 }
      }
    }
  }

  func filterProductBySearch() {
    DispatchQueue.global(qos: .userInteractive).async {
      let results = self.products
        .lazy
        .filter { product in
          return product.title.lowercased().contains(self.searchText.lowercased())
        }

      DispatchQueue.main.async {
        self.searchedProducts = results.compactMap { $0 }
      }
    }
  }
}
