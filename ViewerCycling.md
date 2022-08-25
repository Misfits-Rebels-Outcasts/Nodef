# Viewer Cycling

A node graph, using a flow chart like interface on a large screen, can easily display a thumbnail on each node to render the output to aid one in visualizing the progression of steps. On top of that, one can easily set the Viewer to any of the nodes in the graph easily to understand what is going on.
 
On a device with limited screen, we can do this by setting the Viewer on the pipeline. If we imagine having the Viewer to be on top of the pipeline as on a mobile device as shown below:
  
    [
 
    Viewer
 
    ]
 
    Pipeline
 
    1. Read media       (none)  >
    2. Premult          (1)     >
    ^
    |
    Long Press
    .
    .
    .
    3. Read media       (none)  >
    4. Color Correction (3)     >
    5. Transform        (4)     >
    6. Gaussian Blur    (5)     >
 
    7. Merge            (2,6)   >
    8. Viewer           (7)     >
 
 If we "long press" on node 2, the software can automatically render the pipeline up till this node on the Viewer.
 
 One can also 'cycle' through and view the output of each node by "long pressing" on each of the node. This 'Viewer Cycling' through the nodes help visualize and understand what is going on and remove the need to pan around a flow chart like node graph to view the thumbnails ('postage stamp').
 
 This quick setting of Viewer is especially useful in our merging node in step 7. We could view the output node 2 and node 6 before 'merging' them.
 
 
