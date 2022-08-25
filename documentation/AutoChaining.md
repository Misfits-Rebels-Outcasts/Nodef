 # Auto chaining
  
 Each of the node in the pipeline that requires an input, is by default assumed to be automatically taking the output of the previous node. For example, below, node 4 can be assumed to be taking the output from node 3. When a node is added, this auto chaining behavior can occur automatically. This replicates the behavior of existing digital compositing software of "adding a node to the node graph by first selecting an existing node".
  
    3. Read media       (input none)  >
    4. Color Correction (input 3)     >
    5. Transform        (input 4)     >
    6. Gaussian Blur    (input 5)     >
  
 Further, if a node (New Rotate) is added between node 5 and 6, they can be automatically be joined by the software without the user doing anything.
  
    3. Read media       (input none)  >
    4. Color Correction (input 3)     >
    5. Transform        (input 4)     >
    6. New Rotate       (input 5)     >
    7. Gaussian Blur    (input 6)     >
  
  Nodes can also be easily reordered resulting in new composite. For example, we can also easily shift node 6 Gaussian Blur to occur before node 5 Transform. The software can automatically reassign the input nodes.

    3. Read media       (input none)  >
    4. Color Correction (input 3)     >
    5. Gaussian Blur    (input 4)     >
    6. Transform        (input 5)     >

  With the above, one may ask, what happens if I do not want to use the previous node as my input? Or what if, I need more than one input node such as a background or a mask. 

  Please see [Reverse Compositing](ReverseCompositing.md).
   
