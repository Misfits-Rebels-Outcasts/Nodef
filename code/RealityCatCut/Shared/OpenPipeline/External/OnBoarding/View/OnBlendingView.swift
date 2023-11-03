//
//  OnBoardingView.swift
//  OnBoardingViewSwiftUI
//
//  Created by Krupanshu Sharma on 06/02/23.
//

import SwiftUI

struct OnBlendingView: View {
    // MARK: - PROPERTIES
    
    var fruits: [Fruit] = fruitsData

    // MARK: - BODY
    
    var body: some View {
      TabView {
        ForEach(fruits[8...12]) { item in
          FruitCardView(fruit: item)
        } //: LOOP
      } //: TAB
      .tabViewStyle(PageTabViewStyle())
      .padding(.vertical, 20)
    }

}


