# How to simulate a Lens Flare on your Photo? 

1. Launch the Node Pipeline and add a Star Shine Generator node.
2. Tap on the Star Shine Generator node, change the Color to 'Orange', and Radius to '15'.
3. Add another Star Shine Generator node, change the Color 'Orange', Radius to '15', Cross Scale to '30', and Cross Angle to '76'.
4. We are going to combine the two Star Shine Generator to simulate a Lens Flare. Add a Multiply Blend Mode composite filter and select Input Node to be '1' and Background Node to be '2'. 
5. Add a Translate node and tap on its node properties. Change the X and Y position so that the combined Star Shine Generator appear on the top right corner.
6. Finally, combine the translated Lens Flare (combined Star Shine Generator) with the orginal image. Add a Colod Dodge Blend Mode filter. Make sure node 4 is the Input Image Node and node 0 is the Background Image Node. You should see the following in the Node Pipeline.
 
<img src="https://user-images.githubusercontent.com/47021297/187804503-7989f8fc-c99e-47e5-bba8-00541eb2b864.jpeg" width="20%" height="20%">
