//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

struct NodeSelectionViewX: View {
    @StateObject var state :StateManager = StateManager()
    //@EnvironmentObject var pageSettings: PageSettings
    var nodeType = "input"
    var numNodes = 1
    @ObservedObject var filterPropertiesViewModel: FilterPropertiesViewModel
    @ObservedObject var filtersPropertiesViewModel: FiltersPropertiesViewModel

    init(nodeType: String,
         numNodes: Int = 1,
         filterPropertiesViewModel: FilterPropertiesViewModel,
         filtersPropertiesViewModel: FiltersPropertiesViewModel) {
        self.nodeType=nodeType
        self.numNodes=numNodes
        self.filterPropertiesViewModel=filterPropertiesViewModel
        self.filtersPropertiesViewModel=filtersPropertiesViewModel
    }
    
    var body: some View {
        
            List(Array(state.nodemarks.enumerated()), id: \.1.id) { (index, item) in //<-- here
                NodeMarkView(index: item.nodeNumber,
                             nodeId: item.nodeId,
                             nodeType: self.nodeType,
                             nodeName: item.nodeName,
                             nodeTitle: item.nodeTitle,
                             check: state.singularBinding(forIndex: index),
                             filterPropertiesViewModel: self.filterPropertiesViewModel,
                             filtersPropertiesViewModel: self.filtersPropertiesViewModel)
                    //.environmentObject(pageSettings)
                    .padding(.all, 3)
            }
            .listStyle(PlainListStyle())
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: initNodes)
    }
    func initNodes()
    {
       
        state.initNodes(nodeType:nodeType, numNodes: self.numNodes,
                        filters: self.filtersPropertiesViewModel.filters,
                        filter: self.filterPropertiesViewModel.filterXHolder.filter,
                        filterPropertiesViewModel: self.filterPropertiesViewModel)

    }
}

struct NodeSelectionModel {
    var id = UUID()
    var nodeId: String
    var nodeNumber: Int = -1
    var nodeName: String = ""
    var nodeTitle: String = ""
    var selected = false
}

class StateManager : ObservableObject {
    //ANCHISES
    /*
    @Published var nodemarks = [NodeSelectionModel(nodeId:"",
                                                   nodeNumber:-1,
                                                   nodeName:"Preceding",
                                                   nodeTitle: "Preceding Step (Adjusted Automatically)"),
                                NodeSelectionModel(nodeId:"",
                                                   nodeNumber:0,
                                                   nodeName:"Step 0",
                                                   nodeTitle: "Original Image")]
     */
    @Published var nodemarks = [NodeSelectionModel(nodeId:"",
                                                   nodeNumber:-1,
                                                   nodeName:"Preceding",
                                                   nodeTitle: "Preceding Step (Adjusted Automatically)")]
    init()
    {
        
    }

