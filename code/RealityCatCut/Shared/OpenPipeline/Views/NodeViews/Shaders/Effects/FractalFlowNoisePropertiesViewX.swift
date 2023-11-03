//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI
@available(iOS 15.0, *)
struct FractalFlowNoisePropertiesViewX: View, NodeProperties {

    @EnvironmentObject var appSettings: AppSettings

    @ObservedObject var fx: FractalFlowNoiseFX = FractalFlowNoiseFX()
    @ObservedObject var filterPropertiesViewModel: FilterPropertiesViewModel
    @ObservedObject var filtersPropertiesViewModel: FiltersPropertiesViewModel
    var parent: FilterPropertiesViewX?

    var body: some View {

        Section(header: Text("Options")){
            Group {
                HStack{
                    
                    
                    Text("Time Elapsed*")//.foregroundColor(.blue)
                     /*
                      .onTapGesture {
                          print("Tapped!")
                      }
                      Image(systemName: "timer").foregroundColor(.blue)
                    Label("Time Elapsed", systemImage: "timer").foregroundColor(.blue)
                    .onTapGesture {
                        print("Tapped!")
                    }
                      */
                    Spacer()
                    Text(String(format: "%.2f", fx.timeElapsed))
                }
                
                Slider(value: $fx.timeElapsed, in: 0...appSettings.videoDuration, onEditingChanged: {editing in
                    if editing == false{
                        fx.regenerate=true
                        timeElapsedX = Double(fx.timeElapsed)
                        applyFilter(editing)
                    }
                })
                    .onChange(of: fx.timeElapsed) { oldValue, newValue in
                        //print("id",colorControlsFX.id)
                        //applyFilter()
                        //fx.regenerate=true
                        //timeElapsedX = Double(fx.timeElapsed)
                        //parent.applyFilter()
                    }
/*
                HStack{
                    Text("Animation Type")
                    Spacer()
                    Text(String(format: "%.2f", fx.animType))
                }
                
                Slider(value: $fx.animType, in: 4...5, step:1, onEditingChanged: {editing in
                    if editing == false{
                        fx.regenerate=true
                        applyFilter(editing)
                    }
                })
                    .onChange(of: fx.animType) { newValue in
                        //print("id",colorControlsFX.id)
                        //applyFilter()
                        //fx.regenerate=true
                        //parent.applyFilter()
                    }
                
                HStack{
                    Text("Mask Effect")
                    Spacer()
                    Text(String(format: "%.2f", fx.maskEffect))
                }
                
                Slider(value: $fx.maskEffect, in: 0...7, step:1, onEditingChanged: {editing in
                    if editing == false{
                        fx.regenerate=true
                        applyFilter(editing)
                    }
                })
                    .onChange(of: fx.maskEffect) { newValue in
                        //print("id",colorControlsFX.id)
                        //applyFilter()
                        //fx.regenerate=true
                        //parent.applyFilter()
                    }
                
                HStack{
                    Text("Mask Type")
                    Spacer()
                    //Text(String(format: "%.2f", GetType(fx.m_flowMaskType)))
                    Text(GetType(fx.m_flowMaskType))
                }
                
                Slider(value: $fx.m_flowMaskType, in: 0...4, step:1, onEditingChanged: {editing in
                    if editing == false{
                        fx.regenerate=true
                        applyFilter(editing)
                    }
                })
                    .onChange(of: fx.m_flowMaskType) { newValue in
                        //print("id",colorControlsFX.id)
                        //applyFilter()
                        //fx.regenerate=true
                        //parent.applyFilter()
                    }
*/
                HStack{
                    Text("Mip Map Type")
                    Spacer()
                    Text(String(format: "%.2f", fx.param_mipmaptype))
                }
                
                Slider(value: $fx.param_mipmaptype, in: 0...3, step:1, onEditingChanged: {editing in
                    if editing == false{
                        fx.regenerate=true
                        applyFilter(editing)
                    }
                })
                    .onChange(of: fx.param_mipmaptype) { oldValue, newValue in
                        //print("id",colorControlsFX.id)
                        //applyFilter()
                        //fx.regenerate=true
                        //parent.applyFilter()
                    }
            }
            /*
            HStack{
                Text("Blend")
                Spacer()
                Text(String(format: "%.2f", fx.m_flowBlend))
            }
            
            Slider(value: $fx.m_flowBlend, in: 0...3, step:1, onEditingChanged: {editing in
                if editing == false{
                    fx.regenerate=true
                    applyFilter(editing)
                }
            })
                .onChange(of: fx.m_flowBlend) { newValue in
                    //print("id",colorControlsFX.id)
                    //applyFilter()
                    //fx.regenerate=true
                    //parent.applyFilter()
                }
             */
            Group {
                  
                Toggle("Use Image Color", isOn: $fx.indexOriginalImageColor)
                    .onChange(of: fx.indexOriginalImageColor)
                    { oldValue, newValue in
                        if newValue == false{
                            fx.animType=5
                        }
                        else {
                            fx.animType=4
                        }
                        fx.regenerate=true
                        applyFilter(false)
                    }
                                
            }
            
            Group {
                HStack{
                    Text("Color")
                    Spacer()
                    ColorPicker("", selection: $fx.colorx, supportsOpacity: true)
                      .onChange(of: fx.colorx) { oldValue, newValue in
#if targetEnvironment(macCatalyst)
                      fx.color=CIColor(cgColor: newValue.cgColor!)
#else
                      fx.color=CIColor(color: UIColor(newValue))
#endif
                          applyFilter()
                      }.frame(width:100, height:30, alignment: .trailing)
                }

                HStack{
                    Text("Direction")
                    Spacer()
                    Text(String(format: "%.2f", fx.param_direction_deg))
                }
                
                Slider(value: $fx.param_direction_deg, in: -180...180, onEditingChanged: {editing in
                    if editing == false{
                        fx.regenerate=true
                        applyFilter(editing)
                    }
                })
                    .onChange(of: fx.param_direction_deg) { oldValue, newValue in
                        //print("id",colorControlsFX.id)
                        //applyFilter()
                        //fx.regenerate=true
                        //parent.applyFilter()
                    }
                
                HStack{
                    Text("Exponent")
                    Spacer()
                    Text(String(format: "%.2f", fx.param_expon))
                }
                
                Slider(value: $fx.param_expon, in: 0.2...1.6, onEditingChanged: {editing in
                    if editing == false{
                        fx.regenerate=true
                        applyFilter(editing)
                    }
                })
                    .onChange(of: fx.param_expon) { oldValue, newValue in
                        //print("id",colorControlsFX.id)
                        //applyFilter()
                        //fx.regenerate=true
                        //parent.applyFilter()
                    }
                
                HStack{
                    Text("Strength")
                    Spacer()
                    Text(String(format: "%.2f", fx.param_strength))
                }
                
                Slider(value: $fx.param_strength, in: 0...1.0, onEditingChanged: {editing in
                    if editing == false{
                        fx.regenerate=true
                        applyFilter(editing)
                    }
                })
                    .onChange(of: fx.param_strength) { oldValue, newValue in
                        //print("id",colorControlsFX.id)
                        //applyFilter()
                        //fx.regenerate=true
                        //parent.applyFilter()
                    }
            }
            
            Group {
                HStack{
                    Text("Gyration Magnitude")
                    Spacer()
                    Text(String(format: "%.2f", fx.param_layerscale))
                }
                
                Slider(value: $fx.param_layerscale, in: 0.05...1.0, onEditingChanged: {editing in
                    if editing == false{
                        fx.regenerate=true
                        applyFilter(editing)
                    }
                })
                    .onChange(of: fx.param_layerscale) { oldValue, newValue in
                        //print("id",colorControlsFX.id)
                        //applyFilter()
                        //fx.regenerate=true
                        //parent.applyFilter()
                    }
                
                HStack{
                    Text("Gyration Speed")
                    Spacer()
                    Text(String(format: "%.2f", fx.param_layervelocity))
                }
                
                Slider(value: $fx.param_layervelocity, in: -0.5...0.5, onEditingChanged: {editing in
                    if editing == false{
                        fx.regenerate=true
                        applyFilter(editing)
                    }
                })
                    .onChange(of: fx.param_layervelocity) { oldValue, newValue in
                        //print("id",colorControlsFX.id)
                        //applyFilter()
                        //fx.regenerate=true
                        //parent.applyFilter()
                    }
                
                HStack{
                    Text("Zoom Type")
                    Spacer()
                    Text(String(format: "%.2f", fx.param_sampletype))
                }
                
                Slider(value: $fx.param_sampletype, in: 0...2.0, step:1, onEditingChanged: {editing in
                    if editing == false{
                        fx.regenerate=true
                        applyFilter(editing)
                    }
                })
                    .onChange(of: fx.param_sampletype) { oldValue, newValue in
                        //print("id",colorControlsFX.id)
                        //applyFilter()
                        //fx.regenerate=true
                        //parent.applyFilter()
                    }
            }
            
        }
        /*
        Section(header: Text("Input Image Node"), footer: Text("Select a Node to use as the Input Image. The preceding Node is used by default."))
        {
            NavigationLink
            {
                NodeSelectionViewX(nodeType:"input", numNodes: fx.nodeIndex,
                                   filterPropertiesViewModel: filterPropertiesViewModel,
                                   filtersPropertiesViewModel: filtersPropertiesViewModel)
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
         */
        /*
        Section(header: Text("Mask Image Node"), footer: Text("Select a Node to use as the Input Mask Image. The preceding image is used by default."))
        {
            //revisit set the input image here with a original image tip
            NavigationLink
            {
                NodeSelectionViewX(nodeType:"AuraFX", numNodes: fx.nodeIndex,
                                   filterPropertiesViewModel: filterPropertiesViewModel)
                    .environmentObject(pageSettings)
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

    
    func GetType(_ m_flowMaskType:Float)->String
    {
        if m_flowMaskType == 0.0 {
            return "Text"
        }
        if m_flowMaskType == 1.0 {
            return "Particles"
        }
        if m_flowMaskType == 2.0 {
            return "Sketch"
        }
        if m_flowMaskType == 3.0 {
            return "GradientNL"
        }
        if m_flowMaskType == 4.0 {
            return "From Pipeline"
        }
        return "Text"
    }
    
    func setupViewModel()
    {
        //colorControlsFX.brightness=

    }
}

