//
//  FruitModel.swift
//  OnBoardingViewSwiftUI
//
//  Created by Krupanshu Sharma on 06/02/23.
//

import Foundation
import SwiftUI

// MARK: - FRUITS DATA MODEL

struct Fruit: Identifiable {
  var id = UUID()
  var title: String
  var headline: String
  var image: String
  var gradientColors: [Color]
}
