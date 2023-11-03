//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

@available(iOS 15.0, *)
struct HelpViewX: View {

    @EnvironmentObject var optionSettings: OptionSettings
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Overview"))
                {
                    Group{
                        /*
                        Text("Nodef").italic()+Text(" is a powerful node-based image filter compositor with 150+ filters and effects. It uses an innovative Node Pipeline editor to enable a productive, flexible, and complete node graph compositing experience on a mobile device.")
                         
                         Nodef
                         
                         */
                        Text("Nodef").italic()+Text(" Pipeline is an open-source digital compositing and graphics post-processing Pipeline for photos, images, shaders, animations (coming soon) procedural textures (coming soon), and videos (coming soon).")

                    }
                    .padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))
                    
                    
                    HStack{
                        //Link(destination: URL(string:
                        //                        "https://github.com/Misfits-Rebels-Outcasts/Nodef/blob/main/documentation/NodePipeline.md")!) {
                        //    Text("Node Pipeline")
                        //}
                        Spacer()
                        
                        Link(destination: URL(string: "https://github.com/Misfits-Rebels-Outcasts/Nodef")!) {
                            Text("Open Source")
                        }
                        
                    }
                    
                }
                
                Section(header: Text("Presets"))
                {
                    Text("The Presets screen contains many samples which you can try on to understand more about filter compositing. To bring up this screen, simply tap on the filters (3 circles) icon on the bottom toolbar.")
                        .padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))
                    
                    Image("HelpPresetsToolbar")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(EdgeInsets(top: 15, leading: 35, bottom: 15, trailing: 35))
                    
                    Text("In the Presets screen, tap on any of the presets to apply it to our image.")
                        .padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))
                    
                    Image("HelpPresets")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(EdgeInsets(top: 15, leading: 35, bottom: 15, trailing: 35))
                    
                    Text("We can tap on the 'Edit' button to customize the preset with the Pipeline (node graph) screen.")
                        .padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))
                    
                }
                
                Section(header: Text("Pipeline"))
                {
                    Text("The Pipeline screen contains a pipeline of filter nodes (node graph) to apply on the image. You can bring up this screen by tapping on the 'f' (filters) button on the bottom toolbar of the app.")
                        .padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))
                    Image("HelpToolbar")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(EdgeInsets(top: 15, leading: 35, bottom: 15, trailing: 35))
                    
                }
                
            }
            .navigationTitle("Overview")
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
