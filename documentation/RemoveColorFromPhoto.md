# How to remove a color from your Photo?

Color keying, or chroma keying, is a technique that removes a specific color or color range from a photo. This technique is used to replace a background with another in compositing. Nodef uses a Color Cube to provide capabilities to remove colors from your Photo.

1. Launch the Node Pipeline screen and add a Remove Color With Color Cube node. This node uses a three-dimensional color table to remove colors from the source image pixels. Tap on the node on the Pipeline to launch its properties and then tap on the Remove Color option to launch the Color Picker.

   <img src="https://user-images.githubusercontent.com/47021297/188261378-2fb2183a-279f-4f23-8abc-0e4890910c0b.PNG" width="250">

2. In the Color Picker, tap on the 'eyedropper' button to pick a color from our photo canvas.
    
   <img src="https://user-images.githubusercontent.com/47021297/188261303-c11d59d8-da5b-41ed-a149-8315876e1f26.PNG" width="250">

3. Select a color from the photo and then exit from the Color Picker. 
4. Adjust the Closeness value to get the desired result. Closeness refers to the range of colors from the base color to use for removing colors. 
5. Finally, we should see the following result, where some green parts of the photo are moved.
   
   <img src="https://user-images.githubusercontent.com/47021297/188261544-01f164ff-2cfe-497a-bf13-b65ce4416055.JPG" width="250">

