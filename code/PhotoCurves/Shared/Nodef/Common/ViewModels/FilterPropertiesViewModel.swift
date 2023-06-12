//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class FilterPropertiesViewModel : BaseViewModel {

    @Published var filterXHolder:FilterXHolder = FilterXHolder()
    @Published var selectedFilterType:String = ""
    
    
    init(filterXHolder: FilterXHolder) {
        self.filterXHolder = filterXHolder
        self.selectedFilterType=filterXHolder.filter.getDisplayName()
    }
    
}
