//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI
@available(iOS 15.0, *)
struct DisplacementDistortionPropertiesViewX: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var pageSettings: PageSettings
  
    
    @ObservedObject var fx: DisplacementDistortionFX = DisplacementDistortionFX()
    @ObservedObject var filterPropertiesViewModel: FilterPropertiesViewModel
    var parent: FilterPropertiesViewX

    var body: some View {
        
        Section(header: Text("Options")){
                  
            HStack{
                Text("Scale")
                Spacer()
                Text(String(format: "%.2f", fx.scale))
            }

            Slider(value: $fx.scale, in: 0...200, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.scale) { newValue in
                    applyFilter()
                }
                   
        }
        
        Section(header: Text("Input Image Node"), footer: Text("Select a Node to use as the Input Image. The preceding Node is used by default."))
        {
            NavigationLink
            {
                NodeSelectionViewX(nodeType:"input", numNodes: fx.nodeIndex,
                                   filterPropertiesViewModel: filterPropertiesViewModel)
                    .environmentObject(pageSettings)
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

        //revisit set the input image here with a original image tip
        Section(header: Text("Shaded Image Node"), footer: Text("Select a Node to use as the Input Mask Image. The preceding Node is used by default."))
        {
            NavigationLink
            {
                NodeSelectionViewX(nodeType:"DisplacementDistortionFX", numNodes: filterPropertiesViewModel.filterXHolder.filter.nodeIndex,
                                   filterPropertiesViewModel: filterPropertiesViewModel)
                    .environmentObject(pageSettings)
            } label: {
                HStack{
                    Text("Node")
                    Spacer()
                    //displacement change type to others causes issue without this line
                    if (filterPropertiesViewModel.filterXHolder.filter is DisplacementDistortionFX)
                    {
                        if (filterPropertiesViewModel.filterXHolder.filter as! DisplacementDistortionFX).inputDisplacementImageAlias == ""{
                            Text("Preceding").foregroundColor(Color.gray)
                        }
                        else{
                            Text("Node "+(filterPropertiesViewModel.filterXHolder.filter as! DisplacementDistortionFX).inputDisplacementImageAlias).foregroundColor(Color.gray)
                        }
                    }
                    
                }
            }
            HStack{
                Text("Node Number")
                Spacer()
                if (filterPropertiesViewModel.filterXHolder.filter is DisplacementDistortionFX)
                {
                    if (filterPropertiesViewModel.filterXHolder.filter as! DisplacementDistortionFX).inputDisplacementImageAlias == ""{
                        Text(String((filterPropertiesViewModel.filterXHolder.filter as! DisplacementDistortionFX).nodeIndex-1))
                    }
                    else{
                        Text( (filterPropertiesViewModel.filterXHolder.filter as! DisplacementDistortionFX).inputDisplacementImageAlias)
                    }
                }
            }
             
        }
        .onAppear(perform: setupViewModel)
 
        //Section(header: Text(""), footer: Text("")){
        //}
    }
    
    func applyFilter(_ editing: Bool) {
        print(editing,appSettings.imageRes)
        if editing == true
        {
            //if appSettings.imageRes == "Standard Resolution"
            //{
                //parent.applyFilter()
            //}
        }
        else{
            parent.applyFilter()
        }
    }
    
    func applyFilter() {
        if appSettings.imageRes == "Standard Resolution"
        {
            parent.applyFilter()
        }
    }
    
    func setupViewModel()
    {
        //colorControlsFX.brightness=

    }
}

