# Node Pipeline for Node Graph
 
Note - Please see the [Node-based Compositing on a Mobile device](NodeBasedCompositingOnMobile.md) article for a background.
 
A node graph is commonly represented as a flowchart with a Directed Acyclic Graph (DAG) in most digital compositing software. This is shown below:
  
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
   
On a small screen mobile device, the DAG could be decomposed into multiple series of nodes shown below. 

For example, the node graph above can be represented as a **simple list** below:
  
     Read media
     |                
     V               
     Premult     

  
     Read media
     |              
     V             
     Color Correction
     |           
     V
     Transform
     |           
     V          
     Gaussian Blur      
     
     
     Merge
     |
     V
     Viewer
  
Note the break from the first series after the 'Premult' node and the second break after the 'Gaussian Blur' node. From here, we will refer to the above arrangement as a **pipeline** (or **Node Pipeline** with breaks).

This arrangement has the obvious advantage of being represented easily on a mobile device with a simple list as shown below.
  
    1. Read media         >
    2. Premult            >
  
    3. Read media         >
    4. Color Correction   >
    5. Transform          >
    6. Blur               >
  
    7. Merge 2,6          >
    8. Viewer             >
  
The lines joining the nodes could be further represented by listing the input nodes used, like using a spreadsheet formula (e.g., =SUM(A1,A2)). In the above, the 'Premult' node uses node 1 (Read media) as the input, while the 'Merge' node uses node 2 and 6. We can also represent this information on the pipeline.
    
    1. Read media       (input none)  >
    2. Premult          (input 1)     >
  
    3. Read media       (input none)  >
    4. Color Correction (input 3)     >
    5. Transform        (input 4)     >
    6. Gaussian Blur    (input 5)     >
  
    7. Merge            (input 2,6)   >
    8. Viewer           (input 7)     >
  
Simplifying it further
  
    1. Read media       (none)  >
    2. Premult          (1)     >
  
    3. Read media       (none)  >
    4. Color Correction (3)     >
    5. Transform        (4)     >
    6. Gaussian Blur    (5)     >
  
    7. Merge            (2,6)   >
    8. Viewer           (7)     >

## Implications

With the above, let's think a little further about the implications if we use a node pipeline as the user interface for managing a node graph on a small screen mobile device. 

1. A node pipeline will require a shift in thinking when you are using to manage the node graph. Instead of three parallel series of nodes in a node graph, it now has three sequences (or series) of nodes on a pipeline. The lines joining nodes in a node graph are now represented by the target node referencing input nodes. For example, node 2 references node 1 (as the input). Node 7 references node 2 and 6.

2. Mathematically, a node graph, which is a Directed Acyclic Graph, can be decomposed to the above (node pipeline) without any loss of information. This means a pipeline user interface can be as flexible as a flowchart-like node graph.
 
3. A pipeline makes it easy to navigate the node graph on a small screen as you can quickly scroll up and down the list. Tapping on any item in the list (a node) can further bring up a screen for changing node properties. This user interface should be familiar to many mobile users as it is similar to the user interface for managing mobile phone 'Settings'.

4. The contextual overload of a user frequently panning a flow-chart-like node graph on a small screen is significantly reduced. This will improve the ease of use when managing a node graph on a small screen. This is especially the case when managing a node graph that that is invovled mainly in chaining a sequence of operations.

5. The referencing model for linking nodes in a pipeline is similar to using a spreadsheet. 'Merge' below is like a formula applying to cell 2 and 6. Some desktop node-based tool users may also find this model familiar as it is similar to the 'Link-To' capability for linking properties.

     <span>7. Merge            (2,6)   ></span>

The pipeline approach leads to other interesting productivity gains in compositing on a mobile device. Please check out the following:
 
  * [Auto Chaining](AutoChaining.md) & [Reverse Compositing](ReverseCompositing.md)
  * [Viewer Cycling](ViewerCycling.md)
  * [Directed Acyclic Graph (DAG) Generation/Import](DirectedAcyclicGraphGeneration.md)
 
In the above, we will address how to join nodes by Auto Chaining and Reverse Compositing, ponder further on linking node properties, and also about setting the Viewer to a selected intermediate nodes on the pipeline.