    func initNodes(nodeType:String, numNodes: Int, filters: FiltersX, filter: FilterX, filterPropertiesViewModel: FilterPropertiesViewModel) {
        
        if nodeType == "input"{
            self.initNodeMarks(numNodes: numNodes,
                                filters: filters,
                                filter: filterPropertiesViewModel.filterXHolder.filter,
                                filterPropertiesViewModel: filterPropertiesViewModel,
                                alias: filter.inputImageAlias)
        }
        else if nodeType == "background"{
            self.initNodeMarks(numNodes: numNodes,
                                filters: filters,
                                filter: filterPropertiesViewModel.filterXHolder.filter,
                                filterPropertiesViewModel: filterPropertiesViewModel,
                                alias: filter.backgroundImageAlias)
        }
        else if nodeType == "target"{
            self.initNodeMarks(numNodes: numNodes,
                                filters: filters,
                                filter: filterPropertiesViewModel.filterXHolder.filter,
                                filterPropertiesViewModel: filterPropertiesViewModel,
                                alias: (filter as! BaseTransitionFX).targetImageAlias)
        }
        /*
        else if nodeType == "FractalFlowNoiseFX"{
            self.initNodeMarks(numNodes: numNodes,
                                filters: filters,
                                filter: filterPropertiesViewModel.filterXHolder.filter,
                                filterPropertiesViewModel: filterPropertiesViewModel,
                                alias: (filter as! FractalFlowNoiseFX).inputMaskImageAlias)
        }
         */
        else if nodeType == "BlendWithMaskFX"{
            self.initNodeMarks(numNodes: numNodes,
                                filters: filters,
                                filter: filterPropertiesViewModel.filterXHolder.filter,
                                filterPropertiesViewModel: filterPropertiesViewModel,
                                alias: (filter as! BlendWithMaskFX).inputMaskImageAlias)
        }
        else if nodeType == "BlendWithAlphaMaskFX"{
            self.initNodeMarks(numNodes: numNodes,
                                filters: filters,
                                filter: filterPropertiesViewModel.filterXHolder.filter,
                                filterPropertiesViewModel: filterPropertiesViewModel,
                                alias: (filter as! BlendWithAlphaMaskFX).inputMaskImageAlias)
        }
        else if nodeType == "MaskedVariableBlurFX"{
            self.initNodeMarks(numNodes: numNodes,
                                filters: filters,
                                filter: filterPropertiesViewModel.filterXHolder.filter,
                                filterPropertiesViewModel: filterPropertiesViewModel,
                                alias: (filter as! MaskedVariableBlurFX).inputMaskImageAlias)
        }
        else if nodeType == "ShadedMaterialFX"{
            self.initNodeMarks(numNodes: numNodes,
                                filters: filters,
                                filter: filterPropertiesViewModel.filterXHolder.filter,
                                filterPropertiesViewModel: filterPropertiesViewModel,
                                alias: (filter as! ShadedMaterialFX).inputShadingImageAlias)
        }
        else if nodeType == "GlassDistortionFX"{
            self.initNodeMarks(numNodes: numNodes,
                                filters: filters,
                                filter: filterPropertiesViewModel.filterXHolder.filter,
                                filterPropertiesViewModel: filterPropertiesViewModel,
                               alias: (filter as! GlassDistortionFX).inputTextureAlias)
        }
        else if nodeType == "DisplacementDistortionFX"{
            self.initNodeMarks(numNodes: numNodes,
                                filters: filters,
                                filter: filterPropertiesViewModel.filterXHolder.filter,
                                filterPropertiesViewModel: filterPropertiesViewModel,
                                alias: (filter as! DisplacementDistortionFX).inputDisplacementImageAlias)
        }
        else if nodeType == "RippleTransitionFX"{
            self.initNodeMarks(numNodes: numNodes,
                                filters: filters,
                                filter: filterPropertiesViewModel.filterXHolder.filter,
                                filterPropertiesViewModel: filterPropertiesViewModel,
                                alias: (filter as! RippleTransitionFX).inputShadingImageAlias)
        }
        else if nodeType == "DisintegrateWithMaskTransitionFX"{
            self.initNodeMarks(numNodes: numNodes,
                                filters: filters,
                                filter: filterPropertiesViewModel.filterXHolder.filter,
                                filterPropertiesViewModel: filterPropertiesViewModel,
                                alias: (filter as! DisintegrateWithMaskTransitionFX).inputMaskImageAlias)
        }
        else if nodeType == "PageCurlTransitionFX-backside"{
            self.initNodeMarks(numNodes: numNodes,
                                filters: filters,
                                filter: filterPropertiesViewModel.filterXHolder.filter,
                                filterPropertiesViewModel: filterPropertiesViewModel,
                               alias: (filter as! PageCurlTransitionFX).inputBacksideImageAlias)
        }
        else if nodeType == "PageCurlTransitionFX-shading"{
            self.initNodeMarks(numNodes: numNodes,
                                filters: filters,
                                filter: filterPropertiesViewModel.filterXHolder.filter,
                                filterPropertiesViewModel: filterPropertiesViewModel,
                               alias: (filter as! PageCurlTransitionFX).inputShadingImageAlias)
        }
        else if nodeType == "PageCurlWithShadowTransitionFX-backside"{
            self.initNodeMarks(numNodes: numNodes,
                                filters: filters,
                                filter: filterPropertiesViewModel.filterXHolder.filter,
                                filterPropertiesViewModel: filterPropertiesViewModel,
                               alias: (filter as! PageCurlWithShadowTransitionFX).inputBacksideImageAlias)
        }
        //ANCHISES
        else if nodeType == "inputA"{
            self.initNodeMarks(numNodes: numNodes,
                                filters: filters,
                                filter: filterPropertiesViewModel.filterXHolder.filter,
                                filterPropertiesViewModel: filterPropertiesViewModel,
                                alias: filter.inputAAlias)
        }
        else if nodeType == "inputB"{
            self.initNodeMarks(numNodes: numNodes,
                                filters: filters,
                                filter: filterPropertiesViewModel.filterXHolder.filter,
                                filterPropertiesViewModel: filterPropertiesViewModel,
                               alias: filter.inputBAlias)
        }
        else if nodeType == "inputC"{
            self.initNodeMarks(numNodes: numNodes,
                                filters: filters,
                                filter: filterPropertiesViewModel.filterXHolder.filter,
                                filterPropertiesViewModel: filterPropertiesViewModel,
                                alias: filter.inputCAlias)
        }
        else if nodeType == "inputD"{
            self.initNodeMarks(numNodes: numNodes,
                                filters: filters,
                                filter: filterPropertiesViewModel.filterXHolder.filter,
                                filterPropertiesViewModel: filterPropertiesViewModel,
                                alias: filter.inputDAlias)
        }
    }
    
