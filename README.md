# Digital Compositing with a List on Mobile 

This repo proposes the idea of displaying a Digital Compositing node-graph succintly in English as a list of steps. Displaying a node graph as a list of steps, a **Digital Compositing Pipeline**, is very useful in circumstances when there is limited screen space. For example, in times when we need to view or change a node graph on a mobile device.

### What is Digital Compositing?

Digital Compositing (node-based) is the process of combining multiple seemingly simple nodes to render and achieve a desired result. The paradigm of a node-based tool involves linking basic media objects onto a procedural map or node graph and then intuitively laying out each of the steps in a sequential progression of inputs and outputs. Any parameters from an earlier step can be modified to change the outcome, with the results instantly being visible to you, and each of the nodes, being procedural, can be easily reused, saving time and effort.

## TLDR;

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
         
to

    1. Read media       (none)
    2. Premult          (1)    
  
    3. Read media       (none) 
    4. Color Correction (3)     
    5. Transform        (4)     
    6. Gaussian Blur    (5)     
  
    7. Merge            (2,6)  
    8. Viewer           (7)     
    
by Nodef - No definition or node definition.

## Digital Compositing with a List - Proposed Ideas
 
[Digital Compositing on Mobile](documentation/NodeBasedCompositingOnMobile.md)

Ideas

* [Digital Compositing Pipeline](documentation/NodePipeline.md) for representing Node Graph
* [Auto Chaining](documentation/AutoChaining.md) & [Reverse Compositing](documentation/ReverseCompositing.md)
* [Viewer Cycling](documentation/ViewerCycling.md)
* [Direct Acyclic Graph Generation/Import](documentation/DirectedAcyclicGraphGeneration.md)

## Open-Source Projects (GPL)

* [ShaderMuse](https://github.com/Misfits-Rebels-Outcasts/ShaderMuse) - **Latest Source with Metal Shaders**
* [Open Digital Compositing Pipeline](code/Nodef) - [Notes](code/Readme.md)
* [SwiftUI WYSIWYG Draw](https://github.com/Misfits-Rebels-Outcasts/SwiftUI-WYSIWYG-Draw) for Nodef.
* [Library for Chaining, Blending, and Compositing Core Image CIFilter](documentation/ChainingBlendingCompositingCoreImageCIFilters.md) 

Platform
* iOS, iPadOS, or Mac with Swift and Metal

## Free App in App Store

* [Open Digital Compositing Pipeline](https://apps.apple.com/us/app/pipeline-digital-compositing/id1640788489)

## Videos

* [Digital Compositing Shaders and Filters](https://www.youtube.com/shorts/8rLejlmGEKI).

* [Digital Compositing Photo Filters & Effects](https://www.youtube.com/watch?v=dlnh_09_rvA).


