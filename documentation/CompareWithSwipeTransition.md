# How to compare your original Photo with a filtered one?

We can easily compare a filtered image with the original by using a Swipe Transition node. 

1. Launch the Node Pipeline, add a Hatched Screen filter. This filter simulates the hatched pattern of a halftone screen.

2. Next add a composite Swipe Transition node with node 1 as the Input Image Node and node 0 (Original Image) as the Target Image Node. The Swipe Transition transitions from one image to another by simulating a swiping action. You should see the following that allows you to compare the Hatched Screen with the original image. You can tap on the Swipe Transition node and change the Time property. The Time property simulates the Swipe Transition animation and allows you to compare the two images at different points of the transition.

   <img src="https://user-images.githubusercontent.com/47021297/187808514-0bbdc973-aa2d-44d2-89c9-58921746a978.PNG" width="250">
