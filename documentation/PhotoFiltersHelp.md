# Nodef - Photo Filters & Effects Help

### Overview Video

Click on the [video](https://www.youtube.com/watch?v=dlnh_09_rvA) below to get a quick overview of the app:

[![Nodef Compositing](https://img.youtube.com/vi/dlnh_09_rvA/0.jpg)](https://www.youtube.com/watch?v=dlnh_09_rvA)

### The Basics

[How to add filter nodes, chain nodes, change node properties, and select nodes as input?](PhotoFiltersBasics.md)

## Tutorials

### How to blend a Checkerboard with your Photo?

1. Launch the Node Pipeline and add a Checkerboard Generator node.

<img src="https://user-images.githubusercontent.com/47021297/187803975-2c043928-9fd9-4ba8-876e-5f6a826f54f2.PNG" width="20%" height="20%">

2. Next, add a Gaussian Blur node and change the Radius to 20 to soften the checkboard. The Gaussian Blur node automatically chains to the Checkerboard Generator.

<img src="https://user-images.githubusercontent.com/47021297/187803950-a92bfbd4-4b09-4af2-b3e4-573d3c6e9d03.PNG" width="20%" height="20%">

3. Next, add a Color Dodge Blend Mode node to blend the gaussian blurred checkerboard with the original image.

<img src="https://user-images.githubusercontent.com/47021297/187803968-391e909f-3a31-48fd-8cb6-6948572988ce.PNG" width="20%" height="20%">


### How to simulate a Lens Flare on your Photo? 

<img src="https://user-images.githubusercontent.com/47021297/187804503-7989f8fc-c99e-47e5-bba8-00541eb2b864.jpeg" width="20%" height="20%">