    func initNodeMarks(numNodes: Int, filters: FiltersX, filter: FilterX, filterPropertiesViewModel: FilterPropertiesViewModel, alias:String) {
        for i in 1..<numNodes {
            nodemarks.append(NodeSelectionModel(
                                                nodeId: filters.filterList[i-1].filter.id.uuidString,
                                                nodeNumber:i,
                                                nodeName: String("Step ")+String(i),
                                                nodeTitle: filters.filterList[i-1].filter.getDisplayName()
                                                ))
        }
        if alias == "" {
            nodemarks[0].selected=true
        }
        else {
            
            if alias == "#REF!" {
                
            }
            else{
                let selectedIndex:Int = Int(alias)!
                if selectedIndex >= filter.nodeIndex{

                }
                else{
                    //ANCIHSES
                    //nodemarks[selectedIndex+1].selected=true
                    nodemarks[selectedIndex].selected=true
                }
            }
            
        }
    }
   
    func singularBinding(forIndex index: Int) -> Binding<Bool> {
        Binding<Bool> { () -> Bool in
            self.nodemarks[index].selected
        } set: { (newValue) in
            self.nodemarks = self.nodemarks.enumerated().map { itemIndex, item in
                var itemCopy = item
                if index == itemIndex {
                    itemCopy.selected = newValue
                } else {
                    //not the same index
                    if newValue {
                        itemCopy.selected = false
                    }
                }
                return itemCopy
            }
        }
    }
     
}

struct NodeMarkView: View {
    @EnvironmentObject var pageSettings: PageSettings
    
    let index: Int
    let nodeId: String
    let nodeType: String
    let nodeName: String
    let nodeTitle: String
    @Binding var check: Bool //<-- Here
    @ObservedObject var filterPropertiesViewModel: FilterPropertiesViewModel
    @ObservedObject var filtersPropertiesViewModel: FiltersPropertiesViewModel

