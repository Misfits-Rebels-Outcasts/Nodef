# Elegant Simplicity (Under Construction)
 
## One User Interface for Everything and Anything
 
The following is the basic user interface we ever need for getting started with Nodef Digital Compositing Pipeline.

     Pipeline
     1. Color Controls
 
     +Add Node
 
* Every photo operation, image post-processing, filters, or effects starts with  a node. The rest is build on top of others. For example, in the above, we added a Color Controls node which enables us to change the Brightness, Constrast, or Saturation of a Photo.


     Pipeline
     1. Photo Curves
 
     +Add Node
 
* Alternatively, if we need to perform a Photo Curves on our photo, we add a Photo Curves node to the Pipeline. This enables us to lighten our photo, reduce contrast, or increase the shadows.
* After applying a Photo Curves node, if we need to enhance the Depth of Field, we simply add a Depth of Field node.

     Pipeline

     1. Photo Curves
     2. Depth of Field
     .
 
     +Add Node
 
* When we add a node, we build upon the previous step. 

     Pipeline

     1. Photo Curves
     2. Depth of Field
     3. Color Monochrome (0)
 
     +Add Node

* We can also reference any of the steps in the Pipeline. For example, the Color Monochrome node references the original image (Node 0) to perform the operation. We can also reorder the operations or add/remove any of the steps.

     Pipeline

     1. Photo Curves
     2. Depth of Field
     3. Color Monochrome (0)
     4. Mix (2,3)
 
     +Add Node

* We can also mix any of the previous steps with a Blend node. We can choose from many of the blend operations such as Subtract Blend, Mix, Multiplication Blend, or many others. And these Blend operations are also available as a node.

* We even expand this to Augmented Reality (AR) by adding a Model Entity node. A Model Entity node enables us to add a 3D geometry object. This AR object can reference the photo image, video, or animation (MetaMorph) in our Pipeline. 

## Additional Benefits

* A software programmer can easily join the pipeline by adding a node by programming to the Pipeline. Remember it is an Open-source Pipeline.
* We can easily describe the operations we are performing to our image or Photo without saying step 1, go to here and click this. Step 2, refer to the screenshot. We can elegantly express all of this Succintly with a Pipeline.

