//
//  ProductType.swift
//  ECommnerceSample
//
//  Created by Geonhee on 2022/06/19.
//

import Foundation

enum ProductType: String, CaseIterable {
  case wearable = "Wearable"
  case laptops = "Laptops"
  case phones = "Phones"
  case tablets = "Tablets"
}

struct Product: Identifiable, Hashable {
  var id = UUID().uuidString
  let type: ProductType
  let title: String
  let subtitle: String
  let price: String
  let productImage: String
  var quantity: Int = 1
}