    var body: some View {
        Button(action: {
            check.toggle()
            print(nodeId)
            
            if nodeType=="input"{
                
                filterPropertiesViewModel.filterXHolder.filter.inputImageAlias=setupAlias(nodeName: nodeName)
                filterPropertiesViewModel.filterXHolder.filter.inputImageAliasId=nodeId
                
            }
            else if nodeType=="background"{
                filterPropertiesViewModel.filterXHolder.filter.backgroundImageAlias=setupAlias(nodeName: nodeName)
                filterPropertiesViewModel.filterXHolder.filter.backgroundImageAliasId=nodeId
            }
            else if nodeType=="target"{
                (filterPropertiesViewModel.filterXHolder.filter as! BaseTransitionFX).targetImageAlias=setupAlias(nodeName: nodeName)
                (filterPropertiesViewModel.filterXHolder.filter as! BaseTransitionFX).targetImageAliasId=nodeId
            }
            else if nodeType=="BlendWithMaskFX"{
                (filterPropertiesViewModel.filterXHolder.filter as! BlendWithMaskFX).inputMaskImageAlias=setupAlias(nodeName: nodeName)
                (filterPropertiesViewModel.filterXHolder.filter as! BlendWithMaskFX).inputMaskImageAliasId=nodeId
            }
            else if nodeType == "BlendWithAlphaMaskFX"{
                (filterPropertiesViewModel.filterXHolder.filter as! BlendWithAlphaMaskFX).inputMaskImageAlias=setupAlias(nodeName: nodeName)
                (filterPropertiesViewModel.filterXHolder.filter as! BlendWithAlphaMaskFX).inputMaskImageAliasId=nodeId
            }
            else if nodeType == "MaskedVariableBlurFX"{
                (filterPropertiesViewModel.filterXHolder.filter as! MaskedVariableBlurFX).inputMaskImageAlias=setupAlias(nodeName: nodeName)
                (filterPropertiesViewModel.filterXHolder.filter as! MaskedVariableBlurFX).inputMaskImageAliasId=nodeId
            }
            else if nodeType == "ShadedMaterialFX"{
                (filterPropertiesViewModel.filterXHolder.filter as! ShadedMaterialFX).inputShadingImageAlias=setupAlias(nodeName: nodeName)
                (filterPropertiesViewModel.filterXHolder.filter as! ShadedMaterialFX).inputShadingImageAliasId=nodeId
            }
            else if nodeType == "GlassDistortionFX"{
                (filterPropertiesViewModel.filterXHolder.filter as! GlassDistortionFX).inputTextureAlias=setupAlias(nodeName: nodeName)
                (filterPropertiesViewModel.filterXHolder.filter as! GlassDistortionFX).inputTextureAliasId=nodeId
            }
            else if nodeType == "DisplacementDistortionFX"{
                (filterPropertiesViewModel.filterXHolder.filter as! DisplacementDistortionFX).inputDisplacementImageAlias=setupAlias(nodeName: nodeName)
                (filterPropertiesViewModel.filterXHolder.filter as! DisplacementDistortionFX).inputDisplacementImageAliasId=nodeId
            }
            else if nodeType == "RippleTransitionFX"{
                (filterPropertiesViewModel.filterXHolder.filter as! RippleTransitionFX).inputShadingImageAlias=setupAlias(nodeName: nodeName)
                (filterPropertiesViewModel.filterXHolder.filter as! RippleTransitionFX).inputShadingImageAliasId=nodeId
            }
            else if nodeType == "DisintegrateWithMaskTransitionFX"{
                (filterPropertiesViewModel.filterXHolder.filter as! DisintegrateWithMaskTransitionFX).inputMaskImageAlias=setupAlias(nodeName: nodeName)
                (filterPropertiesViewModel.filterXHolder.filter as! DisintegrateWithMaskTransitionFX).inputMaskImageAliasId=nodeId
            }
            else if nodeType == "PageCurlTransitionFX-backside"{
                (filterPropertiesViewModel.filterXHolder.filter as! PageCurlTransitionFX).inputBacksideImageAlias=setupAlias(nodeName: nodeName)
                (filterPropertiesViewModel.filterXHolder.filter as! PageCurlTransitionFX).inputBacksideImageAliasId=nodeId
            }
            else if nodeType == "PageCurlTransitionFX-shading"{
                (filterPropertiesViewModel.filterXHolder.filter as! PageCurlTransitionFX).inputShadingImageAlias=setupAlias(nodeName: nodeName)
                (filterPropertiesViewModel.filterXHolder.filter as! PageCurlTransitionFX).inputShadingImageAliasId=nodeId
            }
            else if nodeType == "PageCurlWithShadowTransitionFX-backside"{
                (filterPropertiesViewModel.filterXHolder.filter as! PageCurlWithShadowTransitionFX).inputBacksideImageAlias=setupAlias(nodeName: nodeName)
                (filterPropertiesViewModel.filterXHolder.filter as! PageCurlWithShadowTransitionFX).inputBacksideImageAliasId=nodeId
            }
            //ANCHISES
            else if nodeType=="inputA"{
                setupNodeInput(nodeType: nodeType,
                               node: filterPropertiesViewModel.filterXHolder.filter,
                               nodeId: nodeId,
                               nodeName: nodeName)
          
            }
            else if nodeType=="inputB"{
                setupNodeInput(nodeType: nodeType,
                               node: filterPropertiesViewModel.filterXHolder.filter,
                               nodeId: nodeId,
                               nodeName: nodeName)
              
            }
            else if nodeType=="inputC"{
                 setupNodeInput(nodeType: nodeType,
                                node: filterPropertiesViewModel.filterXHolder.filter,
                                nodeId: nodeId,
                                nodeName: nodeName)
    
            }
            else if nodeType=="inputD"{
                 setupNodeInput(nodeType: nodeType,
                                node: filterPropertiesViewModel.filterXHolder.filter,
                                nodeId: nodeId,
                                nodeName: nodeName)
    
            }
            //ANCHISES
            if filterPropertiesViewModel.filterXHolder.filter.type=="CICutVideo" {
                (filterPropertiesViewModel.filterXHolder.filter as! CutVideoFX).creation=true
                (filterPropertiesViewModel.filterXHolder.filter as! CutVideoFX).updateTimeline=true
            }
            filtersPropertiesViewModel.filters.initNodeIndex()
            filterPropertiesViewModel.filterXHolder.filter.videoStatus="Not Started"
            filtersPropertiesViewModel.filters.clearVideoStatus(x: filterPropertiesViewModel.filterXHolder.filter.nodeIndex)

            filtersPropertiesViewModel.applyFilters()
            
            filterPropertiesViewModel.objectWillChange.send()

        }) {
            VStack{
                HStack {
                    Text(nodeName).font(.system(size:20))
                    Spacer()
                    if check {
                        Image(systemName: "checkmark")
                            .resizable()
                            .frame(width: 12, height: 12)
                    }
                }.padding(EdgeInsets(top: 1, leading: 0, bottom: 0, trailing: 0))
                HStack{
                    Text(nodeTitle).font(.system(size:16)).foregroundColor(.gray)
                    Spacer()
                }.padding(EdgeInsets(top: 0.1, leading: 0, bottom: 1, trailing: 0))
            }
        }
    }

    
    func setupAlias(nodeName: String)->String
    {
        var alias:String=""
        if nodeName == "Preceding"
        {
            alias=""
        }
        else if nodeName == "Step 0"
        {
            alias="0"
        }
        else {
            
            filtersPropertiesViewModel.filters.filterList.forEach
            {
                let filterXHolder = $0
                if nodeId == filterXHolder.filter.id.uuidString
                {
                    alias=String(filterXHolder.filter.nodeIndex)
                }
            }
            
           
        }
       
        return alias
    }
    
