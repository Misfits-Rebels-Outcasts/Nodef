# Digital Compositing with a List on a Mobile Phone

This repo proposes the idea of displaying a digital compositing node graph **succintly in English as a list of steps**. A list of steps is succint, easy to understand, and convenient to create thus making it an excellent medium for display on a mobile phone with limited screen space or for discussion in a  document.

## TLDR;

     Read photo  Read photo
     |           |     
     V           V     
     Exposure    Color Correction 
     |           |
     |           V
     |           Retouch
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

    1. Read photo       
    2. Exposure         (1)    
  
    3. Read photo       
    4. Color Correction (3)     
    5. Retouch.         (4)     
    6. Gaussian Blur    (5)     
  
    7. Merge            (2,6)  
    8. Viewer           (7)     

Note - The brackets e.g. "(1)" is used to refer to the input node or image.

by Nodef - No definition or node definition.

## Digital Compositing Pipeline (node graph as a list)

### What is Digital Compositing?

Digital Compositing (node-based) is the process of combining multiple seemingly simple nodes to render and achieve a desired result. The paradigm of a node-based tool involves linking basic media objects onto a procedural map or node graph and then intuitively laying out each of the steps in a sequential progression of inputs and outputs. Any parameters from an earlier step can be modified to change the outcome, with the results instantly being visible to you, and each of the nodes, being procedural, can be easily reused, saving time and effort.

### Background

[Digital Compositing on Mobile](documentation/NodeBasedCompositingOnMobile.md)

### Proposed Ideas

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


