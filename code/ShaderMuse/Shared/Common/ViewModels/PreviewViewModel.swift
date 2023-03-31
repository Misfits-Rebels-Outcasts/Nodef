//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class DataCounterModel
{
    var labelCounter: Int = 0 
}

class PreviewViewModel: BaseViewModel {

    //@Published var numLabels: String = "1"
    @Published var startLabel: String = "1"
    @Published var numPages: String = "1"
    @Published var numLabels: String = "1"
    @Published var orientation: String = "Landscape"
    
    
    //@Published var inumLabels : Int = 1
    @Published var istartLabel : Int = 1
    @Published var inumPages : Int = 1
    @Published var inumLabels : Int = 1
    @Published var scaleFactor : Double = 0.11
    @Published var printBorder : Bool = true

    @Published var pagestartLabel : Int = 1
    @Published var barcodeFidelity : String = "Standard"

    var triggerNumLabels:Bool = true
    var triggerNumPages:Bool = true
    var triggerStartLabel:Bool = true

    init(dpi : Double, pageType: String, numLabelsInPage: Int)
    {
        super.init()
        let dpiFactor = 300.0/dpi
        scaleFactor = pageType == "envelope-landscape" ? 0.05 : 0.11
        scaleFactor = scaleFactor*dpiFactor
        
        inumLabels = numLabelsInPage
        numLabels = String(inumLabels)
    }
}