    //ANCHISES
    func setupNodeInput(nodeType: String, node: FilterX, nodeId: String, nodeName: String)
    {
        var alias:String=""
        var inputNode: FilterX=node //assume from selection can be found
        filtersPropertiesViewModel.filters.filterList.forEach
        {
            let filterXHolder = $0
            if nodeId == filterXHolder.filter.id.uuidString
            {
                inputNode=filterXHolder.filter
                alias=String(filterXHolder.filter.nodeIndex)
            }
        }
        
        if nodeName == "Preceding"
        {
            alias=""
            inputNode=node.previousNode!
        }
        
        
        if nodeType == "inputA" {
            node.inputAAlias=alias
            node.inputAAliasId=nodeId
            node.inputA=inputNode
        }
        else if nodeType == "inputB" {
            node.inputBAlias=alias
            node.inputBAliasId=nodeId
            node.inputB=inputNode
        }
        else if nodeType == "inputC" {
            node.inputCAlias=alias
            node.inputCAliasId=nodeId
            node.inputC=inputNode
        }
        else if nodeType == "inputD" {
            node.inputDAlias=alias
            node.inputDAliasId=nodeId
            node.inputD=inputNode
        }
        //node.removeGeneratedVideo()
        //initNOdeIndex is outside


    }
    
}
