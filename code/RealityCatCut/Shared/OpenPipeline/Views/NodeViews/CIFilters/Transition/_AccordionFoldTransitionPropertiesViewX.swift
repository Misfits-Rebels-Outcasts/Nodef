//
//  Copyright © 2022 James Boo. All rights reserved.
//



import SwiftUI


@available(iOS 15.0, *)
struct AccordionFoldTransitionPropertiesViewX: View, NodeProperties {

    @ObservedObject var fx: AccordionFoldTransitionFX = AccordionFoldTransitionFX()
    @ObservedObject var filterPropertiesViewModel: FilterPropertiesViewModel
    @ObservedObject var filtersPropertiesViewModel: FiltersPropertiesViewModel

    
    var parent: FilterPropertiesViewX?
    
    var body: some View {

        Section(header: Text("Options")){
            
            HStack{
                Text("Time")
                Spacer()
                Text(String(format: "%.2f", fx.time))
            }
            
            Slider(value: $fx.time, in: 0...1, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.time) { oldValue, newValue in
                    //print("id",fx.id)
                    applyFilter()
                }
            
            HStack{
                Text("Bottom Height")
                Spacer()
                Text(String(format: "%.2f", fx.bottomHeight))
            }
            
         
            Slider(value: $fx.bottomHeight, in: 0...Float(fx.size.height), onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.bottomHeight) { oldValue, newValue in
                    //print("id",fx.id)
                    applyFilter()
                }
            //revisit
            
            HStack{
                Text("Number of Folds")
                Spacer()
                Text(String(format: "%.0f", fx.numberOfFolds))
            }
            
            //revisit
            Slider(value: $fx.numberOfFolds, in: 1...10, onEditingChanged: {editing in
                fx.numberOfFolds=Float(Int(fx.numberOfFolds))
                applyFilter(editing)
            })
                .onChange(of: fx.numberOfFolds) { oldValue, newValue in
                    fx.numberOfFolds=Float(Int(fx.numberOfFolds))
                    //print("id",fx.id)
                    applyFilter()
                }
            
            HStack{
                Text("Fold Shadow Amount")
                Spacer()
                Text(String(format: "%.2f", fx.foldShadowAmount))
            }
            
            //revisit
            Slider(value: $fx.foldShadowAmount, in: 0...100, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.foldShadowAmount) { oldValue, newValue in
                    //print("id",fx.id)
                    applyFilter()
                }
        }
        .onAppear(perform: setupViewModel)
        
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
        
        Section(header: Text("Target Image Node"), footer: Text("Select a Node to use as the Target Image. The original image is used by default."))
        {
            
            NavigationLink
            {
                NodeSelectionViewX(nodeType:"target", numNodes: fx.nodeIndex,
                                   filterPropertiesViewModel: filterPropertiesViewModel,
                                   filtersPropertiesViewModel: filtersPropertiesViewModel)
                    //.environmentObject(pageSettings)
            } label: {
                HStack{
                    Text("Node")
                    Spacer()
                    if fx.targetImageAlias == ""{
                        Text("Preceding").foregroundColor(Color.gray)
                    }
                    else{
                        Text("Node "+fx.targetImageAlias).foregroundColor(Color.gray)
                    }
                    
                }
            }
            HStack{
                Text("Node Number")
                Spacer()
                if fx.targetImageAlias == ""{
                    Text(String(fx.nodeIndex-1))
                }
                else{
                    Text(fx.targetImageAlias)
                }
            }
             
             
        }


        //Section(header: Text(""), footer: Text("")){
        //}
    }
    

    
    func setupViewModel()
    {
        //colorControlsFX.brightness=
       // numberOfFolds=Float(fx.numberOfFolds)

    }
}

