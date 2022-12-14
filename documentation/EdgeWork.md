# How to generate Edges and Source Atop it on a Constant Color background?

1. Launch the Node Pipeline and add a Edge Work node. This produces a stylized black-and-white rendition of an image that looks similar to a woodblock cutout. However, it requires a background image to visualize so you will see a blank white image.

2. Next, add a Constant Color Generator tap on its node properties, and select 'Black' as the Color.  

3. Add a composite Source Atop Compositing node. Select node 1 as the Input Image Node and node 2 as the Background Image Node. A Source Atop Compositing node places an input image over a background image, then uses the luminance of the background image to determine what to show. You should see the final result with the following nodes in the Node Pipeline. 

   <img src="https://user-images.githubusercontent.com/47021297/187807894-deb28d9b-3454-4762-a3fd-f8c530cf6045.PNG" width="250">
