# Node-based Compositing on Mobile

Node-based Compositing is the process of combining multiple seemingly simple nodes to render and achieve a desirable result. This process has wide applications in the graphics software industry especially in procedural image generation, motion graphics, animation, 3D modelling, and visual effects VFX.

The paradigm of a node-based tool involves linking basic media objects into a procedural map or node graph and then intuitively laying out each of the steps in a progression from input to output. Any parameters of a node from an earlier step can be modified with the outcome automatically generated, enabling one to achieve productivity through automation, and each of the nodes, being procedural in nature, can be easily reused, saving time and effort.

To visualize what it looks like, the user interface of such a graphics software that is involved in making changes to multiple video/image source and then merging them together into one outcome is represented as a progression of steps in a node graph - Directed Acyclic Graph (DAG) is shown below:
  
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

As the number of nodes increases, the node graph, together with a large monitor screen, provides an overview of what is happening while also enabling one to focus on a particular progression step (node) and making changes to the step to achieve the desired results.
 
### The Small Screen Problem on mobile
 
On a mobile device, a pure node-based app is not common. Resource constraint is definitely a limiting issue. Putting that aside, since mobile has come a long way with mobile chips enabling one to do many of advanced image and video capabilities, the other limiting issue is the small screen size of a mobile device for displaying the node-based user interface.
 
For a start, the arrangement of the multiple node properties screen, the node graph, the dope sheet, and the curve editor together in one small screen presents a problem. Compositing with a node graph with a flow chart like user interface is also more difficult especially when trying to connect nodes while panning the small screen frequently. This is not to mention, if one is to connect to a distant node with multiple inputs. Or if one needs to link node properties, which may involve the timeline, for tracking, animating objects, or rotoscoping.
 
### Main Idea
 
A Node Pipeline is proposed to represent the node graph on a mobile device instead of using a flow chart like user interface. 

[Node Pipeline for Node Graph](NodePipeline.md)

