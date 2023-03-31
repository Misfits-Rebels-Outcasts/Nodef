//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

@available(iOS 15.0, *)
struct PhotoMainPropertiesViewX: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
   
    /*
    init()
    {
        print("PhotoMainPropertiesViewX init")
        print(optionSettings.showPagePropertiesView)
    }
     */
    @EnvironmentObject var optionSettings: OptionSettings
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var pageSettings: PageSettings
    @EnvironmentObject var shapes: ShapesX
    @EnvironmentObject var dataSettings: DataSettings
    //@EnvironmentObject var store: Store

    //@State private var selectionx:Int? = 1
    //@State private var selectedItem: String? = "Add"
    var body: some View {
        VStack{
            /*
            if optionSettings.showPropertiesView == 2
            {
                ForEach(shapes.shapeList){
                    shape in
                    if shape.isSelected == true && shape is TextX
                    {
                        TextPropertiesViewX(textPropertiesViewModel:  TextPropertiesViewModel(shapes: shapes))
                    }
                }
            }
            else if optionSettings.showPropertiesView == 3
            {
                ForEach(shapes.shapeList){
                    shape in
                    if shape.isSelected == true && (shape is RectangleX || shape is EllipseX)
                    {
                        ShapePropertiesViewX(shapePropertiesViewModel: ShapePropertiesViewModel(shapes: shapes))
                    }
                }
            }
            else if optionSettings.showPropertiesView == 4
            {
                ForEach(shapes.shapeList){
                    shape in
                    if shape.isSelected == true && shape is QRCodeX
                    {
                        QRCodePropertiesViewX(qrcodePropertiesViewModel:  QRCodePropertiesViewModel(shapes: shapes))
                    }
                }
            }
            else if optionSettings.showPropertiesView == 5
            {
                ForEach(shapes.shapeList){
                    shape in
                    if shape.isSelected == true && shape is BarcodeX
                    {
                        BarcodePropertiesViewX(barcodePropertiesViewModel:  BarcodePropertiesViewModel(shapes: shapes))
                    }
                }
            }
            else if optionSettings.showPropertiesView == 6
            {
                ForEach(shapes.shapeList){
                    shape in
                    if shape.isSelected == true && shape is ImageX
                    {
                        ImagePropertiesViewX(imagePropertiesViewModel:  ImagePropertiesViewModel(shapes: shapes))
                    }
                }
            }
            else
            {
                VStack (alignment: .trailing)
                {
                    HStack{
                        PhotoToolbarViewX()
                    }.frame(height: horizontalSizeClass == .regular && verticalSizeClass == .regular ? 85 : 85)
              
                }.frame(height: horizontalSizeClass == .regular && verticalSizeClass == .regular ? 85 : 85)
            }
             */
            if optionSettings.showPagePropertiesView == 1
            {
                /*
                FiltersViewA(filtersPropertiesViewModel: BackgroundFiltersPropertiesViewModel(pageSettings: pageSettings))
                               //.environmentObject(appSettings)
                               //.environmentObject(optionSettings)
                               .environmentObject(pageSettings)
                               //.environmentObject(dataSettings)
                               //.environmentObject(shapes)
                 */
                //Porting to NavigationStack causes issue
                /*
                NavigationView {
                    NavigationLink(destination:
                        Text("Detail")
                                   
                    )
                    {
                        Text("Node")
                    }
                    //.isDetailLink(false)
                    
                }.navigationViewStyle(.stack)
                 */
                
                NavigationView {

                    FiltersViewX(filtersPropertiesViewModel: BackgroundFiltersPropertiesViewModel(pageSettings: pageSettings))
                                   .environmentObject(appSettings)
                                   .environmentObject(optionSettings)
                                   .environmentObject(pageSettings)
                                   //.environmentObject(store)
                                   //.environmentObject(dataSettings)
                                   //.environmentObject(shapes)
                              
                                   
                }
                .navigationViewStyle(.stack)
                
   

               
                
                 /*
                //NavigationView {
                    Form{
                        VStack (alignment: .leading)
                        {
                            PresetsCategoriesViewX()
                                .environmentObject(pageSettings)
                            
                            PresetsViewX()
                        }
                        Section(header: Text(""), footer: Text("")){
                        }
                    }
                    //.navigationTitle("Filter Node Editor")
                    //.navigationBarTitleDisplayMode(.inline)
                //}.navigationViewStyle(.stack)
                  */
            }
            else if optionSettings.showPagePropertiesView == 2
            {

                NavigationView {
                    PresetsViewX()
                        .environmentObject(pageSettings)                    
                        .environmentObject(appSettings)
                        .environmentObject(optionSettings)
                }
                .navigationViewStyle(.stack)
                  
            }
            else
            {

                VStack (alignment: .leading)
                {


                    if UIApplication.shared.keyWindow!.safeAreaInsets.bottom > 0 {
                        HStack{
                            PhotoToolbarViewX()
                            .environmentObject(appSettings)
                            .environmentObject(optionSettings)
                            .environmentObject(pageSettings)
                            .environmentObject(dataSettings)
                            .environmentObject(shapes)

                        }.padding([.top, .bottom],5)


                    }
                    else{
                        //support device with buttons
                        HStack{
                          PhotoToolbarViewX()
                          .environmentObject(appSettings)
                          .environmentObject(optionSettings)
                          .environmentObject(pageSettings)
                          .environmentObject(dataSettings)
                          .environmentObject(shapes)

                      }.padding([.top],15)
                    }

         
                }
               
                
            }
        
        }.onAppear(perform: setupViewModel)
   
           .frame(height: optionSettings.pagePropertiesHeight) //so as to extend beyond the bottomn toolbar
        
    }
    
    func generatePresets()
    {
        var type="Photo Effects"
        print("test",type)
        //pageSettings.presets = PresetsX(presetType: type)
    }
    
    func setupViewModel()
    {
        optionSettings.selectedItem="Add"
        

    }

}
