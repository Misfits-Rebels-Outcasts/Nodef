//
//  StartButtonView.swift
//  OnBoardingViewSwiftUI
//
//  Created by Krupanshu Sharma on 06/02/23.
//

import SwiftUI

struct StartButtonView: View {
    // MARK: - PROPERTIES
    
    @AppStorage("isOnboarding") var isOnboarding: String?
    // MARK: - BODY
    
    var body: some View {
      Button(action: {
          isOnboarding = "None"

      }) {
        HStack(spacing: 8) {
    
          Text("OK")
          
          Image(systemName: "arrow.right.circle")
            .imageScale(.large)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(
          Capsule().strokeBorder(Color.white, lineWidth: 1.25)
        )
      } //: BUTTON
      .accentColor(Color.white)
    }
}

struct StartButtonView_Previews: PreviewProvider {
    static var previews: some View {
        StartButtonView()
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}
