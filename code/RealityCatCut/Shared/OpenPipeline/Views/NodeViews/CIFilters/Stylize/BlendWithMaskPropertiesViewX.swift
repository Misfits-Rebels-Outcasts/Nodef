//
//  Copyright © 2022 James Boo. All rights reserved.
//



import SwiftUI


@available(iOS 15.0, *)
struct BlendWithMaskPropertiesViewX: View {


    @ObservedObject var fx: BlendWithMaskFX = BlendWithMaskFX()
    @ObservedObject var filterPropertiesViewModel: FilterPropertiesViewModel
    @ObservedObject var filtersPropertiesViewModel: FiltersPropertiesViewModel

    var parent: FilterPropertiesViewX?
    var body: some View {

        Text("Not In Use")
        //ANCHISES
        /*
        Section(header: Text("Input Image Node"), footer: Text("Select a Node to use as the Input Image. The preceding Node is used by default."))
        {
            NavigationLink
            {
                NodeSelectionViewX(nodeType:"input", numNodes: fx.nodeIndex,
                                   filterPropertiesViewModel: filterPropertiesViewModel,
                                   filtersPropertiesViewModel: filtersPropertiesViewModel)
                    //.environmentObject(pageSettings)
            } label: {
                HStack{
                    Text("Node")
                    Spacer()
                    if fx.inputImageAlias == ""{
                        Text("Preceding").foregroundColor(Color.gray)
                    }
                    else{
                        Text("Node "+fx.inputImageAlias).foregroundColor(Color.gray)
                    }
                    
                }
            }
            HStack{
                Text("Node Number")
                Spacer()
                if fx.inputImageAlias == ""{
                    Text(String(fx.nodeIndex-1))
                }
                else{
                    Text(fx.inputImageAlias)
                }
            }
        }
        Section(header: Text("Background Image Node"), footer: Text("Select a Node to use as the Background Image. The original image is used by default."))
        {
            NavigationLink
            {
                NodeSelectionViewX(nodeType:"background", numNodes: fx.nodeIndex,
                                   filterPropertiesViewModel: filterPropertiesViewModel,
                                   filtersPropertiesViewModel: filtersPropertiesViewModel)
                    //.environmentObject(pageSettings)
            } label: {
                HStack{
                    Text("Node")
                    Spacer()
                    if fx.backgroundImageAlias == ""{
                        Text("Preceding").foregroundColor(Color.gray)
                    }
                    else{
                        Text("Node "+fx.backgroundImageAlias).foregroundColor(Color.gray)
                    }
                    
                }
            }
            HStack{
                Text("Node Number")
                Spacer()
                if fx.backgroundImageAlias == ""{
                    Text(String(fx.nodeIndex-1))
                }
                else{
                    Text(fx.backgroundImageAlias)
                }
            }
        }
        
        Section(header: Text("Mask Image Node"), footer: Text("Select a Node to use as the Input Mask Image. The preceding image is used by default."))
        {
            //revisit set the input image here with a original image tip
            NavigationLink
            {
                NodeSelectionViewX(nodeType:"BlendWithMaskFX", numNodes: fx.nodeIndex,
                                   filterPropertiesViewModel: filterPropertiesViewModel,
                                   filtersPropertiesViewModel: filtersPropertiesViewModel)
                    //.environmentObject(pageSettings)
            } label: {
                HStack{
                    Text("Node")
                    Spacer()
                    if fx.inputMaskImageAlias == ""{
                        Text("Preceding").foregroundColor(Color.gray)
                    }
                    else{
                        Text("Node "+fx.inputMaskImageAlias).foregroundColor(Color.gray)
                    }
                    
                }
            }
            HStack{
                Text("Node Number")
                Spacer()
                if fx.inputMaskImageAlias == ""{
                    Text(String(fx.nodeIndex-1))
                }
                else{
                    Text(fx.inputMaskImageAlias)
                }
            }
             
        }

        .onAppear(perform: setupViewModel)
         */
        //Section(header: Text(""), footer: Text("")){
        //}
    }

    
    func setupViewModel()
    {
        //colorControlsFX.brightness=

    }
}

