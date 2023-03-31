//
//  Copyright © 2022 James Boo. All rights reserved.
//


import Foundation
import SwiftUI

class FilterSettings: ObservableObject, Identifiable, Equatable {
    static func == (lhs: FilterSettings, rhs: FilterSettings) -> Bool {
        return lhs.id==rhs.id
    }
    
    var id = UUID()
    
    @Published var blurRadius: Double = 7
    @Published var cartoonblurRadius: Double = 10
    @Published var showCartoon = false
    @Published var contrastVal: Double = 100
    @Published var brightnessVal: Double = 0
    @Published var saturationVal: Double = 100
    

    //more variables
    @Published var blurAngle: Double = 30
    @Published var blurType: Double = 0  //0- gaussian, 1 - motion , 2 - disc
    @Published var blurTypeStr = "Direction"
    @Published var pblurTypeStr = "Direction"
    //@State private var satBoost: Double = 2.0
    @Published var satBoost: Double = 1.0
    @Published var hueAngle: Double = 0
    @Published var original = true
    
    
    init(_ blurRadius: Double, _ cartoonblurRadius: Double, _ showCartoon: Bool, _ contrastVal: Double, _ brightnessVal: Double,_ saturationVal: Double) {
        self.blurRadius=blurRadius
        self.cartoonblurRadius=cartoonblurRadius
        self.showCartoon=showCartoon
        self.contrastVal = contrastVal
        self.brightnessVal = brightnessVal
        self.saturationVal = saturationVal
        self.original = true
    }
}
