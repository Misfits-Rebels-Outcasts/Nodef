//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

@available(iOS 15.0, *)
struct HelpViewerViewX: View {

    @EnvironmentObject var optionSettings: OptionSettings
    var body: some View {
        NavigationStack {
            Form {
                
                Section(header: Text("Setting the Viewer"))
                {
                    Text("The upper portion of the app, the Viewer, displays the effect of applying all the filters on our pipeline (node graph) on the image. The Viewer can be set to display the effect of the pipeline up to a specific node. We do this by ‘long pressing’ on the yellow socket of a node on the pipeline.")
                        .padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))
                    Image("HelpViewer")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(EdgeInsets(top: 15, leading: 35, bottom: 15, trailing: 35))
                    Text("In the above, after 'long pressing' on the yellow color socket of Node 1, the Viewer displays the rendered output of Node 1 instead of the output of the entire pipeline. The yellow color socket turns blue to indicate where the Viewer is set to. The Viewer will automatically reset back to display the output of the entire pipeline when we exit the Pipeline screen.")
                        .padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))
                    
                    Text("Setting the Viewer from the top to the bottom of the pipeline, one after another enables us to view the effect of each node on our image. This can help us quickly understand the progression steps we have taken to achieve the desired result. This process is known as Viewer Cycling.")
                        .padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))
                    
                }
            }
            .navigationTitle("Node Viewer")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        optionSettings.showPropertiesView=0
                        optionSettings.showPropertiesSheet=false
                    }
                }
                
            }
        }
    }
    
    func initAll()
    {

    }
}
