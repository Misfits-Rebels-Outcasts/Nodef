//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

@available(iOS 15.0, *)


@available(iOS 15.0, *)
struct FiltersViewX: View {
    //@Environment(\.dismiss) private var dismiss
    
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
  
    
    @EnvironmentObject var optionSettings: OptionSettings
    @EnvironmentObject var appSettings: AppSettings
    //@EnvironmentObject var dataSettings: DataSettings
     
    @EnvironmentObject var pageSettings: PageSettings
    @EnvironmentObject var shapes: ShapesX
    //@EnvironmentObject var store: Store
    
    //@ObservedObject var imagePropertiesViewModel: ImagePropertiesViewModel
    @StateObject var filtersPropertiesViewModel: FiltersPropertiesViewModel
    
    @Environment(\.editMode) private var editMode
    
    //https://www.ioscreator.com/tutorials/swiftui-add-rows-list-tutorial
    //https://www.hackingwithswift.com/quick-start/swiftui/how-to-push-a-new-view-when-a-list-row-is-tapped
    @GestureState var isDetectingLongPress = false
    @State var completedLongPress = false
       
    var addingNodes = false

  
    var longPress: some Gesture {
        LongPressGesture(minimumDuration: 3)
            .updating($isDetectingLongPress) { currentState, gestureState,
                    transaction in
                gestureState = currentState
                transaction.animation = Animation.easeIn(duration: 2.0)
            }
            .onEnded { finished in
                self.completedLongPress = finished
            }
    }
    
