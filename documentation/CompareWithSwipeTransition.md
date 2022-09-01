# How to compare your original Photo with a filtered one?

We can easily compare a filtered image with the original image by using a Swipe Transition node.

1. Launch the Node Pipeline, add a Hatched Screen filter. This filter simulates the hatched pattern of a hlaftone screen.

2. Next add a composite Swipe Transition node with 1 as the Input Image Node and 0 - Original Image as the Target Image Node. The Swipe Transition transitions from one image to another by simulating a swiping action. You should see the following that enables you to compare an image with the same image applied with a Hatched Screen filter. You can tap on the Swipe Transition node and change the Time property to see how the different parts of the image is liked when applied the Hatched Screen filter.

<img src="https://user-images.githubusercontent.com/47021297/187808514-0bbdc973-aa2d-44d2-89c9-58921746a978.PNG" width="20%" height="20%">
