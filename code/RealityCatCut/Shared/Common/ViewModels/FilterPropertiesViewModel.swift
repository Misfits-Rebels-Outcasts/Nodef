//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class FilterPropertiesViewModel : ObservableObject {

    @Published var filterXHolder:FilterXHolder = FilterXHolder()
    @Published var selectedFilterType:String = ""
    //@Published var selectedFilterTypeBrackets:String = ""

    
    
    init(filterXHolder: FilterXHolder) {
        self.filterXHolder = filterXHolder
        self.selectedFilterType=filterXHolder.filter.getDisplayName()
        /*
        var bracketStr=self.selectedFilterType
        
        if bracketStr == "Read Video" ||
            bracketStr == "Cut Video" ||
            bracketStr == "Join Video" {
                bracketStr=bracketStr+" (VI)"
        }
        if bracketStr == "FBM Noise" ||
            bracketStr == "Fractal Flow Noise" ||
            bracketStr == "Particles" ||
            bracketStr == "Smoke Effects" ||
            bracketStr == "Tortise Shell Voronoi" ||
            bracketStr == "Water Effects" {
                bracketStr=bracketStr+" (SD)"
        }
        
        if bracketStr == "Terrian" ||
            bracketStr == "Waves"  ||
            bracketStr == "Seashore" ||
            bracketStr == "Sphere" ||
            bracketStr == "Text" ||
            bracketStr == "Photo Frame"  ||
            bracketStr == "Box" {
                bracketStr=bracketStr+" (AR)"
        }
   
        self.selectedFilterTypeBrackets=bracketStr
         */
    }
    
}
