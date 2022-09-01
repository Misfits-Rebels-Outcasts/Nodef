# How to simulate a Lens Flare on your Photo? 

A Lens Flare happens when a bright light is shined directly into a lens producing an artifact in the image. It is often deliberately used to invoke a sense of drama. In this article, we will show you how to combine multiple Star Shine Generator to simulate a Lens Flare. 

1. Launch the Node Pipeline and add a Star Shine Generator node. A Star Shine Generator generates a starburst pattern. The output image is typically used as input to another filter. Color refers to the color used for the outer shell of the circular star. Epsilon is the length of the cross spikes.
2. Tap on the Star Shine Generator node, change the Color to 'Orange', and Radius to '15'. You can zoom in on the image if you cannot see the Star Shine clearly.
 
   <img src="https://user-images.githubusercontent.com/47021297/188016591-16eb33aa-a910-41ad-8077-b117ea98eda8.jpeg" width="250">

3. Add another Star Shine Generator node, change the Color 'Orange', Radius to '15', Cross Scale to '30', and Cross Angle to '76'.
4. We are going to combine the two Star Shine Generator to simulate a Lens Flare. Add a Multiply Blend Mode composite filter and select Input Node to be '1' and Background Node to be '2'. A Multiply Blend Mode multiplies the input image samples with the background image samples. This results in colors that are at least as dark as either of the two contributing sample colors.

5. Add a Translate node and tap on its node properties. The Translate node automatically applies (chain) to the output of the Multiply Blend Mode. Change the X and Y positions so that the combined Star Shine Generator appears in the top right corner.

6. Finally, combine the translated Lens Flare (combined Star Shine Generator) with the original image. Add a Color Dodge Blend Mode filter. Make sure node 4 is the Input Image Node and node 0 is the Background Image Node. You should see the following in the Node Pipeline.
 
   <img src="https://user-images.githubusercontent.com/47021297/187804503-7989f8fc-c99e-47e5-bba8-00541eb2b864.jpeg" width="250">
