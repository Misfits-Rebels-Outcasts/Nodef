//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI
//import Combine
@available(iOS 15.0, *)
struct PhotoViewX: View {
    
    @EnvironmentObject var optionSettings: OptionSettings
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var pageSettings: PageSettings

                     
    var body: some View {
        
        ZStack {
            /*
            switch pageSettings.imageState {
                case .success(let image):
                    Image(uiImage: pageSettings.filteredBackgroundImage!)
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                        .scaledToFit()
                case .loading:
                    ProgressView().colorInvert()
                case .empty:
                    EmptyView()
                case .failure:
                    EmptyView()
            }
             */
            Image(uiImage: pageSettings.filteredBackgroundImage!)
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .scaledToFit()
            
            if pageSettings.savingInProgress
            {
                ProgressView().foregroundColor(.black).scaleEffect(5)
            }

            
        }
        .background(Color.white)
        .onTapGesture {

                print("Page Properties Off - PV")
                pageSettings.resetViewer()
                optionSettings.skipScrollingX = true
                optionSettings.skipScrollingY = true
                optionSettings.showPropertiesView=0
                optionSettings.showPagePropertiesView=0
                optionSettings.pagePropertiesHeight=95
                appSettings.zoomingOrScrollX = "zoomIn"
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
