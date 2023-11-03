//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI


@available(iOS 15.0, *)
struct NodeInputBSectionViewX: View {
    
    @ObservedObject var filterPropertiesViewModel: FilterPropertiesViewModel
    @ObservedObject var filtersPropertiesViewModel: FiltersPropertiesViewModel
        
    var body: some View {
                
        Section(header: Text("Input B"), footer: Text("Select a Step to use as Input B."))
        {
            NavigationLink
            {
                NodeSelectionViewX(nodeType:"inputB",
                                   numNodes: filterPropertiesViewModel.filterXHolder.filter.nodeIndex,
                                   filterPropertiesViewModel: filterPropertiesViewModel,
                                   filtersPropertiesViewModel: filtersPropertiesViewModel)
           
            } label: {
                HStack{
                    Text("Step")
                    Spacer()
                    if filterPropertiesViewModel.filterXHolder.filter.inputBAlias == ""{
                        Text("Preceding").foregroundColor(Color.gray)
                    }
                    else{
                        Text("Step "+filterPropertiesViewModel.filterXHolder.filter.inputBAlias).foregroundColor(Color.gray)
                    }
                    
                }
            }
            HStack{
                Text("Step Number")
                Spacer()
                if filterPropertiesViewModel.filterXHolder.filter.inputBAlias == ""{
                    Text(String(filterPropertiesViewModel.filterXHolder.filter.nodeIndex-1))
                }
                else{
                    Text(filterPropertiesViewModel.filterXHolder.filter.inputBAlias)
                }
            }
        }
    }
}


