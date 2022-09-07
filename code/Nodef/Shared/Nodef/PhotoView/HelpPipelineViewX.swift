//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

@available(iOS 15.0, *)
struct HelpPipelineViewX: View {

    
    var body: some View {
        Form {
            
            Section(header: Text("Filters Compositing"))
            {
                Text("Compositing is the process of combining multiple seemingly simple nodes, in our case image filters, to achieve a desired composite effect. The process involves adding and compositing nodes in a node graph. In Nodef, we have designed from the ground up a 'Mobile First' Node Pipeline to streamline, simplify, and manage the node graph easily.")
                .padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))
                
                
                HStack{
                    //Link(destination: URL(string: "https://github.com/Misfits-Rebels-Outcasts/Nodef/blob/main/documentation/NodePipeline.md")!) {
                    //    Text("Node Pipeline")
                    //}
                    Spacer()
                    Link(destination: URL(string: "https://github.com/Misfits-Rebels-Outcasts/Nodef/blob/main/documentation/PhotoFiltersHelp.md")!) {
                        Text("Online Help")
                    }

                }
            }
            
            Section(header: Text("Adding Filters"))
            {
                    Text("To add filters, we select a filter node and add it to the pipeline (node graph) with the + button. The steps are illustrated by the flow of the arrows below.")
                    .padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))

                    Image("HelpAddFilter")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(EdgeInsets(top: 15, leading: 35, bottom: 15, trailing: 35))
                
                    //Text("The Color Controls node enables us to set the Brightness, Contrast and Saturation of an image. We can also add other nodes such as a Color Monochrome node that enables us to remap colors to fall within shades of a single color. Over 150 photo filter nodes are supported in the pipeline.")
                Text("The Color Controls node enables us to set the Brightness, Contrast, and Saturation of an image.")
                .padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))
            }
            
            Section(header: Text("Chaining Filters"))
            {
                //VStack{
  
                    Text("We can combine (chain) filters by adding nodes onto the pipeline sequentially. For example, we can add a Color Monochrome node and then a Gaussian Blur node.")
                    .padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))

                    Image("HelpEditor")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(EdgeInsets(top: 15, leading: 35, bottom: 15, trailing: 35))
                    
                    Text("In the above, the Original Image (Node 0) is used as an input for Color Monochrome (Node 1). The output of Color Monochrome (Node 1) is used as an input for Gaussian Blur (Node 2).")
                    .padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))

                    Image("HelpChainExplain")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(EdgeInsets(top: 15, leading: 35, bottom: 15, trailing: 35))

                    Text("The result of our filter nodes pipeline is shown below. We can add, delete and chain any number of nodes, or reorder the nodes with the Edit button.")
                    .padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))

                    Image("HelpChainOutput")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(EdgeInsets(top: 15, leading: 55, bottom: 15, trailing: 55))


                //}
            }
            
            Section(header: Text("Node Properties"))
            {
                //VStack{
                    Text("We can change node properties by tapping on a node in the pipeline to bring up the properties screen.")
                    .padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))
                    Image("HelpNodeTap")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(EdgeInsets(top: 15, leading: 35, bottom: 15, trailing: 35))
                    Text("After tapping on Node 1, we can change the Color and Intensity properties of the Color Monochrome filter.")
                    .padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))

                    Image("HelpNodeProperties")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(EdgeInsets(top: 15, leading: 35, bottom: 15, trailing: 35))

                //}
            }
            
            Section(header: Text("Compositing Filters"))
            {
                //VStack{
                    Text("We can blend two filter nodes with a Composite node. A composite node can be added by the 'ADD COMPOSITE FILTER NODE' option.")
                    .padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))
                    Image("HelpBlendFilter")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(EdgeInsets(top: 15, leading: 35, bottom: 15, trailing: 35))
                    Text("In the above, we first add a Checkerboard Generator (generates a checkerboard as its name implies) as Node 1. Next, we blend Node 1 (Checkerboard) and Node 0 (Original Image) with a Color Dodge Blend Mode filter. The following is the result of our composite.")
                    .padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))
                    Image("HelpBlendOutput")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(EdgeInsets(top: 15, leading: 55, bottom: 15, trailing: 55))
                    Text("The input images used for performing the composite (blend) filter can be set up by first tapping on the Color Dodge Blend Mode node and then changing its Input Image properties.")
                    .padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))
                    //Text("Above is the result of our blend.")
                //}
            }

            Section(header: Text("Input Image"))
            {
                //VStack{
                    Text("When we chain or composite filters, the Input Image of a node is automatically set to the preceding node. This process is known as auto-chaining. When we reorder or delete nodes, the  Input Image node used will be adjusted automatically.")
                    .padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))
                    Image("HelpPrecedingNode")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(EdgeInsets(top: 15, leading: 35, bottom: 15, trailing: 35))
                    Text("We can change the Input Image by tapping on a Node and then changing its Input Image property.")
                    .padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))
                    Image("HelpInputNode")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(EdgeInsets(top: 15, leading: 35, bottom: 15, trailing: 35))
                    Text("In the above, we can tap on 'Preceding' to select a different Node to use as the Input Image.")
                    .padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))
                    Image("HelpNodeSelection")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(EdgeInsets(top: 15, leading: 35, bottom: 15, trailing: 35))

                    Text("If we select Node 1 as the new Input Image for Node 3, the following is what we get on our pipeline. We now skip the Color Monochrome node and just apply the Gaussian Blur to Node 1.")
                    .padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))
                    Image("HelpNewNode")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(EdgeInsets(top: 15, leading: 35, bottom: 15, trailing: 35))
                    Text("The double quotes (\"1\") indicates a node specified by us instead of the automatically assigned preceding node.")
                    .padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))


  
            }
            Section(header: Text("Background Image"))
            {
                    Text("In a composite blend filter, we usually have both an Input and Background Image. As noted earlier, the Input Image, unless otherwise specified, is automatically assigned to the preceding node by default. The Background Image, on the other hand, is automatically assigned to Node 0 (Original Image) by default.")
                    .padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))
                    Image("HelpBlendFilter")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(EdgeInsets(top: 15, leading: 35, bottom: 15, trailing: 35))
                    Text("We can change the Background Image by tapping on a node and then changing its Background Image property.")
                    .padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))
                    Image("HelpBackgroundNode")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(EdgeInsets(top: 15, leading: 35, bottom: 15, trailing: 35))
                     
            }
            
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
        .navigationTitle("Node Pipeline")
        .navigationBarTitleDisplayMode(.inline)

    }
    
    func initAll()
    {

    }
}
