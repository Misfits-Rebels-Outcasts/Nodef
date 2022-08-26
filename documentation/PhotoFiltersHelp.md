# Nodef - Photo Filters & Effects Help

### Overview Video

Click on the [video](https://www.youtube.com/watch?v=dlnh_09_rvA) below to get a quick overview of the app:

[![Nodef Compositing](https://img.youtube.com/vi/dlnh_09_rvA/0.jpg)](https://www.youtube.com/watch?v=dlnh_09_rvA)

## Overview
 
Nodef is a powerful node-based image filter compositor with over 150+ filters and effects. It uses an innovative Node Pipeline editor to enable a productive, flexible, and complete node graph compositing experience on a mobile device.
 
### Presets
 
 The Presets screen contains many samples which we can test out to understand more about filter compositing. To bring up this screen, simply tap on the filters (3 circles) icon on the bottom toolbar.
 
<img src="https://user-images.githubusercontent.com/47021297/186766901-1d6cde91-b99f-4cd3-a63a-78fcad90f777.jpeg" width="30%" height="30%">

In the Presets screen, tap on any of the presets to apply it to our image.

<img src="https://user-images.githubusercontent.com/47021297/186768216-aab83fe5-999b-417e-8ac0-90fa04950178.png" width="30%" height="30%">

We can tap on the 'Edit' button to customize the preset with the Pipeline (node graph) screen.
 
### Pipeline
 
The Pipeline screen contains a pipeline of filter nodes (node graph) which we applied on our image. We can bring up this screen by tapping on the 'f' (filters) button on the bottom toolbar of the app.
 
 <img src="https://user-images.githubusercontent.com/47021297/186768256-339083c8-d177-4960-9a74-25cee17bc9f6.jpeg" width="30%" height="30%">

## Filters Compositing
 
 Compositing is the process of combining multiple seemingly simple nodes, in our case image filters, to render, and achieve a desirable composite effect. The process involves adding and compositing nodes in a node graph. In Nodef, we have designed from the ground up a 'Mobile First' Node Pipeline to streamline, simplify, and manage the node graph.
 
### Adding Filters
 
 To add filters, we select a filter node and add it to the pipeline (node graph) with the + button. The steps are illustrated by the flow of the arrows below.

 <img src="https://user-images.githubusercontent.com/47021297/186768290-e6f1fe4a-564e-48c6-94d0-406d79e5dbf5.jpeg" width="30%" height="30%">

 The Color Controls node enables us to set the Brightness, Contrast, and Saturation of an image.
 
### Chaining Filters
 
 We can combine (chain) filters by adding nodes into the pipeline sequentially. For example, we can add a Color Monochrome node and then a Gaussian Blur node.
 
  <img src="https://user-images.githubusercontent.com/47021297/186768314-75265909-a279-43d8-b033-bf366da35ba7.jpeg" width="30%" height="30%">

 In the above, the Original Image (Node 0) is used as the input for Color Monochrome (Node 1). The output of Color Monochrome (Node 1) is used as the input for Gaussian Blur (Node 2).

  <img src="https://user-images.githubusercontent.com/47021297/186770353-827b0032-5434-4f84-ad9b-da13b8f90f15.jpeg" width="30%" height="30%">

The result of our filter nodes pipeline is shown below. We can add, delete and chain any number of nodes, or reorder the nodes with the Edit button.

  <img src="https://user-images.githubusercontent.com/47021297/186768356-eed63864-e242-4f45-b1bf-ada32eae74cc.jpeg" width="30%" height="30%">

### Node Properties
 
We can change node properties by tapping on a node in the pipeline to bring up the properties screen.
          
  <img src="https://user-images.githubusercontent.com/47021297/186770484-4fdfbaac-8095-4316-ab6a-ae9c3b0da5a5.jpeg" width="30%" height="30%">
 
 After tapping on Node 1, we can change the Color and Intensity properties of the Color Monochrome filter.
 
   <img src="https://user-images.githubusercontent.com/47021297/186768404-4316fc87-e334-4c99-a3f3-70081dd2eaf6.jpeg" width="30%" height="30%">

### Compositing Filters
 
 We can blend two filter nodes with a Composite node. A composite node can be added by the 'ADD COMPOSITE FILTER NODE' option.

   <img src="https://user-images.githubusercontent.com/47021297/186768426-76b02b67-c0c8-4b51-97ae-4aeb70686edb.jpeg" width="30%" height="30%">

 In the above, we first add a Checkerboard Generator (generates a checkerboard as its name implies) as Node 1. Next, we blend Node 1 (Checkerboard) and Node 0 (Original Image) with a Color Dodge Blend Mode filter. The following is the result of our composite.

   <img src="https://user-images.githubusercontent.com/47021297/186768452-ca078cba-4d81-4932-ab56-57935e9ece80.jpeg" width="30%" height="30%">

 The input images used for performing the composite (blend) filter can be set up by first tapping on the Color Dodge Blend Mode node and then changing its Input Image properties.
 
### Input Image
 
 When we chain or composite filters, the Input Image of a node is automatically set to the preceding node. This process is known as auto-chaining. When we reorder or delete nodes, the  Input Image node used will be adjusted automatically.
 
 <img src="https://user-images.githubusercontent.com/47021297/186768492-53cad167-0f3b-4f3c-81f7-18379a7a403a.jpeg" width="30%" height="30%">

 We can change the Input Image by tapping on a Node and then changing its Input Image property.

 <img src="https://user-images.githubusercontent.com/47021297/186768510-8c39a669-208c-4209-8f78-34b5e442f369.jpeg" width="30%" height="30%">

 In the above, we can tap on 'Preceding' to select a different Node to use as the Input Image.
 
 <img src="https://user-images.githubusercontent.com/47021297/186768529-dc66ae94-f2de-4695-b4a4-ce3fb208baca.jpeg" width="30%" height="30%">

If we select Node 1 as the new Input Image for Node 3, the following is what we get in our pipeline. We now skip the Color Monochrome node and just apply the Gaussian Blur to Node 1.
 
 <img src="https://user-images.githubusercontent.com/47021297/186768542-7b5d9378-b76d-4afb-a875-59e9f3bb57b0.jpeg" width="30%" height="30%">

 The double quotes (\"1\") indicates a node specified by us instead of the automatically assigned preceding node.

### Background Image
 
In a composite blend filter, we usually have both an Input and Background Image. As noted earlier, the Input Image, unless otherwise specified, is automatically assigned to the preceding node by default. The Background Image, on the other hand, is automatically assigned to Node 0 (Original Image) by default.

 <img src="https://user-images.githubusercontent.com/47021297/186768605-b8d3d3f9-87e2-4335-b74d-609b83d16677.jpeg" width="30%" height="30%">

 We can change the Background Image by tapping on a node and then changing its Background Image property.

<img src="https://user-images.githubusercontent.com/47021297/186768616-9186b432-0bdb-40c7-a27f-4e2ee3669c1d.jpeg" width="30%" height="30%">

## Setting the Viewer
 
 The upper portion of the app, the Viewer, displays the effect of applying all the filters in our pipeline (node graph) on the image. The Viewer can be set to display the effect of the pipeline up to a specific node. We do this by ‘long pressing’ on the yellow socket of a node in the pipeline.
 
 <img src="https://user-images.githubusercontent.com/47021297/186768648-f083b4ea-2d64-4cd0-88c1-3e5a208a812e.png" width="30%" height="30%">

In the above, after 'long pressing' on the yellow color socket of Node 1, the Viewer displays the rendered output of Node 1 instead of the output of the entire pipeline. The yellow color socket turns blue to indicate where the Viewer is set to. The Viewer will automatically reset back to display the output of the entire pipeline when we exit the Pipeline screen.

Setting the Viewer from the top to the bottom of the pipeline, one after another enables us to view the effect of each node on our image. This can help us quickly understand the progression steps we have taken in achieving the result we require. This process is known as Viewer Cycling.


