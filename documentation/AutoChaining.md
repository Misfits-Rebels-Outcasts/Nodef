 # Auto chaining
  
Each of the nodes on the pipeline that requires an input is, by default, assumed to be taking the output of the previous node automatically. For example, below, the input to node 4 comes from the output of node 3. When we add a node, this auto-chaining behavior can occur automatically. This replicates the behavior of existing digital compositing software of "adding a node to the node graph by first selecting an existing node".
  
    3. Read media       (input none)  >
    4. Color Correction (input 3)     >
    5. Transform        (input 4)     >
    6. Gaussian Blur    (input 5)     >
  
Furthermore, if a node (New Rotate) is added between node 5 and 6, they can be joined automatically.
  
    3. Read media       (input none)  >
    4. Color Correction (input 3)     >
    5. Transform        (input 4)     >
    6. New Rotate       (input 5)     >
    7. Gaussian Blur    (input 6)     >
  
We can easily reorder the nodes resulting in a new composite. For example, we can shift node 6 Gaussian Blur to occur before node 5 Transform. The compositing software can automatically reassign the input nodes.

    3. Read media       (input none)  >
    4. Color Correction (input 3)     >
    5. Gaussian Blur    (input 4)     >
    6. Transform        (input 5)     >

By enabling this seemless chaining and reordering of nodes, auto chaining makes it easy for us to test out our creative ideas quickly and productively.

Now, you may ask, what happens if you do not want to use the previous node as your input? Or what if, you need more than one input node such as a background or a mask? 

Please see [Reverse Compositing](ReverseCompositing.md).
   
