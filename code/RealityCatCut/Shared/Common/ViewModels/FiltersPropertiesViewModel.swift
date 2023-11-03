//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class FiltersPropertiesViewModel: ObservableObject {
    
    @Published var filters:FiltersX = FiltersX()
    @Published var selectedShaderType:String = "Fractal Flow Noise"
    @Published var selectedFilterType:String = "Zoom Blur"//"Color Monochrome"
    @Published var selectedBlendFilterType:String = "Color Dodge Blend Mode"
    @Published var selectedARType:String = "Sphere"
    @Published var size=CGSize(width: 320, height: 180)
    
    func applyFilters() {
    }
    
    func applyFiltersAsync() async{
    }
    
    func setupReadImage(fx: FilterX) {
        
    }
    //ANCHISES deprecated
    func createFilter(selectedFilter: String)->FilterXHolder {
        return filters.getFilterWithHolder("Color Controls")
    }
    
    func isFirstNode(filterNodeHolder: FilterXHolder)->Bool {
        
        if filters.filterList.count > 0 &&
            filters.filterList[0].filter.id == filterNodeHolder.filter.id {
                return true
        }
        return false
    }
}
