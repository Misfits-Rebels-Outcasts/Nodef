//
//  Copyright © 2022-2023 James Boo. All rights reserved.
//

import SwiftUI

struct RealityCaptureViewX: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    
    @EnvironmentObject var optionSettings: OptionSettings
    @EnvironmentObject var pageSettings: PageSettings

    var body: some View {
        VStack {
            HStack {
                /*
                Button(action: {
                    pageSettings.filters.photoARView.snapshot(saveToHDR: false) { (image) in
                        
                        let compressedImage = UIImage(data: (image?.pngData())!)
                        UIImageWriteToSavedPhotosAlbum(compressedImage!, nil, nil, nil)
                        optionSettings.showingAlertMessage=true
                        optionSettings.alertMessage="Photo saved successfully."
                    }
                }, label: {
                    Image(systemName: "camera")
                        .font(.system(size: 32))
                        .foregroundColor(.white)
                    
                })
                 */
                Spacer()
                Button(action: {
                    
                    pageSettings.filters.generatedVideoURL=nil
                    pageSettings.isStopped = true;
                    timeElapsedX = 0.0
                    pageSettings.applyFilters()
                    
                    Singleton.onLiveCamOn(showLive: false, optionSettings: optionSettings)
                    
                }, label: {
                    Image(systemName: "xmark.circle")
                        .font(.system(size: 32))
                        .foregroundColor(.white)
                    
                })
                
            }
            .padding()
            Spacer()
        }
    }
}
