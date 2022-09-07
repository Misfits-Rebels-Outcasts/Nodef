//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI
@available(iOS 15.0, *)
struct GlassDistortionPropertiesViewX: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var pageSettings: PageSettings
  
    
    @ObservedObject var fx: GlassDistortionFX = GlassDistortionFX()
    @ObservedObject var filterPropertiesViewModel: FilterPropertiesViewModel
    var parent: FilterPropertiesViewX

    var body: some View {

        Section(header: Text("Options")){
            HStack{
                Text("Center X")
                Spacer()
                Text(String(format: "%.2f", fx.centerX))
            }
                        
            Slider(value: $fx.centerX, in: 0...Float(fx.size.width), onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.centerX) { newValue in
                    applyFilter()
                }
            HStack{
                Text("Center Y")
                Spacer()
                Text(String(format: "%.2f", fx.centerY))
            }

            Slider(value: $fx.centerY, in: 0...Float(fx.size.height), onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.centerY) { newValue in
                    applyFilter()
            }
            
            HStack{
                Text("Scale")
                Spacer()
                Text(String(format: "%.2f", fx.scale))
            }

            Slider(value: $fx.scale, in: 0...500, onEditingChanged: {editing in
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

        Section(header: Text("Texture Image Node"), footer: Text("Select a Node to use as the Texture Image. The preceding Node is used by default."))
        {
            NavigationLink
            {
                NodeSelectionViewX(nodeType:"GlassDistortionFX", numNodes: filterPropertiesViewModel.filterXHolder.filter.nodeIndex,
                                   filterPropertiesViewModel: filterPropertiesViewModel)
                    .environmentObject(pageSettings)
            } label: {
                HStack{
                    Text("Node")
                    Spacer()
                    if (filterPropertiesViewModel.filterXHolder.filter is GlassDistortionFX)
                    {
                        if (filterPropertiesViewModel.filterXHolder.filter as! GlassDistortionFX).inputTextureAlias == ""{
                            Text("Preceding").foregroundColor(Color.gray)
                        }
                        else{
                            Text("Node "+(filterPropertiesViewModel.filterXHolder.filter as! GlassDistortionFX).inputTextureAlias).foregroundColor(Color.gray)
                        }
                    }
                    
                }
            }
            HStack{
                Text("Node Number")
                Spacer()
                if (filterPropertiesViewModel.filterXHolder.filter is GlassDistortionFX)
                {
                    if (filterPropertiesViewModel.filterXHolder.filter as! GlassDistortionFX).inputTextureAlias == ""{
                        Text(String((filterPropertiesViewModel.filterXHolder.filter as! GlassDistortionFX).nodeIndex-1))
                    }
                    else{
                        Text( (filterPropertiesViewModel.filterXHolder.filter as! GlassDistortionFX).inputTextureAlias)
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
    
    func getColor(newValue: String)->CIColor
    {
        var fxcolor:CIColor = .blue
        if newValue == "black"
        {
            fxcolor=CIColor.black
        }
        else if newValue == "blue"
        {
            fxcolor=CIColor.blue
        }
        else if newValue == "clear"
        {
            fxcolor=CIColor.clear
        }
        else if newValue == "cyan"
        {
            fxcolor=CIColor.cyan
        }
        else if newValue == "gray"
        {
            fxcolor=CIColor.gray
        }
        else if newValue == "green"
        {
            fxcolor=CIColor.green
        }
        else if newValue == "magenta"
        {
            fxcolor=CIColor.magenta
        }
        else if newValue == "red"
        {
            fxcolor=CIColor.red
        }
        else if newValue == "yellow"
        {
            fxcolor=CIColor.yellow
        }
        else if newValue == "white"
        {
            fxcolor=CIColor.white
        }
        
        return fxcolor
    }
    func setupViewModel()
    {
        //colorControlsFX.brightness=

    }
}

