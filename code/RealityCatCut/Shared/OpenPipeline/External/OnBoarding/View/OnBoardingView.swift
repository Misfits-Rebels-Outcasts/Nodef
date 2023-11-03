//
//  OnBoardingView.swift
//  OnBoardingViewSwiftUI
//
//  Created by Krupanshu Sharma on 06/02/23.
//

import SwiftUI

struct OnBoardingView: View {
    // MARK: - PROPERTIES
    
    var fruits: [Fruit] = fruitsData

    // MARK: - BODY
    
    var body: some View {
      TabView {
        ForEach(fruits[0...3]) { item in
          FruitCardView(fruit: item)
        } //: LOOP
      } //: TAB
      .tabViewStyle(PageTabViewStyle())
      .padding(.vertical, 20)
    }

}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
