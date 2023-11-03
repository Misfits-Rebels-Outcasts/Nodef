//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

@available(iOS 15.0, *)


@available(iOS 15.0, *)
struct FiltersViewX: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var optionSettings: OptionSettings
    @EnvironmentObject var appSettings: AppSettings
     
    @EnvironmentObject var pageSettings: PageSettings
    //@EnvironmentObject var shapes: ShapesX

    @StateObject var filtersPropertiesViewModel: FiltersPropertiesViewModel
    
    @Environment(\.editMode) private var editMode
  
   var tip = GenerateVideoTip()
    
    var body: some View {
        
        //OptimizeCode
        //Putting the the form inside below and with .presentationDetents([.medium, .large]) works well on iPhone
        //GeometryReader { geometry in
            NavigationView {
            
            Form{

                if  filterNodesExceeded()
                {
                    if appType == "N"
                    {
                        Section(header: Text("Subscription Note"))
                        {
                            Text("This screen is locked when more than 3 nodes are used for compositing. Please consider getting a Subscription if you require more than 3 nodes. You can also delete some nodes on the Pipeline to continue.").foregroundColor(.gray).font(.system(size: 14))
                        }
                    }
       
                }

                //ANCHISES
                Section(header:
                    EditButton().frame(maxWidth: .infinity, alignment: .trailing)
                        .overlay(Text("Steps"), alignment: .leading)
                        ,footer:Text(appType == "N" ? "Steps are composited from top to bottom. Long press on the yellow socket to set/unset the Viewer." : "Filter nodes are composited from top to bottom. Node 0 is the original image. A maximum of 3 nodes are supported.")
                        //,footer:Text(appType == "N" ? "Filter nodes are composited from top to bottom. Node 0 is the original image. Long press on the yellow socket to set the Viewer temporarily." : "Filter nodes are composited from top to bottom. Node 0 is the original image. A maximum of 3 nodes are supported.")
            
                ){
                    
                List {
      
                    ForEach(filtersPropertiesViewModel.filters.filterList) { filterXHolder in
                        
                        HStack{
                            NavigationLink(destination:
                                FilterPropertiesViewX(filterPropertiesViewModel:
                                                        FilterPropertiesViewModel(filterXHolder: filterXHolder),
                                                      filtersPropertiesViewModel:
                                                        filtersPropertiesViewModel,
                                                      parent: self)
                                            .environmentObject(optionSettings)
                                            .environmentObject(pageSettings)
                                            .environmentObject(appSettings)
                                            )
                                {
                                    NodeLabelViewX(filterXHolder: filterXHolder,
                                                   filtersPropertiesViewModel: filtersPropertiesViewModel)
                                        .environmentObject(optionSettings)
                                        .environmentObject(pageSettings)
                                        .environmentObject(appSettings)
                                } //navigationlink
                                .disabled(filterNodesExceeded())
                               
                        }
                        //ANCHISES
                        .moveDisabled(filterXHolder.filter.sticky)
                        .deleteDisabled(filterXHolder.filter.readOnly)
                         

                    } //foreach
                    .onDelete(perform: onDelete)
                    .onMove(perform: move)
                } //list
                     
                } //section
                
                
                FiltersEditViewX(filtersPropertiesViewModel: filtersPropertiesViewModel)
                    .environmentObject(pageSettings)
                    .environmentObject(optionSettings)
                    //.environmentObject(shapes)
                    //.environmentObject(store)


                
            }
            .navigationTitle("Digital Compositing")
            .navigationBarTitleDisplayMode(.inline)

    /*
            .toolbar {

                ToolbarItem(placement: .navigationBarTrailing)
                {
                    EditButton()
                    
                }

            }
     */
            
            .toolbar {
                /*
                if appType == "N" {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Reset") {
                            pageSettings.filters.clear()
                            //Phoebus comeback
                            Task {
                                let node=pageSettings.filters.add("Read Video")
                          
                                await (node as! ReadVideoFX).setupVideoProperties(url: node.assetURL1)
                        
                                await pageSettings.updateVideoImageAsync()
                            }

                            
                        }
                       
                    }
                }
                 */
                if appType == "N" && pageSettings.filters.currentNodeType() == "Video" {
                    ToolbarItem(placement: .navigationBarTrailing) {
                                                
                Button(action: {
                    
                    tip.invalidate(reason: .actionPerformed)
                    
                    pageSettings.generateVideo()
                    optionSettings.showPropertiesSheet = false
                    //ANCHISES for other platforms such as maccatalyst
                    Singleton.onPagePropertiesOff(pageSettings, optionSettings, appSettings)
                    
                    
                    }, label: {
                        Image(systemName: "video.badge.checkmark")
                            //.font(.system(size: 23))
                            //.foregroundColor(colorScheme == .dark ? Color(UIColor(red: 0.9569, green: 0.9569, blue: 0.9569, alpha: 0.5) ) : Color.black)
                            //.padding(.trailing,10)
                       

                    }).popoverTip(tip, arrowEdge: .bottom)
                    .disabled(pageSettings.filters.getCurrentNode()?.videoStatus == "Completed")
                    .opacity(pageSettings.filters.getCurrentNode()?.videoStatus == "Completed" ? 0.2 : 1.0)
                        
                    }
                   
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
 
                    
                    
    #if targetEnvironment(macCatalyst)
                    Button("Done") {
                        Singleton.onPagePropertiesOff(pageSettings, optionSettings, appSettings)
                    }
    #else
             if UIDevice.current.model == "iPad" {
                 Button("Done") {
                     Singleton.onPagePropertiesOff(pageSettings, optionSettings, appSettings)
                 }
              }else{
                  
              }
    #endif
                    /*
                    Button("Help") {
                        if filtersPropertiesViewModel is BackgroundFiltersPropertiesViewModel
                        {
                            shapes.deSelectAll();
                            optionSettings.action = "NodefHelpPipeline"
                            optionSettings.showPropertiesSheet = true
                        }
                        else if filtersPropertiesViewModel is ImageFiltersPropertiesViewModel
                        {
                            optionSettings.action = "ImageFiltersHelpPipeline"
                            optionSettings.showPropertiesSheet = true
                        }
                        
                    }
                     */
                }
              

            }
             
            .onAppear(perform: setupViewModel)
            .onDisappear(perform: {
                tip.invalidate(reason: .actionPerformed)
            })
            //revisit
            /*
            .onChange(of: editMode!.wrappedValue, perform: { value in
              if value.isEditing {
                 print("editing")
              } else {
                  print("leaving")
              }
            })
             */
           
            } //NavigationView
            .navigationViewStyle(.stack)
      
        //}
      

   

    }
    
    func currentNodeSelected(filterXHolder: FilterXHolder) -> Bool {
        if filtersPropertiesViewModel is BackgroundFiltersPropertiesViewModel
        {
            if pageSettings.getViewerNodeIndex() == filterXHolder.filter.nodeIndex
            {
                return true
            }
        }
        else if filtersPropertiesViewModel is ImageFiltersPropertiesViewModel
        {
            //does not work for here
            /*
            var nodeSelected = false
            
            self.shapes.shapeList.forEach
            {
                if $0.isSelected == true {
                    let selectedImage = $0 as! ImageX
                    if selectedImage.getViewerNodeIndex() == filterXHolder.filter.nodeIndex
                    {
                        nodeSelected =  true
                    }
                }
            }
             
            return nodeSelected
             */
            return false
        }
        return false
    }
    
    func filterNodesExceeded() -> Bool {
        
        if filtersPropertiesViewModel is BackgroundFiltersPropertiesViewModel
        {
            /*
            if store.purchasedSubscriptions.count <= 0 &&
                pageSettings.filters.filterList.count > 20
            {
                return true
            }
             */
            if pageSettings.filters.filterList.count > 20
            {
                return true
            }
        }
        else if filtersPropertiesViewModel is ImageFiltersPropertiesViewModel
        {
            if filtersPropertiesViewModel.filters.filterList.count > 3
            {
                return true
            }
        }
        return false
    }

    
    func setViewer(filterXHolder: FilterXHolder) {
        
        print("Secret Long Press Action!",filterXHolder.filter.nodeIndex)

        if filtersPropertiesViewModel is BackgroundFiltersPropertiesViewModel
        {
            pageSettings.setViewer(filterXHolder: filterXHolder)
        }
        else if filtersPropertiesViewModel is ImageFiltersPropertiesViewModel
        {
           
            /*
            self.shapes.shapeList.forEach
            {
                if $0.isSelected == true {
                    let selectedImage = $0 as! ImageX
                    selectedImage.setViewer(filterXHolder: filterXHolder)
           
                }
            }
            */
        }

    }
    
    
    func move(from source: IndexSet, to destination: Int) {

        //ANCHISES
        var listIndex = source.first!
        if listIndex > destination {
            listIndex = destination
        }
        let nodeNumber=listIndex+1
        self.filtersPropertiesViewModel.filters.clearVideoStatus(x: nodeNumber)
       

        //items.move(fromOffsets: source, toOffset: destination)
        self.filtersPropertiesViewModel.filters.filterList.move(fromOffsets: source, toOffset: destination)
        //ANCHISES
        self.filtersPropertiesViewModel.filters.initNodeIndex()
        self.filtersPropertiesViewModel.filters.reassignIndex()
        
        //not required in the page settings version
        self.filtersPropertiesViewModel.objectWillChange.send()
        self.applyFilter()
        

    }
    
    private func onDelete(offsets: IndexSet) {

        //ANCHISES
        let listLast = self.filtersPropertiesViewModel.filters.filterList.count - 1
        var leastIndex = listLast
        for i in offsets {
            if leastIndex > i {
                leastIndex = i
            }
        }
        let nodeNumber=leastIndex+1
        self.filtersPropertiesViewModel.filters.clearVideoStatus(x: nodeNumber)
        //self.filtersPropertiesViewModel.filters.filterList[leastIndex].filter.removeGeneratedVideo()
        
        
        for i in offsets{
            print(i)
            let filter = self.filtersPropertiesViewModel.filters.filterList[i].filter
            if filter is BaseEntityFX {
                (filter as! BaseEntityFX).photoARView!.scene.removeAnchor((filter as! BaseEntityFX).anchorEntity)
            }
        }
  
        //items.remove(atOffsets: offsets)
        self.filtersPropertiesViewModel.filters.filterList.remove(atOffsets: offsets)
        //ANCHISES
        self.filtersPropertiesViewModel.filters.initNodeIndex()
        self.filtersPropertiesViewModel.filters.reassignIndex()
        
        self.filtersPropertiesViewModel.objectWillChange.send()
        self.applyFilter()


    }

    
    func applyFilter() {


        if filtersPropertiesViewModel is BackgroundFiltersPropertiesViewModel
        {
            pageSettings.applyFilters()
        }
        else if filtersPropertiesViewModel is ImageFiltersPropertiesViewModel
        {
            /*
            self.shapes.shapeList.forEach
            {
                if $0.isSelected == true {
                    
                    let selectedImage = $0 as! ImageX
                    selectedImage.applyFilter()
                    
                }
            }
             */
        }
    }

    func setupViewModel()
    {
        print("Filter Pipeline Properties")

        if filtersPropertiesViewModel is BackgroundFiltersPropertiesViewModel
        {
            (filtersPropertiesViewModel as! BackgroundFiltersPropertiesViewModel).setupSelectedProperties()
            //ANCHISES
            filtersPropertiesViewModel.size = pageSettings.size
            print(filtersPropertiesViewModel.size)
            
            (filtersPropertiesViewModel as! BackgroundFiltersPropertiesViewModel).objectWillChange.send()
        }
        else if filtersPropertiesViewModel is ImageFiltersPropertiesViewModel
        {
            (filtersPropertiesViewModel as! ImageFiltersPropertiesViewModel).setupSelectedProperties()
            (filtersPropertiesViewModel as! ImageFiltersPropertiesViewModel).objectWillChange.send()
        }

        self.filtersPropertiesViewModel.objectWillChange.send()
       
 
    }

}

