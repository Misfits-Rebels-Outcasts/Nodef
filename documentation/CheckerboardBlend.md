# How to blend a Checkerboard with your Photo?

The process of combining two or more image is right at the heart of any compositing tool. These image-combination tools are sometimes known as multisource operators. There are many different types such as Add, Multiply, Subtract, or Divide operators and you can add them with 'ADD COMPOSITE FILTER NODE' in the Node Pipeline screen. In this article, we will look at how to combine a Checkerboard with our image using a Color Dodge Blend operator. 

1. Launch the Node Pipeline and add a Checkerboard Generator node. A Checkboard Generator generates a pattern of square of alternating colors. You can specify the size, colors, and the sharpness of the pattern. The smaller the sharpness value, the more blurry the pattern.
   
   <img src="https://user-images.githubusercontent.com/47021297/187803975-2c043928-9fd9-4ba8-876e-5f6a826f54f2.PNG" width="300" >

2. Next, add a Gaussian Blur node and change the Radius to 20 to soften the checkboard. The Gaussian Blur is automatically applied to the output of the the Checkerboard Generator. A Gaussian Blur spreads the source pixels by an amount specified by a Gaussian distribution with the Radius determining how many pixels are used to create the blur. The larger the radius, the blurrier the result.

   <img src="https://user-images.githubusercontent.com/47021297/187803968-391e909f-3a31-48fd-8cb6-6948572988ce.PNG" width="450" >

3. Next, add a Color Dodge Blend Mode node to blend the Gaussian Blurred Checkerboard with the original image (node 0). A Color Dodge Blend brightens the background image samples (node 0) to reflect the source image samples (node 2).

   <img src="https://user-images.githubusercontent.com/47021297/187803950-a92bfbd4-4b09-4af2-b3e4-573d3c6e9d03.PNG" width="450" >
