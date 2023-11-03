//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

@available(iOS 15.0, *)

struct StopButtonViewX: View {
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var pageSettings: PageSettings

    var body: some View {
                
        Button(action: {
            
            if pageSettings.filters.lastNodeType() == "AR" {
                pageSettings.filters.generatedVideoURL=nil
                pageSettings.isStopped = true;
                timeElapsedX = 0.0
                pageSettings.applyFilters()

            }
            else { //Shaders
                pageSettings.isStopped = true;
                timeElapsedX = 0.0
            }
            
        }, label: {
            Image(systemName: "stop")
                .font(.system(size: 28))
                .foregroundColor(colorScheme == .dark ? Color(UIColor(red: 0.9569, green: 0.9569, blue: 0.9569, alpha: 0.5) ) : Color.black)
            
        }).foregroundColor(.black).disabled(pageSettings.isStopped || pageSettings.savingInProgress)
        
    }

}
