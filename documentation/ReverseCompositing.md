 # Reverse Compositing

 The auto chaining, or automatic preceding node referencing, behavior can be altered by the user by changing the properties of a node. For example, node 4 (Color Correction) below can be modified to use node 1 as the input instead of the automatically assigned preceding node.
 
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

The double quotes, as shown above, or other mechanisms such as color coding, indicate an altered node on the pipeline.
 
 To change the input node of node 4 (Color Correction), we just tap on it on the pipeline and then change its input node property.
 
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

The input nodes can be selected from all available (previous) nodes. On top of that, one of the Input Node choices can be a 'Preceding Node' which will allow the software to automatically link to the previous preceding node as described in the section on Auto Chaining. Instead of linking nodes by drawing lines, we now link nodes by referencing a previous node in the target node or depend on Auto Chaining to automatically link the nodes quickly. We call this process of referencing the input nodes in the target node 'Reverse Compositing'.

We can expand on the above idea to support two or more input nodes. For example, if we tap on node 7 (Merge) below,
  
    1. Read media       (none)  >
    2. Premult          (1)     >
 
    3. Read media       (none)  >
    4. Color Correction (3)     >
    5. Gaussian Blur    (4)     >
    6. Transform        (5)     >
  
    7. Merge            (2,6)   >
    8. Viewer           (7)     >
  
we can specify the nodes to 'merge'.

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
 
We can go further and expand the above to link node properties.

Next, check out on how to set the Viewer on the pipeline with [Viewer Cycling](ViewerCycling.md).


 
