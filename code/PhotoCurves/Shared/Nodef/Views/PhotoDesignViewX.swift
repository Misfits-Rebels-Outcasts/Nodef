//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI
@available(macOS 12.0, *)
@available(iOS 15.0, *)
struct PhotoDesignViewX: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    
    //@Binding var showPropertiesView: Int
    //@Binding var imageViewSize: CGSize
    
    @State private var offsetX = CGFloat.zero
    @State private var offsetY = CGFloat.zero
    
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var optionSettings: OptionSettings
    @EnvironmentObject var pageSettings: PageSettings


    //@State private var scale: CGFloat = 0.4
    //@State private var lastScale: CGFloat = 1.0
    //@State private var viewState = CGSize.zero
    
    /*manification commented out as not good enough*/
    /*
    @State private var currentAmount = 0.0
    @State private var finalAmount = 0.4
    */
    
    var photoViewX: some View {
        PhotoViewX()
        .frame(width: pageSettings.labelWidth*appSettings.dpi, height: pageSettings.labelHeight*appSettings.dpi, alignment: .center)
        .scaleEffect(appSettings.zoomFactor)
        .environmentObject(pageSettings)
        .environmentObject(appSettings)
    }


    var body: some View {
        
        
        GeometryReader { geometry in
            VStack(spacing:0){

                PhotoRulerHViewX(offsetX: $offsetX, rulerWidth: geometry.size.width)
                    .frame(width: geometry.size.width, height: horizontalSizeClass == .regular && verticalSizeClass == .regular ? appSettings.HRulerWidthRegular*72.0 : appSettings.HRulerWidth*72.0, alignment: .topLeading)
                    .border(Color.gray)
                    .padding(0)
                 
                HStack(spacing:0)
                {
                    
                    PhotoRulerVViewX(offsetY: $offsetY, rulerHeight: geometry.size.height)
                        .frame(width: horizontalSizeClass == .regular && verticalSizeClass == .regular ? appSettings.VRulerWidthRegular*72.0 : appSettings.VRulerWidth*72.0, height: geometry.size.height, alignment: .leading)
                        .border(Color.gray)
                        .padding(0)
                     
                    VStack(spacing:0){
                        ScrollView([.horizontal, .vertical]) {
                           
                                VStack {
                                    /*
                                    ARViewContainer()
                                        .environmentObject(pageSettings)
                                        .frame(height: 400)
                                     */
                                    
                                    photoViewX
 
                                    /*
                                    PhotoViewX()
                                    .frame(width: pageSettings.labelWidth*appSettings.dpi, height: pageSettings.labelHeight*appSettings.dpi, alignment: .center)
                                    .scaleEffect(appSettings.zoomFactor)
                                    .environmentObject(dataSettings)
                                    .environmentObject(pageSettings)
                                    .environmentObject(appSettings)
                                     */
                                }
                                .frame(width: pageSettings.labelWidth*appSettings.dpi*appSettings.zoomFactor, height: pageSettings.labelHeight*appSettings.dpi*appSettings.zoomFactor, alignment: .center)
                                .background(Color.white)
                                .background(GeometryReader {
                                      Color.clear.preference(key: ViewOffsetKeyY.self,
                                        value: $0.frame(in: .named("scroll")).origin.y)
                                    Color.clear.preference(key: ViewOffsetKeyX.self,
                                        value: $0.frame(in: .named("scroll")).origin.x)
                                })
                                .onPreferenceChange(ViewOffsetKeyY.self) { newValue in
                                    //comeback
                            
 
                                    //DispatchQueue.main.async(execute: {
                                        let rulerThickness = horizontalSizeClass == .regular && verticalSizeClass == .regular ? appSettings.VRulerWidthRegular*72.0 : appSettings.VRulerWidth*72.0
                                        let labelHeight = pageSettings.labelHeight*appSettings.dpi*appSettings.zoomFactor
                                        let availableHeight = geometry.size.height - rulerThickness
                                        if offsetY != 0.0 ||
                                            appSettings.zoomingOrScrollY == "scroll" ||
                                            appSettings.zoomingOrScrollY == "zoomIn" ||
                                            (appSettings.zoomingOrScrollY == "zoomOut" &&
                                             offsetY == 0.0 &&
                                             labelHeight <= availableHeight)
                                        {
                                            offsetY=newValue//$0
                                            print("assigned new valueY",availableHeight,UIScreen.main.bounds.size.height,appSettings.zoomingOrScrollY)
                                            
                                        }
                                        appSettings.zoomingOrScrollY = "scroll"
                                        print("scroll Y done")

                                        
                                        //}
                                    //})
                                }
                                .onPreferenceChange(ViewOffsetKeyX.self) { newValue in
                                    //comeback
                                    //DispatchQueue.main.async(execute: {
       

                                        let rulerThickness = horizontalSizeClass == .regular && verticalSizeClass == .regular ? appSettings.VRulerWidthRegular*72.0 : appSettings.VRulerWidth*72.0
                                        let labelWidth = pageSettings.labelWidth*appSettings.dpi*appSettings.zoomFactor
                                        let availableWidth = geometry.size.width - rulerThickness
                                        
                                        if offsetX != 0.0 ||
                                            appSettings.zoomingOrScrollX == "scroll" ||
                                            appSettings.zoomingOrScrollX == "zoomIn" ||
                                            (appSettings.zoomingOrScrollX == "zoomOut" &&
                                             offsetX == 0.0 &&
                                             labelWidth <= availableWidth)
                                        {
                                            offsetX=newValue//$0
                                            print("assigned new valueX",availableWidth,UIScreen.main.bounds.size.width,appSettings.zoomingOrScrollX)
                                        }
                                        appSettings.zoomingOrScrollX = "scroll"
                                        print("scroll X done")

                                        
                                        //}
                                    //})
                                }

                        }
                        .coordinateSpace(name: "scroll")
                        .background(Color.gray)
                        .onTapGesture {
                            //comeback
                            //DispatchQueue.main.async(execute: {
 
                                //comeback
                                print("Page Properties Off - PD")
                                pageSettings.resetViewer()
                    
                                optionSettings.showPropertiesView=0
                                optionSettings.showPagePropertiesView=0
                                optionSettings.pagePropertiesHeight=95
                                
                  
                                appSettings.zoomFactor = appSettings.zoomFactor * 1.0/0.999
                                 
                            //})
                        }
                    }
                    .frame(height: geometry.size.height, alignment: .leading)

                    
                }.padding(0)
            }
        }
    }
}
/*
struct ViewOffsetKeyY: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

struct ViewOffsetKeyX: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
*/
/*
extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}
*/
