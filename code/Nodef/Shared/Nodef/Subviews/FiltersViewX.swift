//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

@available(iOS 15.0, *)


@available(iOS 15.0, *)
struct FiltersViewX: View {
    
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
  
    
    @EnvironmentObject var optionSettings: OptionSettings
    @EnvironmentObject var appSettings: AppSettings
    //@EnvironmentObject var dataSettings: DataSettings
     
    @EnvironmentObject var pageSettings: PageSettings

    //@EnvironmentObject var store: Store
    
    //@ObservedObject var imagePropertiesViewModel: ImagePropertiesViewModel
    @StateObject var filtersPropertiesViewModel: FiltersPropertiesViewModel
    
    @Environment(\.editMode) private var editMode
    
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
            /*
            if store.purchasedSubscriptions.count <= 0 &&
                pageSettings.filters.filterList.count > 3 &&
                optionSettings.addingNodesPromptSubscription == false
            {
                Section(header: Text("Subscription Note"))
                {
                    Text("This screen is locked when more than 3 nodes are used for compositing. Please consider getting a Subscription if you require more than 3 nodes. You can also delete some nodes on the Pipeline to continue.").foregroundColor(.gray).font(.system(size: 14))
                }
            }
            */
            
            Section(header:
                EditButton().frame(maxWidth: .infinity, alignment: .trailing)
                    .overlay(Text("Nodes"), alignment: .leading)
                    ,footer:Text("Filter nodes are composited from top to bottom. Node 0 is the original image. Long press on the yellow socket to set the Viewer temporarily.")
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
                                        .environmentObject(pageSettings)
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
                                                            print("Secret Long Press Action!",filterXHolder.filter.nodeIndex)
                                                            pageSettings.setViewer(filterXHolder: filterXHolder)
                                                            }
                                                        )
                                HStack{
                                    if pageSettings.getViewerNodeIndex() == filterXHolder.filter.nodeIndex
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
                                                                        print("Secret Long Press Action!",filterXHolder.filter.nodeIndex)
                                                                        pageSettings.setViewer(filterXHolder: filterXHolder)
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
                            }
              
               
                       

                    }
                     

                }
                .onDelete(perform: onDelete)
                .onMove(perform: move)
            }
            }//.disabled(store.purchasedSubscriptions.count <= 0 &&
             //          pageSettings.filters.filterList.count > 3)

            /*
            if store.purchasedSubscriptions.count <= 0 &&
                pageSettings.filters.filterList.count > 3 &&
                optionSettings.addingNodesPromptSubscription == true
            {
                Section(header: Text("Subscription Note"))
                {
                    Text("This screen is locked when more than 3 nodes are used for compositing. Please consider getting a Subscription if you require more than 3 nodes. You can also delete some nodes on the Pipeline to continue.").foregroundColor(.gray).font(.system(size: 14))
                }
            }
            */
            
            FiltersEditViewX(filtersPropertiesViewModel: filtersPropertiesViewModel)
                .environmentObject(pageSettings)
                .environmentObject(optionSettings)
                //.environmentObject(shapes)
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
            ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        /*
                        shapes.shapeList.forEach
                        {
                                $0.isSelected = false
                        }
                        */
                        print("Page Properties Off")
                        pageSettings.resetViewer()
                        optionSettings.showPropertiesView=0
                        optionSettings.showPagePropertiesView=0
                        optionSettings.pagePropertiesHeight=95
                        appSettings.zoomFactor = appSettings.zoomFactor * 1.0/0.999
                    }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Help") {
                    //shapes.deSelectAll();
                    optionSettings.action = "NodefHelpPipeline"
                    optionSettings.showPropertiesSheet = true
                }
 
            }
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
    
    func move(from source: IndexSet, to destination: Int) {
        //items.move(fromOffsets: source, toOffset: destination)
        self.filtersPropertiesViewModel.filters.filterList.move(fromOffsets: source, toOffset: destination)
        self.filtersPropertiesViewModel.filters.reassignIndex()
        self.applyFilter()

    }
    
    private func onDelete(offsets: IndexSet) {
        //items.remove(atOffsets: offsets)
        self.filtersPropertiesViewModel.filters.filterList.remove(atOffsets: offsets)
        self.filtersPropertiesViewModel.filters.reassignIndex()
        self.applyFilter()

    }

    func applyFilter() {
        if filtersPropertiesViewModel is BackgroundFiltersPropertiesViewModel
        {
            pageSettings.applyFilters()
        }
        /*
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
         */
    }

    func setupViewModel()
    {
        optionSettings.addingNodesPromptSubscription = false
        //print(store.purchasedSubscriptions.first?.id!=="nodefbasefilterspid")
        //print("edit:",editMode?.wrappedValue.isEditing)

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
     
}

