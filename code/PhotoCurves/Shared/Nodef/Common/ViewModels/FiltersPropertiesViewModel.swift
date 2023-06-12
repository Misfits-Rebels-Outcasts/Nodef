//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class FiltersPropertiesViewModel: BaseViewModel {
    
    @Published var filters:FiltersX = FiltersX()
    @Published var selectedShaderType:String = "Fractal Flow Noise"
    @Published var selectedFilterType:String = "Color Monochrome"
    @Published var selectedBlendFilterType:String = "Color Dodge Blend Mode"

}

class ImageFiltersPropertiesViewModel: FiltersPropertiesViewModel {

    var image: UIImage?

    func setupSelectedProperties()
    {
       
    }

}

class BackgroundFiltersPropertiesViewModel: FiltersPropertiesViewModel {

    let pageSettings: PageSettings
    init(pageSettings: PageSettings) {
        //super.init()
       self.pageSettings = pageSettings
    }
    
    
    func setupSelectedProperties()
    {
        self.filters = pageSettings.filters
        
    }
}
