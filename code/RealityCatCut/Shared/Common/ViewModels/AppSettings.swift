//
//  Copyright © 2022 James Boo. All rights reserved.
//


import Foundation
import SwiftUI

class AppSettings: ObservableObject, Identifiable, Equatable {
    
    static func == (lhs: AppSettings, rhs: AppSettings) -> Bool {
        return lhs.id==rhs.id
    }
    
    var id = UUID()
    
    @Published var dpi: Double = 300.0
    @Published var dpiScale: Double = 300.0/72.0
    @Published var zoomFactor: Double = 1.0
    @Published var units: String = "Inches"
    @Published var imageRes: String = "Low Resolution" //Low Standard High
    @Published var mode: String = "Shader" //Video / Image
    @Published var videoDuration: Float = 5.0 
    @Published var videoFPS: Float = 5.0
    @Published var shaderDownScale: CGFloat = 4.0

    @Published var zoomingOrScrollX: String = "scroll" //zoomIn, zoomOut, scroll
    @Published var zoomingOrScrollY: String = "scroll" //zoomIn, zoomOut, scroll

    @Published var HRulerWidth: Double = 0.38
    @Published var VRulerWidth: Double = 0.38

    @Published var HRulerWidthRegular: Double = 0.4
    @Published var VRulerWidthRegular: Double = 0.4

    @Published var barcodeFidelity : String = "Standard"

    //@Published var preview: Bool = false
    
    
    init(_ dpi: Double, _ zoomFactor: Double) {
        self.dpi=dpi
        self.dpiScale=dpi/72.0
        self.zoomFactor=zoomFactor
    }
    
    init(_ dpi: Double, _ zoomFactor: Double, _ units: String, _ hRulerWidth: Double, _ vRulerWidth: Double) {
        self.dpi=dpi
        self.dpiScale=dpi/72.0
        self.zoomFactor=zoomFactor
        self.units=units
        self.HRulerWidth=hRulerWidth
        self.VRulerWidth=vRulerWidth
        
        self.HRulerWidthRegular=hRulerWidth
        self.VRulerWidthRegular=vRulerWidth

    }

    func resetZoom(_ labelWidthWithoutDPI: Double,_ labelHeightWithoutDPI: Double)
    {
        let hRatio=UIScreen.main.bounds.size.height/(labelWidthWithoutDPI*dpi)
        let wRatio=UIScreen.main.bounds.size.width/(labelHeightWithoutDPI*dpi)
        var smallRatio = hRatio > wRatio ? wRatio*0.8 : hRatio*0.8
        smallRatio = smallRatio < 0.05 ? 0.05 : smallRatio
        smallRatio = smallRatio > 1 ? 1 : smallRatio
        zoomFactor=smallRatio
    }
}

