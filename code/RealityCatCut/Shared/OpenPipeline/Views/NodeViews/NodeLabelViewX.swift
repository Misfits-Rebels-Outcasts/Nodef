//
//  Copyright © 2022-2023 James Boo. All rights reserved.
//


import SwiftUI
//ANCHISES
struct NodeLabelViewX: View {
    
    var filterXHolder: FilterXHolder
    
    @EnvironmentObject var optionSettings: OptionSettings
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var pageSettings: PageSettings
    @StateObject var filtersPropertiesViewModel: FiltersPropertiesViewModel
    
    @GestureState var isDetectingLongPress = false
    //@State var completedLongPress = false
    
    var addingNodes = false

    var longPress: some Gesture {
        LongPressGesture(minimumDuration: 3)
            .updating($isDetectingLongPress) { currentState, gestureState,
                transaction in
                gestureState = currentState
            }
            .onEnded { value in
                setViewer(filterXHolder: filterXHolder)
            }
    }
    

    var body: some View {
        
        VStack{
            HStack{
                Text(filterXHolder.filter.getNodeNameFX()).font(.system(size: 14))
                Spacer()
            }
            //not used somehow it is different
            //.gesture(longPress)
            .gesture(LongPressGesture (minimumDuration: 0.5)
                .updating ($isDetectingLongPress) { currentState, gestureState,
                    transaction in
                    gestureState = currentState
                }
                .onEnded { value in
                    setViewer(filterXHolder: filterXHolder)
                    
                }
            )
             
            HStack{
                if currentNodeSelected(filterXHolder: filterXHolder)
                {
                    Image(systemName: "circle.fill")
                        .font(.system(size: 8))
                        .foregroundColor(.blue)
                        //.gesture(longPress)
                    
                        .gesture(LongPressGesture (minimumDuration: 0.5)
                            .updating ($isDetectingLongPress) { currentState, gestureState,
                                transaction in
                                gestureState = currentState
                                
                                
                            }
                            .onEnded { value in
                                setViewer(filterXHolder: filterXHolder)
                            }
                        )
                     
                }
                else
                {
                    Image(systemName: "circle.fill")
                        .font(.system(size: 8))
                        .foregroundColor(.yellow)
                        //.gesture(longPress)
                    
                        .gesture(LongPressGesture (minimumDuration: 0.5)
                            .updating ($isDetectingLongPress) { currentState, gestureState,
                                transaction in
                                gestureState = currentState
                                
                                
                            }
                            .onEnded { value in
                                setViewer(filterXHolder: filterXHolder)
                            }
                        )
                     
                }
                
                Text(filterXHolder.filter.getDisplayNameFX()).font(.system(size: 14))
                
                Spacer()
            }
            HStack{
                Text(filterXHolder.filter.getDisplayName())
                if filterXHolder.filter.duration == .zero ||
                    filterXHolder.filter.nodeType == "AR" {
                    
                } else {
                    if filterXHolder.filter.videoStatus == "Completed"  {
                        Image(systemName: "checkmark")
                            .font(.system(size: 12))
                            .foregroundColor(.green)
                            .bold()
                    } else {
                        Image(systemName: "checkmark")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                            .bold()
                    }
                }
                
                /*
                if filterXHolder.filter.videoStatus == "Completed" ||
                    filterXHolder.filter.duration == .zero ||
                    filterXHolder.filter.nodeType == "AR"
                {
                    Image(systemName: "checkmark")
                        .font(.system(size: 12))
                        .foregroundColor(.green)
                        .bold()
                } else {
                    Image(systemName: "checkmark")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                        .bold()
                }
                 */
                Spacer()
            }
            
        }
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
            return false
        }
        return false
    }
    
    
    func setViewer(filterXHolder: FilterXHolder) {
        
        print("Secret Long Press Action!",filterXHolder.filter.nodeIndex, filtersPropertiesViewModel.filters.viewerIndex)
        
        if filtersPropertiesViewModel is BackgroundFiltersPropertiesViewModel
        {
            pageSettings.setViewer(filterXHolder: filterXHolder)
        }
        else if filtersPropertiesViewModel is ImageFiltersPropertiesViewModel
        {
        }
        
    }
    
}

