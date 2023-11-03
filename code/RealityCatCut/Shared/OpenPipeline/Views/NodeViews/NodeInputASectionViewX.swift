//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI


@available(iOS 15.0, *)
struct NodeInputASectionViewX: View {
    
    @ObservedObject var filterPropertiesViewModel: FilterPropertiesViewModel
    @ObservedObject var filtersPropertiesViewModel: FiltersPropertiesViewModel
        
    var body: some View {
                
        Section(header: Text("Input A"), footer: Text("Select a Step to use as Input A, the source. The preceding Step is used by default."))
        {
            NavigationLink
            {
                NodeSelectionViewX(nodeType:"inputA",
                                   numNodes: filterPropertiesViewModel.filterXHolder.filter.nodeIndex,
                                   filterPropertiesViewModel: filterPropertiesViewModel,
                                   filtersPropertiesViewModel: filtersPropertiesViewModel)
           
            } label: {
                HStack{
                    Text("Step")
                    Spacer()
                    if filterPropertiesViewModel.filterXHolder.filter.inputAAlias == ""{
                        Text("Preceding").foregroundColor(Color.gray)
                    }
                    else{
                        Text("Step "+filterPropertiesViewModel.filterXHolder.filter.inputAAlias).foregroundColor(Color.gray)
                    }
                    
                }
            }
            HStack{
                Text("Step Number")
                Spacer()
                if filterPropertiesViewModel.filterXHolder.filter.inputAAlias == ""{
                    Text(String(filterPropertiesViewModel.filterXHolder.filter.nodeIndex-1))
                }
                else{
                    Text(filterPropertiesViewModel.filterXHolder.filter.inputAAlias)
                }
            }
        }
    }
}


