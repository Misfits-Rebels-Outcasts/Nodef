//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

struct PhotoViewX: View {
    
    @EnvironmentObject var optionSettings: OptionSettings
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var pageSettings: PageSettings
    @EnvironmentObject var dataSettings: DataSettings

    
    var body: some View {
        
        ZStack {
            Image(uiImage: pageSettings.filteredBackgroundImage!)
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .scaledToFit()
                //.scaledToFill()
            /*
            ForEach(shapes.shapeList){
                shape in
                
                if optionSettings.highPerformancePrinting == true && shape.type == "Barcode"
                {
                    //ShapeViewX(shape: shape, showPropertiesView: $optionSettings.showPropertiesView)
                }
                else if optionSettings.highPerformancePrinting == false && shape.type == "Barcode"
                {
                    ShapeViewX(shape: shape, dataSettings: dataSettings,
                               pageSettings: pageSettings,
                               appSettings: appSettings,
                               showPropertiesView: $optionSettings.showPropertiesView)
                }
                else
                {
                    ShapeViewX(shape: shape, dataSettings: dataSettings,
                               pageSettings: pageSettings,
                               appSettings: appSettings,
                               showPropertiesView: $optionSettings.showPropertiesView)
                    
                }
                
            }
            */
        }
        .background(Color.white)
        .onTapGesture {
            /*
            shapes.shapeList.forEach
            {
                if ($0.isSelected == true)
                {
                    print("set false")
                    $0.isSelected = false
                }
            }
            */
            print("Page Properties Off")
            pageSettings.resetViewer()
            optionSettings.showPropertiesView=0
            optionSettings.showPagePropertiesView=0
            optionSettings.pagePropertiesHeight=95
            
            appSettings.zoomFactor = appSettings.zoomFactor * 1.0/0.999

        }
        .clipShape(Rectangle())
        //.gesture(pressGesture)

    }
    
    
}

/*
extension UIHostingController {
    convenience public init(rootView: Content, ignoreSafeArea: Bool) {
        self.init(rootView: rootView)
        
        if ignoreSafeArea {
            disableSafeArea()
        }
    }
    
    func disableSafeArea() {
        guard let viewClass = object_getClass(view) else { return }
        
        let viewSubclassName = String(cString: class_getName(viewClass)).appending("_IgnoreSafeArea")
        if let viewSubclass = NSClassFromString(viewSubclassName) {
            object_setClass(view, viewSubclass)
        }
        else {
            guard let viewClassNameUtf8 = (viewSubclassName as NSString).utf8String else { return }
            guard let viewSubclass = objc_allocateClassPair(viewClass, viewClassNameUtf8, 0) else { return }
            
            if let method = class_getInstanceMethod(UIView.self, #selector(getter: UIView.safeAreaInsets)) {
                let safeAreaInsets: @convention(block) (AnyObject) -> UIEdgeInsets = { _ in
                    return .zero
                }
                class_addMethod(viewSubclass, #selector(getter: UIView.safeAreaInsets), imp_implementationWithBlock(safeAreaInsets), method_getTypeEncoding(method))
            }
            
            objc_registerClassPair(viewSubclass)
            object_setClass(view, viewSubclass)
        }
    }
}

extension CGSize {
    static func * (size: CGSize, value: CGFloat) -> CGSize {
        return CGSize(width: size.width * value, height: size.height * value)
    }
}
*/
