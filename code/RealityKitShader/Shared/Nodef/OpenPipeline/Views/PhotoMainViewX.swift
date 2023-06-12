//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins
import UniformTypeIdentifiers

@available(iOS 15.0, *)

struct PhotoMainViewX: View {

    @EnvironmentObject var pageSettings: PageSettings
   
    
    var body: some View {
        
        PhotoARContainerView()

    }

}
