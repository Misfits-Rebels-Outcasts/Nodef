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

With the above, let's think a little further about the implications if we use the above as the user interface for a node graph on a mobile device. First, it will require a (slight) shift in thinking. Instead of three parallel series of nodes in a node graph, it now has three sequences (or series) of nodes in a pipeline. The lines joining nodes in a node graph are now represented by the target node referencing input nodes. For example, node 2 uses node 1 as the input and thus references it. Node 7 references node 2 and 6.

Mathematically, the node graph, which is a Directed Acyclic Graph, can be decomposed to the above without any loss of information. This means a node pipeline can be as flexible as a flowchart-like node graph.
  
A pipeline user interface should be familiar to many mobile users as it is as simple as managing mobile phone Settings. A pipeline makes it easy to navigate the node graph on a small screen as you can quickly scroll up and down the list. Tapping on any item in the list (a node) can further bring up a screen for changing node properties. 

Most importantly, the contextual overload of a user frequently panning a flow-chart-like node graph on a small screen is significantly reduced. Of course, this productivity can only occur, when one becomes familiar with the pipeline.  

Finally, the referencing model for linking nodes in a pipeline is similar to using a spreadsheet. 'Merge' below is like a formula applying to cell 2 and 6.

    7. Merge            (2,6)   >
 
The pipeline approach leads further to other interesting productivity gains in compositing on a mobile device. Please check out the following:
 
  * [Auto Chaining](AutoChaining.md) & [Reverse Compositing](ReverseCompositing.md)
  * [Viewer Cycling](ViewerCycling.md)
  * [Directed Acyclic Graph (DAG) Generation/Import](DirectedAcyclicGraphGeneration.md)
 
In the above, we will address how to join nodes by Auto Chaining and Reverse Compositing, ponder further on linking node properties, and also about setting the Viewer to a selected intermediate nodes in the pipeline.


