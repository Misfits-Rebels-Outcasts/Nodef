# Node-based Compositing on Mobile

Node-based Compositing is the process of combining multiple seemingly simple nodes to render and achieve a desired result. This process has wide applications in the graphics software industry, especially in procedural image generation, motion graphics, animation, 3D modeling, and visual effects VFX.

The paradigm of a node-based tool involves linking basic media objects onto a procedural map or node graph and then intuitively laying out each of the steps in a sequential progression of inputs and outputs. Any parameters from an earlier step can be modified to change the final outcome, with the results instantly being visible to you, and each of the nodes, being procedural, can be easily reused, saving time and effort.

To visualize what it looks like, the user interface of a node compositing software is shown below. Videos or images are first read in and then processed by  a sequence of operations before being merge into one final outcome. The sequence of operations, the node graph - Directed Acyclic Graph (DAG), is represented by a flowchart.

     Read media  Read media
     |           |     
     V           V     
     Premult     Color Correction
     |           |
     |           V
     |           Transform
     |           |
     |           V
     |           Gaussian Blur
     |           |
     V           V
         Merge
           |
           V
         Viewer

As the number of nodes increases, the node graph, together with a large monitor screen, provides an overview of what is happening while also enabling one to focus on a particular progression step (node) and make changes to that step to achieve the end results.
 
### The Small Screen Problem on mobile
 
On a mobile device, a pure node-based app is not common. Resource constraint is one limiting issue. Putting that aside, since mobile has come a long way, with mobile chips enabling one to do many advanced image and video capabilities, the other limiting issue is the small screen size of a mobile device for displaying the node-based user interface.
 
As a start, the arrangement of the multiple node properties screen, the node graph, the dope sheet, and the curve editor together in one small screen presents a problem. Compositing a node graph with a flowchart-like user interface is also more difficult especially when trying to connect nodes while panning the small screen frequently. This is made worst when you need to connect to a distant node with multiple inputs; or if you need to link node properties, which may involve the timeline, for tracking, animating objects, or rotoscoping.
 
### Main Idea
 
A Node Pipeline is proposed to represent the node graph on a mobile device instead of using a flowchart-like user interface. 

[Node Pipeline for Node Graph](NodePipeline.md)

