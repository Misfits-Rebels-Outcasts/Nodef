//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class BackgroundFiltersPropertiesViewModel: FiltersPropertiesViewModel {

    let pageSettings: PageSettings
    init(pageSettings: PageSettings) {
       self.pageSettings = pageSettings
    }
    
    func setupSelectedProperties()
    {
        self.filters = pageSettings.filters
    }
    
    override func setupReadImage(fx: FilterX) {
        pageSettings.readFX=(fx as! ReadImageFX)
    }
    
    override func applyFiltersAsync() async{
        await pageSettings.applyFiltersAsync()
    }

    
    override func applyFilters()
    {
        pageSettings.applyFilters()
    }
    
    //this is deprecated in ANCHISES
    //but the ImageFilters one is still kept for label
    override func createFilter(selectedFilter: String)->FilterXHolder {
        print("createFilter",selectedFilter)

        let filterXHolder=filters.getFilterWithHolder(selectedFilter)
        
        //takeoutmiximagesize
        filterXHolder.filter.size=CGSize(width: pageSettings.backgroundImage!.size.width,height: pageSettings.backgroundImage!.size.height)
        
        return filterXHolder
    }

    
}
