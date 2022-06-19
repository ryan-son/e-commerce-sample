//
//  MoreProductsView.swift
//  ECommnerceSample
//
//  Created by Geonhee on 2022/06/19.
//

import SwiftUI

struct MoreProductsView: View {
  var body: some View {
    VStack {
      Text("More Products")
        .font(.system(size: 24))
        .fontWeight(.bold)
        .foregroundColor(.black)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    .padding()
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    .background(Color(uiColor: .systemGray5))
  }
}

struct MoreProductsView_Previews: PreviewProvider {
  static var previews: some View {
    MoreProductsView()
  }
}
