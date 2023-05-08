# Elegant Simplicity (Under Construction)
 
## One Simple User Interface for Everything and Anything
 
The following is the basic user interface we ever need for getting started with a Digital Compositing Pipeline. The screen of the user interface below is simply a list of nodes in a sequential manner. We can tap on Add Node to add a node to the Pipeline. We can tap on any of the nodes to change its properties or swipe to delete the node. This is an Elegant Simple way to express our user interface while enabling complex operations to be carried out by working on a series of steps through the Pipeline.

     Pipeline
     1. Color Controls
 
     +Add Node
 
Every photo operation, image post-processing, filters, or effects starts with  a node. The rest is build on top of others. For example, in the above, we added a Color Controls node which enables us to change the Brightness, Constrast, or Saturation of a Photo.


     Pipeline
     1. Photo Curves
 
     +Add Node
 
 
Alternatively, if we need to perform [Photo Curves](https://github.com/Misfits-Rebels-Outcasts/Photo-Curves) on our photo, we add a Photo Curves node to the Pipeline. This enables us to lighten our photo, reduce contrast, or increase the shadows.
After applying a Photo Curves node, if we need to enhance the Depth of Field, we simply add a Depth of Field node.

     Pipeline

     1. Photo Curves
     2. Depth of Field
     .
 
     +Add Node
 
When we add a node, we build upon the previous step. 

     Pipeline

     1. Photo Curves
     2. Depth of Field
     3. Color Monochrome (0)
 
     +Add Node

Besides the previous step, we can also reference any of the steps in the Pipeline. For example, the Color Monochrome node references the original image (Node 0) to perform the operation. We can also reorder the operations or add/remove any of the steps, and the Pipeline will automatically adjust (Auto Chaining)[https://github.com/Misfits-Rebels-Outcasts/Nodef/blob/main/documentation/AutoChaining.md] itself.

     Pipeline

     1. Photo Curves
     2. Depth of Field
     3. Color Monochrome (0)
     4. Mix (2,3)
 
     +Add Node

We can also mix any of the previous steps with a Blend node. We can choose from many of the blend operations such as Subtract Blend, Mix, Multiplication Blend, or many others. And these Blend operations are also available as a node.

This can be expanded to 3D or Augmented Reality (AR) by adding a Model Entity node. This 3D or AR node in turn can reference a photo image, video, or animation (MetaMorph) in any of the previous steps in the Pipeline. 

## Simplicity in describing Graphical Operations

* We can easily describe the operations we are performing to our image or photo without a lengthy tutorial with screenshots. For example, conventionally, we need to say "Step 1, go to the menu here and click this operation" and also "Step 2, refer to the screenshot below etc.". We can elegantly express all of this Succinctly with a Pipeline.

## Ease of Extending the Open Pipeline

* A software programmer can easily join the pipeline by adding a node with programming to the Open-source Pipeline. With an Elegantly Simple user interface, the design of graphical operations becomes modular. A programmer can come up with an innovative way of performing a graphical operation by providing codes modularly without affecting or knowing about existing operations. See the [Photo Curves](https://github.com/Misfits-Rebels-Outcasts/Photo-Curves) project to see how to add a node to the Pipeline.

