# How to add a Page Curl Transition Effect to your Photo?

In this article, we will illustrate how to add a Page Curl effect to your Photo. A Page Curl transitions from one image to another by simulating a curling page, revealing the new image as the page curls. 

1. Launch the Node Pipeline screen and add a QR Code Generator. The QR Code is going to be used as the target image of our Page Curl transition.

   <img src="https://user-images.githubusercontent.com/47021297/188018399-967e8b32-b957-42a6-aae9-ae7841d91fe8.jpeg"  width="250">

2. Next, add a Checkerboard Generator. The Checkerboard is going to be used as the 'Backside' image of our Page Curl transition.

3. Next, add a Page Curl With Shadow Transition. This node is available in the 'ADD COMPOSITE FILTER NODE' option. Tap on the Page Curl node to launch its properties screen. Select node 0 (Original Image) as the Input Image Node, node 1 (QR Code) as the Target Image Node, and node 2 (Checkerboard) as the Backside Image Node. Angle is the angle of the curling page. Radius is the radius of the curl. Shadow Size is the maximum size in pixels of the shadow. Shadow Extent is the rectagular portion of input image that will cast a shadow. You should see the following:

   <img src="https://user-images.githubusercontent.com/47021297/187808242-1edb017d-a7ae-4933-b282-2a93db9c6749.PNG"  width="250">
