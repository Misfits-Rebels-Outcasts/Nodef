//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI


@available(iOS 15.0, *)
struct NodeInputCSectionViewX: View {
    
    @ObservedObject var filterPropertiesViewModel: FilterPropertiesViewModel
    @ObservedObject var filtersPropertiesViewModel: FiltersPropertiesViewModel
        
    var body: some View {
                
        Section(header: Text("Input C"), footer: Text("Select a Step to use as Input C."))
        {
            NavigationLink
            {
                NodeSelectionViewX(nodeType:"inputC",
                                   numNodes: filterPropertiesViewModel.filterXHolder.filter.nodeIndex,
                                   filterPropertiesViewModel: filterPropertiesViewModel,
                                   filtersPropertiesViewModel: filtersPropertiesViewModel)
           
            } label: {
                HStack{
                    Text("Step")
                    Spacer()
                    if filterPropertiesViewModel.filterXHolder.filter.inputCAlias == ""{
                        Text("Preceding").foregroundColor(Color.gray)
                    }
                    else{
                        Text("Step "+filterPropertiesViewModel.filterXHolder.filter.inputCAlias).foregroundColor(Color.gray)
                    }
                    
                }
            }
            HStack{
                Text("Step Number")
                Spacer()
                if filterPropertiesViewModel.filterXHolder.filter.inputCAlias == ""{
                    Text(String(filterPropertiesViewModel.filterXHolder.filter.nodeIndex-1))
                }
                else{
                    Text(filterPropertiesViewModel.filterXHolder.filter.inputCAlias)
                }
            }
        }
    }
}


