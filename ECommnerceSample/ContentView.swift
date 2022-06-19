//
//  ContentView.swift
//  ECommnerceSample
//
//  Created by Geonhee on 2022/06/19.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    OnboardingPageView()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

extension View {
  var screenRect: CGRect {
    return UIScreen.main.bounds
  }
}
