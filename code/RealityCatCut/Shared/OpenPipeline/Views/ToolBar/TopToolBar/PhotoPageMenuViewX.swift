//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI
import ContactsUI
              
@available(iOS 15.0, *)
struct PhotoPageMenuViewX: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var optionSettings: OptionSettings
    @EnvironmentObject var pageSettings: PageSettings

    
    
    var shapeFactor = 3.0

    
    var body: some View {
        Menu {
            Menu {
            /*
                Button(action: {
                    shapes.deSelectAll();
                                    
                    var w=200.0*shapeFactor, h=100.0*shapeFactor
                    w = w < pageSettings.labelWidth*appSettings.dpi ? w : pageSettings.labelWidth*appSettings.dpi - 50.0
                    h = h < pageSettings.labelHeight*appSettings.dpi ? h : pageSettings.labelHeight*appSettings.dpi - 50.0
                    w = w < 30 ? 30 : w
                    h = h < 30 ? 30 : h
                    print(w,":",h)
                    
                    let shape = RectangleX(
                        appSettings.dpi,
                        CGPoint(x:pageSettings.labelWidth*appSettings.dpi/2,y:pageSettings.labelHeight*appSettings.dpi/2),
                        CGSize(width: w, height: h),
                        CGSize(width: pageSettings.labelWidth*appSettings.dpi, height: pageSettings.labelHeight*appSettings.dpi),
                        true)
                    
                    shapes.add(shape: shape)
                }) {
                    Label("Add Rectangle", systemImage: "rectangle")
                }
                
                Button(action: {
                    var w=200.0*shapeFactor, h=100.0*shapeFactor
                    w = w < pageSettings.labelWidth*appSettings.dpi ? w : pageSettings.labelWidth*appSettings.dpi - 50.0
                    h = h < pageSettings.labelHeight*appSettings.dpi ? h : pageSettings.labelHeight*appSettings.dpi - 50.0
                    w = w < 30 ? 30 : w
                    h = h < 30 ? 30 : h
                    print(w,":",h)
                    shapes.deSelectAll();
                    
                    let shape = EllipseX(
                            appSettings.dpi,
                            CGPoint(x:pageSettings.labelWidth*appSettings.dpi/2,y:pageSettings.labelHeight*appSettings.dpi/2),
                            CGSize(width: w, height: h),
                            CGSize(width: pageSettings.labelWidth*appSettings.dpi, height: pageSettings.labelHeight*appSettings.dpi),
                            true)
                    
                    shapes.add(shape: shape)
                }) {
                    Label("Add Ellipse", systemImage: "circle")
                }
                Button(action: {
                    
                    var w=300/2.0*shapeFactor, h=300/2.0*shapeFactor
                    w = w < pageSettings.labelWidth*appSettings.dpi ? w : pageSettings.labelWidth*appSettings.dpi - 50.0
                    h = h < pageSettings.labelHeight*appSettings.dpi ? h : pageSettings.labelHeight*appSettings.dpi - 50.0
                    w = w < 30 ? 30 : w
                    h = h < 30 ? 30 : h
                    print(w,":",h)
                    
                    shapes.deSelectAll();
                    let shape = ImageX(
                            appSettings.dpi,
                            CGPoint(x:pageSettings.labelWidth*appSettings.dpi/2,y:pageSettings.labelHeight*appSettings.dpi/2),
                            CGSize(width: w, height: h),
                            CGSize(width: pageSettings.labelWidth*appSettings.dpi, height: pageSettings.labelHeight*appSettings.dpi),
                            true)
                    
               
                    
                    shapes.add(shape: shape)
     
                    
                    optionSettings.action = "NewImage"
                    optionSettings.showPropertiesSheet = true
                }) {
                    Label("Add Image", systemImage: "photo")
                }

                Button(action: {
                    var w=200.0*shapeFactor, h=100.0*shapeFactor
                    w = w < pageSettings.labelWidth*appSettings.dpi ? w : pageSettings.labelWidth*appSettings.dpi - 50.0
                    h = h < pageSettings.labelHeight*appSettings.dpi ? h : pageSettings.labelHeight*appSettings.dpi - 50.0
                    w = w < 30 ? 30 : w
                    h = h < 30 ? 30 : h
                    print(w,":",h)

                    
                    shapes.deSelectAll();
                    
                    let shape = TextX(
                            appSettings.dpi,
                            CGPoint(x:pageSettings.labelWidth*appSettings.dpi/2,y:pageSettings.labelHeight*appSettings.dpi/2),
                            CGSize(width: w, height: h),
                            CGSize(width: pageSettings.labelWidth*appSettings.dpi, height: pageSettings.labelHeight*appSettings.dpi),
                            true)
                    
                    shapes.add(shape: shape)
                }) {
                    Label("Add Text", systemImage: "textformat.abc")
                }
             */
            }
            label: {
                Label("Experimental", systemImage: "rectangle.and.pencil.and.ellipsis")
            }

            
        }
        label: {
            Label("Captions Overlay", systemImage: "rectangle.and.pencil.and.ellipsis")
        }

     
    }

}
