//
//  Copyright © 2022-2023 James Boo. All rights reserved.
//


import SwiftUI

//Open Photo Effects
//Photo Filters & Animation

@available(iOS 15.0, *)
struct FilterPropertiesViewX: View {
    @Environment(\.dismiss) private var dismiss
    
    //@EnvironmentObject var shapes: ShapesX
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var pageSettings: PageSettings
    @EnvironmentObject var optionSettings: OptionSettings
    
    @StateObject var filterPropertiesViewModel: FilterPropertiesViewModel
    @ObservedObject var filtersPropertiesViewModel: FiltersPropertiesViewModel
    
    @State var currentImage: UIImage?
    var parent: FiltersViewX
    
    
    //var vImage: UIImage?
    
    var body: some View {
                
        Form{
             
            Section(header: Text("Type"),footer: Text(filterPropertiesViewModel.filterXHolder.filter.desc)){
                
                Picker("Type", selection: $filterPropertiesViewModel.selectedFilterType) {
                    if filtersPropertiesViewModel.isFirstNode(filterNodeHolder: filterPropertiesViewModel.filterXHolder) {
                        ForEach(FilterNames.GetStartType(), id: \.self) {
                            Text($0)
                        }
                    } else
                    {
                        ForEach(FilterNames.GetFilterType(), id: \.self) {
                            Text($0)
                        }
                    }
                    
                }
                .onChange(of: filterPropertiesViewModel.selectedFilterType) {  oldValue, newValue in

                    let currentNodeHolder = filterPropertiesViewModel.filterXHolder
                    
                    let nodeNumber=currentNodeHolder.filter.nodeIndex
                    self.filtersPropertiesViewModel.filters.clearVideoStatus(x: nodeNumber)
                                       
                    let newNodeHolder = filtersPropertiesViewModel.filters.getFilterWithHolder(newValue)
                    
                    let ctype=currentNodeHolder.filter.type
                    let ntype=newNodeHolder.filter.type
                    filtersPropertiesViewModel.filters.swap(currentNodeHolder: currentNodeHolder, newNodeHolder: newNodeHolder)

                    let propertiesNode=newNodeHolder.filter
                    filtersPropertiesViewModel.filters.setPropertiesNode(fx: propertiesNode)
                    
                    if ctype == "CIReadVideo" &&
                       ntype == "CIReadImage" {
                        let readImageFX=newNodeHolder.filter as! ReadImageFX
                        //Phoebus comeback
                        readImageFX.setupProperties(pageSettings.filters)
                        pageSettings.setCanvas(image: readImageFX.inputImage!, dpi: 1000)
                    } else if ctype == "CIReadImage" &&
                                ntype == "CIReadVideo" {
                        let readVideoFX=newNodeHolder.filter as! ReadVideoFX
                        pageSettings.filters.initNodeIndex()
                        //Phoebus comeback loadState
                        pageSettings.loadState = .loaded(MovieX(url: readVideoFX.assetURL1))
                  
                    }
                    
                    applyFilter()
                    
                    //pageSettings.updateAVPlayer()

    

                }
            }
            
            FilterPropertiesSelectViewX(filterPropertiesViewModel:
                                            filterPropertiesViewModel,
                                        filtersPropertiesViewModel:
                                            filtersPropertiesViewModel,
                                        parent: self)
                        .environmentObject(optionSettings)
                        .environmentObject(appSettings)
                                                
            if !(filterPropertiesViewModel.filterXHolder.filter is BaseGeneratorEntityFX) &&
                !(filterPropertiesViewModel.filterXHolder.filter is BaseGeneratorFX) &&
                !(filterPropertiesViewModel.filterXHolder.filter is ReadImageFX)
                //ANCHISES
                //!(filterPropertiesViewModel.filterXHolder.filter is FractalFlowNoiseFX) &&
                //ANCHISES
                //!(filterPropertiesViewModel.filterXHolder.filter is BaseTransitionFX) &&
                //!(filterPropertiesViewModel.filterXHolder.filter is BlendWithMaskFX) &&
                //!(filterPropertiesViewModel.filterXHolder.filter is BlendWithAlphaMaskFX) &&
                //!(filterPropertiesViewModel.filterXHolder.filter is ShadedMaterialFX) &&
                //!(filterPropertiesViewModel.filterXHolder.filter is MaskedVariableBlurFX) &&
                //!(filterPropertiesViewModel.filterXHolder.filter is DisplacementDistortionFX)
                //&& !(filterPropertiesViewModel.filterXHolder.filter is GlassDistortionFX)
            {
                //ANCHISES
                NodeInputASectionViewX(filterPropertiesViewModel:
                                        filterPropertiesViewModel,
                                      filtersPropertiesViewModel:
                                        filtersPropertiesViewModel)
               
            }
            
            if filterPropertiesViewModel.filterXHolder.filter is BaseBlendFX ||
                filterPropertiesViewModel.filterXHolder.filter is JoinVideoFX || //ANCHISES
                filterPropertiesViewModel.filterXHolder.filter is BaseTransitionFX || //ANCHISES
                filterPropertiesViewModel.filterXHolder.filter is BaseBlendMaskFX || //ANCHISES
                filterPropertiesViewModel.filterXHolder.filter is BaseTransitionMaskFX || //ANCHISES
                filterPropertiesViewModel.filterXHolder.filter is MixFX
            {
                //ANCHISES
                NodeInputBSectionViewX(filterPropertiesViewModel:
                                        filterPropertiesViewModel,
                                      filtersPropertiesViewModel:
                                        filtersPropertiesViewModel)
              
            }
            if filterPropertiesViewModel.filterXHolder.filter is BaseBlendMaskFX || //ANCHISES
                filterPropertiesViewModel.filterXHolder.filter is BaseTransitionMaskFX //ANCHISES
            {
                NodeInputCSectionViewX(filterPropertiesViewModel:
                                        filterPropertiesViewModel,
                                      filtersPropertiesViewModel:
                                        filtersPropertiesViewModel)

            }
            
            if filterPropertiesViewModel.filterXHolder.filter is PageCurlTransitionFX {
                NodeInputDSectionViewX(filterPropertiesViewModel:
                                        filterPropertiesViewModel,
                                      filtersPropertiesViewModel:
                                        filtersPropertiesViewModel)
            }
            
            if filtersPropertiesViewModel.filters.currentNodeType() == "AR" {
                
            }
            else if filtersPropertiesViewModel.filters.currentNodeType() == "Photo" {
                Section(header: Text("Filter Node Output"))
                {
                    
               
                        if filtersPropertiesViewModel is BackgroundFiltersPropertiesViewModel
                        {
                            HStack{
                                Spacer()
                                if currentImage != nil {
                                    Image(uiImage:  currentImage!)
                                    .resizable()
                                    .edgesIgnoringSafeArea(.all)
                                    .scaledToFit()
                                    .frame(width: 200.0, height: 200.0, alignment: .center)
                                    .padding()
                                }
                                Spacer()
                            }.task {
                                currentImage = await filterPropertiesViewModel.filterXHolder.filter.getCurrentImage(thumbImage: pageSettings.backgroundImage!)
                            }
                        }
                        else if filtersPropertiesViewModel is ImageFiltersPropertiesViewModel
                        {
                            
                            HStack{
                                Spacer()
                                if currentImage != nil {
                                    Image(uiImage: currentImage!)
                                        .resizable()
                                        .edgesIgnoringSafeArea(.all)
                                        .scaledToFit()
                                        .frame(width: 200.0, height: 200.0, alignment: .center)
                                        .padding()
                                }
                                Spacer()
                            }.task {
                                currentImage = await filterPropertiesViewModel.filterXHolder.filter.getCurrentImage(thumbImage: (filtersPropertiesViewModel as! ImageFiltersPropertiesViewModel).image!)
                            }
                             
                        }
                      
                }
            }
            //ANCHISES-how about photo?
            else if filtersPropertiesViewModel.filters.currentNodeType() == "Video" {
                if filterPropertiesViewModel.filterXHolder.filter is ReadVideoFX ||
                    filterPropertiesViewModel.filterXHolder.filter is CutVideoFX ||
                    filterPropertiesViewModel.filterXHolder.filter is JoinVideoFX
                {
                    
                }
                else
                {
                    if filterPropertiesViewModel.filterXHolder.filter.videoStatus == "Completed" {
                        
                        Section(header: Text("Timeline")){
                            HStack{
                                Spacer()
                            
                                VideoTimelinePropertiesX(node: filterPropertiesViewModel.filterXHolder.filter,avPlayer: pageSettings.avPlayer!)
                                    .frame(width: filtersPropertiesViewModel.size.width-80, height:180, alignment: .center)
                             
                                
                                Spacer()
                            }
                        }
                        .onAppear(perform: setupViewModel)
                         
                    }
                    else {
                        
                        Section(header: Text("Preview")){
                            HStack{
                                Spacer()
                                if currentImage != nil {
                                    Image(uiImage: currentImage!)
                                        .resizable()
                                        .edgesIgnoringSafeArea(.all)
                                        .scaledToFit()
                                        .frame(width: 200.0, height: 200.0, alignment: .center)
                                        .padding()
                                }
                                Spacer()
                            }.task {
                                //videoPreviewImage
                                currentImage = await filterPropertiesViewModel.filterXHolder.filter.getCurrentImage(thumbImage: pageSettings.filteredBackgroundImage!)
                            }
                        }
                         
                    }
                   
                }
                
            }
           
            
            Section(header: Text(""), footer: Text("")){
            }
        }
        //ANCHISES
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                          Button {
                              print("Custom Action")
                              filtersPropertiesViewModel.filters.setPropertiesNode(fx: nil)
                              applyFilter()
                              //pageSettings.updateAVPlayer()
                              dismiss()
                              
                              
                          } label: {
                              HStack {
                                  Image(systemName: "chevron.backward")
                                  Text("Back")
                              }
                          }.task {
                              //await filtersPropertiesViewModel.filters.getCurrentNode()?.executeImageBackwards()
                              //pageSettings.updateAVPlayer()
                              applyFilter()
                              //filtersPropertiesViewModel.filters.getCurrentNode()?.updateStatus()
                          }
                      }
        }
        .navigationTitle(String("Step ")+String(filterPropertiesViewModel.filterXHolder.filter.nodeIndex))
        .navigationBarTitleDisplayMode(.inline)
  
    
        /* -causes crash
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        
                        //presentationMode.wrappedValue.dismiss()
                        //dismiss()
                        //parent.childDismiss()
                        
                        shapes.shapeList.forEach
                        {
                                $0.isSelected = false
                        }
                        
                        print("Page Properties Off - Node Properties Done")
                        pageSettings.resetViewer()
                        optionSettings.showPropertiesView=0
                        optionSettings.showPagePropertiesView=0
                        optionSettings.pagePropertiesHeight=95
                        appSettings.zoomFactor = appSettings.zoomFactor * 1.0/0.999
                        

                    }
            }
        }*/
         
        //.frame(height:horizontalSizeClass == .regular && verticalSizeClass == .regular ? propertiesHeightTall : propertiesHeight)
        .onAppear(perform: setupViewModel)
        //70 causes issue here on ipad so taken out
        //        .padding(.bottom, horizontalSizeClass == .regular && verticalSizeClass == .regular ? 70 : 0)
        
    }
    
    func setupViewModel()
    {
        print("Filter Properties SetupViewModel")
        
        //ANCHISES
        let propertiesNode=filterPropertiesViewModel.filterXHolder.filter
        filtersPropertiesViewModel.filters.setPropertiesNode(fx: propertiesNode)
        applyFilter()
    }
    
    //ANCHISES comeback
    func readImage(fx: FilterX) {
        
        filtersPropertiesViewModel.setupReadImage(fx: fx)
        
        optionSettings.action = "ReadPhoto"
        optionSettings.showPropertiesSheet = true
    }
    
    func readVideo(fx: FilterX) {
        
        //ANCHISES comeback
        //filtersPropertiesViewModel.setupReadImage(fx: fx)
        
        optionSettings.action = "ReadVideo"
        optionSettings.showPropertiesSheet = true
    }
    
    func applyFilterAsync() async {
        
        await filtersPropertiesViewModel.applyFiltersAsync()

    }
    
    func applyFilter() {
        
        filtersPropertiesViewModel.applyFilters()

    }

    func applyFilter(_ changeType: String) {
        
        if changeType == "start" {
            //do nothing
        }
        else if changeType == "stop" {
            applyFilter()
        }
        if changeType == "change" {
            //leaving this alone to allow REad Image Node 1 can set to lower resolution such as shader
            if appSettings.mode=="Shader" || appSettings.imageRes != "High Resolution"
            {
                applyFilter()
            }
        }
        
        //ANCHISES
        filterPropertiesViewModel.filterXHolder.filter.videoStatus="Not Started"
        filtersPropertiesViewModel.filters.clearVideoStatus(x: filterPropertiesViewModel.filterXHolder.filter.nodeIndex)
    }
    
}


