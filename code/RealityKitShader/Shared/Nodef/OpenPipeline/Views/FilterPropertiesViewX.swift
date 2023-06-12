//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

//Open Photo Effects
//Photo Filters & Animation

@available(iOS 15.0, *)
struct FilterPropertiesViewX: View {
    
    @ObservedObject var pageSettings: PageSettings
    
    var body: some View {
        
        Form{

             Text("Node Number")

        }
    }
    
    func setupViewModel()
    {

    }
    
    func readImage(fx: FilterX) {

    }
    
    func applyFilter() {
        //pageSettings.applyFilters()

        
    }

}