    var body: some View {
       
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

            
            Section(header:
                EditButton().frame(maxWidth: .infinity, alignment: .trailing)
                    .overlay(Text("Nodes"), alignment: .leading)
                    ,footer:Text(appType == "N" ? "Filter nodes are composited from top to bottom. Node 0 is the original image. Long press on the yellow socket to set the Viewer temporarily." : "Filter nodes are composited from top to bottom. Node 0 is the original image. A maximum of 3 nodes are supported.")
        
            ){
                /*
                NavigationLink("Filters Pipeline")
                {
                    Text("DetailX")
                }
                .isDetailLink(false)
                */
                /*
                NavigationStack {
                    NavigationLink(destination:
                                    Text("Detail")
                                   
                    )
                    {
                        Text("Node")
                    }
                    .isDetailLink(false)
                    
                }
                */
                
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
                                        .environmentObject(shapes)
                                      
                                        )
                            {
                                            //Text(filter.getDisplayName())
                         
                            //Text("fx(" + filter.inputImageAlias + "," + filter.backgroundImageAlias + ")" + filter.getDisplayName() + "-" + filter.alias )
                            VStack{
                                HStack{
                                    //Text("node").font(.system(size: 14))
                                    //Image(systemName: "circle.fill")
                                    //    .font(.system(size: 8))
                                    //    .foregroundColor(.yellow)
                                    Text(filterXHolder.filter.getNodeNameFX()).font(.system(size: 14))
                                    //Text("Alias : "+filter.alias).font(.system(size: 12))
                                    Spacer()
                                }
                                .gesture(LongPressGesture (minimumDuration: 0.5)
                                                            .updating ($isDetectingLongPress) { currentState, gestureState,
                                                                transaction in
                                                                gestureState = currentState
                                                            
                                                                
                                                            }
                                                            .onEnded { value in
                                                                //pageSettings.applyFilters()
                                                                /*
                                                            print("Secret Long Press Action!",filterXHolder.filter.nodeIndex)
                                                            pageSettings.setViewer(filterXHolder: filterXHolder)
                                                                 */
                                                               setViewer(filterXHolder: filterXHolder)

                                                            }
                                                        )
                                HStack{
                                    //if pageSettings.getViewerNodeIndex() == //filterXHolder.filter.nodeIndex
                                    if currentNodeSelected(filterXHolder: filterXHolder)
                                        //|| pageSettings.getViewerNodeIndex() == -1
                                    {
                                        Image(systemName: "circle.fill")
                                            .font(.system(size: 8))
                                            .foregroundColor(.blue)
                                    }
                                    else
                                    {
                                        Image(systemName: "circle.fill")
                                            .font(.system(size: 8))
                                            .foregroundColor(.yellow)
                                            .gesture(LongPressGesture (minimumDuration: 0.5)
                                                                        .updating ($isDetectingLongPress) { currentState, gestureState,
                                                                            transaction in
                                                                            gestureState = currentState
                                                                        
                                                                            
                                                                        }
                                                                        .onEnded { value in
                                                                            //pageSettings.applyFilters()
                                                                            /*
                                                                        print("Secret Long Press Action!",filterXHolder.filter.nodeIndex)
                                                                        pageSettings.setViewer(filterXHolder: filterXHolder)
                                                                             */
                                                                            setViewer(filterXHolder: filterXHolder)
                                                                        }
                                                                    )
                                    }
                                    
                                    Text(filterXHolder.filter.getDisplayNameFX()).font(.system(size: 14))

                                    Spacer()
                                }
                                HStack{
                                    //Text(String(filterXHolder.filter.nodeIndex)+". ")//.font(.system(size: 15))
                                    Text(filterXHolder.filter.getDisplayName())//.font(.system(size: 15))
                                    Spacer()
                                }

                            }
                            
                            } //navigationlink
                            .disabled(filterNodesExceeded())

                           
               
                       

                    }
                     

                } //foreach
                .onDelete(perform: onDelete)
                .onMove(perform: move)
            } //list
                 
            } //section
            
            
            FiltersEditViewX(filtersPropertiesViewModel: filtersPropertiesViewModel)
                .environmentObject(pageSettings)
                .environmentObject(optionSettings)
                .environmentObject(shapes)
                //.environmentObject(store)


            
        }
        .navigationTitle("Pipeline")
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
            if appType == "N" {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Reset") {
                        pageSettings.filters.clear()
                        
                        let filterXHolder = FilterXHolder()
                        filterXHolder.filter=ColorControlsFX()
                        pageSettings.filters.add(filterHolder: filterXHolder)
                        
                        pageSettings.applyFilters()
                    }
                }
            }
                
            ToolbarItem(placement: .navigationBarTrailing) {
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
            }
          
            /*
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Help") {
                    if filtersPropertiesViewModel is BackgroundFiltersPropertiesViewModel
                    {
                        shapes.deSelectAll();
                        optionSettings.action = "NodefHelpPipeline"
                        optionSettings.showPropertiesSheet = true
                    }
                    else if filtersPropertiesViewModel is ImageFiltersPropertiesViewModel
                    {
                    }
                    
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        if filtersPropertiesViewModel is BackgroundFiltersPropertiesViewModel
                        {
                            shapes.shapeList.forEach
                            {
                                    $0.isSelected = false
                            }
                            
                            print("Page Properties Off")
                            pageSettings.resetViewer()
                            optionSettings.showPropertiesView=0
                            optionSettings.showPagePropertiesView=0
                            optionSettings.pagePropertiesHeight=95
                            appSettings.zoomFactor = appSettings.zoomFactor * 1.0/0.999
                        }
                        else if filtersPropertiesViewModel is ImageFiltersPropertiesViewModel
                        {
                        }
                        
                    }
            }
            */
        }
         
        .onAppear(perform: setupViewModel)
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

        //items.move(fromOffsets: source, toOffset: destination)
        self.filtersPropertiesViewModel.filters.filterList.move(fromOffsets: source, toOffset: destination)
        self.filtersPropertiesViewModel.filters.reassignIndex()
        
        //not required in the page settings version
        self.filtersPropertiesViewModel.objectWillChange.send()
        self.applyFilter()
    }
    
    private func onDelete(offsets: IndexSet) {


        //items.remove(atOffsets: offsets)
        self.filtersPropertiesViewModel.filters.filterList.remove(atOffsets: offsets)
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
            self.shapes.shapeList.forEach
            {
                if $0.isSelected == true {
                    
                    let selectedImage = $0 as! ImageX
                    selectedImage.applyFilter()
                    
                }
            }
        }
    }

    func setupViewModel()
    {
        print("Filter Pipeline Properties")


        if filtersPropertiesViewModel is BackgroundFiltersPropertiesViewModel
        {
            (filtersPropertiesViewModel as! BackgroundFiltersPropertiesViewModel).setupSelectedProperties()
            (filtersPropertiesViewModel as! BackgroundFiltersPropertiesViewModel).objectWillChange.send()
        }
        else if filtersPropertiesViewModel is ImageFiltersPropertiesViewModel
        {
            (filtersPropertiesViewModel as! ImageFiltersPropertiesViewModel).setupSelectedProperties()
            (filtersPropertiesViewModel as! ImageFiltersPropertiesViewModel).objectWillChange.send()
        }

        self.filtersPropertiesViewModel.objectWillChange.send()
       
        
        //appSettings.zoomFactor=appSettings.zoomFactor*0.9
    }
     /*
    public func childDismiss()
    {
        dismiss()
    }
      */
}

