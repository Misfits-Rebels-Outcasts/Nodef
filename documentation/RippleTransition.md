# How to apply a Ripple Effect on your Photo?

A Ripple Effects simulates a transition from one image to another by creating a circular wave that expands from the center point, revealing the new image in the wake of the wave. 

1. Launch the Node Pipeline and add a Dot Screen filter node. A Dot Screen simulates the dot patterns of a halftone screen. You can change the width between the dots or the sharpness of the pattern in its node properties.

   <img src="https://user-images.githubusercontent.com/47021297/188021537-525163e3-9ad3-4f10-8cbe-dce4157facb9.jpeg" width="20%" height="20%">

2. Add a Crop node to crop the image. Specify the X, Y, Width, and Height of the crop so that the bottom of the image is empty. We will use this as the shading image in our Ripple Effect.

   <img src="https://user-images.githubusercontent.com/47021297/188021811-7e389574-4613-4cde-b2f6-2a3633c84819.jpeg" width="20%" height="20%">

3. Add a Ripple Transition with 'ADD A COMPOSITE FILTER NODE'. Select node 0 (Original Image) as the Input Image Node, node 1 (Dot Screen) as the Target Image Node, and node 2 (Crop) as the Shading Image Node.

   <img src="https://user-images.githubusercontent.com/47021297/188021935-43e42cbe-b800-4f1a-8a08-d29c22b70e5a.jpeg" width="20%" height="20%">

The Scale property of the Ripple Transition is a value that determines whether the ripple starts as a bulge (higher value) or a dimple (lower value). The Width property of the transition is the width of the ripple. Please remember that the shading image needs to be transparent at the bottom.

4. You should see the following Ripple Effect on your Photo.

   <img src="https://user-images.githubusercontent.com/47021297/188021160-a8a051d8-7d0d-467f-8bed-107f71436a6f.jpeg" width="20%" height="20%">



