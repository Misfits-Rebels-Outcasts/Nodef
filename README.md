# Digital Compositing on Mobile 
 
Nodef - No definition or node definition.

### Proposed Ideas
 
This repo proposes the following ideas as the basis for digital (node-based) compositing on a mobile device. It is by no means a complete consideration but with the hope of ideation and feedback.

Background

[Node-based Compositing on Mobile](documentation/NodeBasedCompositingOnMobile.md)

Ideas

* [Node Pipeline](documentation/NodePipeline.md) for representing Node Graph
* [Auto Chaining](documentation/AutoChaining.md) & [Reverse Compositing](documentation/ReverseCompositing.md)
* [Viewer Cycling](documentation/ViewerCycling.md)
* [Direct Acyclic Graph Generation/Import](documentation/DirectedAcyclicGraphGeneration.md)

### Feedback
 
Whether a Node Pipeline is suited for representing a node graph on a small screen requires testing, usage, and feedback. If your daily work is in a related field, we would appreciate it if you could provide feedback to us in this Github repo. This repo also hosts an open-source project that implements the Node Pipeline. An app for the project is also available in Apple App Store.

### Open User Interface

The ideas and user interface proposed here are based on some random thoughts of mine, and they are not protected by any patents or IP, or at least from what I know. Please feel free to use them in any way you deem fit (but of course at your own risk), both commercially and non-commercially.

### Open-Source Project (GPL)

An open-source node-based photo filters and effects compositor is created to test the ideas above.

### [Nodef - Photo Filters & Effects](PhotoFiltersAndEffects.md) 

Download **[Nodef](https://apps.apple.com/us/app/nodef-photo-filters-effects/id1640788489)** on the App Store

An open-source node-based image filter compositor that is bundled with a collection of 150+ filters and effects. It uses the Node Pipeline editor to enable a productive, flexible, and complete node graph compositing experience on a mobile device.

![Photo Filters & Effects](https://github.com/Misfits-Rebels-Outcasts/Nodef/blob/main/documentation/photofilterseffects.png?raw=true)

See a [video](https://www.youtube.com/watch?v=dlnh_09_rvA) to get an overview of the Node Pipeline or the [Nodef Photo Filters & Effects - Help File](documentation/PhotoFiltersHelp.md).

Platform
* iOS
* iPadOS
* Mac

Programming Language
* Swift

[Source Code](https://github.com/Misfits-Rebels-Outcasts/Nodef/tree/main/code/Nodef) - [Notes](code/Readme.md)

### [Open Source Library for Chaining, Blending, and Compositing Core Image CIFilter](documentation/ChainingBlendingCompositingCoreImageCIFilters.md) 

This is an open-source wrapper library for Core Image CIFilters, in Swift, created to support the app and compositing ideas proposed above. 

#### It gets you from Chaining CIFilters

    filters.add(filterHolder: filters.getFilterWithHolder("Sepia Tone"))
    filters.add(filterHolder: filters.getFilterWithHolder("Zoom Blur"))

#### To Node-based Compositing CIFilters

    filters.add(filterHolder: filters.getFilterWithHolder("Color Monochrome")) //Node 1
    filters.add(filterHolder: filters.getFilterWithHolder("Checkerboard Generator")) //Node 2
    let fxHolder=filters.getFilterWithHolder("Multiply Blend Mode")
    (fxHolder.filter as! MultiplyBlendModeFX).inputImageAlias = "2"
    (fxHolder.filter as! MultiplyBlendModeFX).backgroundImageAlias = "1"
    filters.add(filterHolder: fxHolder)

[Source Code](https://github.com/Misfits-Rebels-Outcasts/Nodef/tree/main/code/Nodef%20Filters%20Library)

Platform
* iOS
* iPadOS
* Mac

Programming Language
* Swift


### Nodef for Motion Graphics & Animation 

This is a Nodef project exploring the use of Apple Metal on Particle Effects.

<span>
<img src="https://user-images.githubusercontent.com/47021297/188427475-fc604438-7642-4774-a9ba-eed4bb033717.JPG" width="150" >
&nbsp;
<img src="https://user-images.githubusercontent.com/47021297/188427485-979910ea-19b7-46db-8813-922ca9f3a11f.JPG" width="150" >
&nbsp;
<img src="https://user-images.githubusercontent.com/47021297/188428523-795af800-4638-43e3-8003-ce793c6ff119.JPG" width="150" >
</span>


### Sister Project

The [WYSIWYG Draw User Interface based on SwiftUI](https://github.com/Misfits-Rebels-Outcasts/SwiftUI-WYSIWYG-Draw) for Nodef.

