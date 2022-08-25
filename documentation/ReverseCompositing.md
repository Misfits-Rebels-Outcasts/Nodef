 # Reverse Compositing

 The auto chaining, or automatic preceding node referencing, behavior can be altered by the user by changing the properties of a node. For example, the node 4 (Color Correction) below can be modified to use node 1 as the input instead of the automatically assigned preceding node.
 
     1. Read media       (none)  >
     2. Premult          (1)     >
 
     3. Read media       (none)  >
     4. Color Correction (3)     >
     5. Gaussian Blur    (4)     >
     6. Transform        (5)     >
 
 to
 
     1. Read media       (none)  >
     2. Premult          (1)     >
 
     3. Read media       (none)  >
     4. Color Correction ("1")   >
     5. Gaussian Blur    (4)     >
     6. Transform        (5)     >

 Double quotes, as shown above, or other mechanisms such as color coding, can be used to indicate an altered node on the pipeline.
 
 To change what node 4 (Color Correction) uses as an input node, we just tap on it on the pipeline and then change its input node property.
 
     -----------------------------------------------------------
     Node 4 (Color Correction Properties)
 
     Input Node :   > Preceding Node
                    > Node 0
                    > Node 1
                    > Node 2
                    > Node 3
     .
     .
     .
     -----------------------------------------------------------

The input nodes can be from a selection of all available nodes. On top of that, one of the Input Node choices can be a "Preceding Node" which will allow the software to automatically link to the previous preceding node as described in the section on Auto Chaining. Instead of link nodes by drawing lines, we now link nodes by referencing a previous node in the target node, or depend on Auto Chaining to automatically link the nodes quickly. We call this process of referencing the input nodes in the target node 'Reverse Compositing'.

Expaning on the idea of the previous section, merging can be achieved by selecting multiple input nodes. For example, if we tap on node 7 below,
  
    1. Read media       (none)  >
    2. Premult          (1)     >
 
    3. Read media       (none)  >
    4. Color Correction (3)     >
    5. Gaussian Blur    (4)     >
    6. Transform        (5)     >
  
    7. Merge            (2,6)   >
    8. Viewer           (7)     >
  
We can specify the nodes to merge:

     -----------------------------------------------------------
     Node 7 (Merge Properties)
 
     Input Node A :   > Preceding Node
                      > Node 0
                      > Node 1
                      > Node 2
                      > Node 3
                      
     Input Node B :   > Preceding Node
                      > Node 0
                      > Node 1
                      > Node 2
                      > Node 3
                      
     .
     .
     .
     -----------------------------------------------------------
 
This idea can be expanded to nodes requiring more than 2 input nodes, for example, nodes with masks. Furthermore, it the idea can be expanded to link node properties.


 
