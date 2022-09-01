# How to generate a Histogram of your Photo?

1. Launch the Node Pipeline and add a Histogram Filter node.

   <img src="https://user-images.githubusercontent.com/47021297/188025633-ad1e164d-3ec2-4051-8fc4-c8a8ffdccf03.jpeg" width="250">

This generates a histogram image of your Photo. The properties of the Histogram Filter are described below:

* High Limit refers to the fraction of the right portion of the histogram image to make lighter. 
* Low Limit refers to the fraction of the left portion of the histogram image to make darker. 
* Count is the number of bins. If the scale is 1.0, then the bins in the resulting image will add up to 1.0.
* Region of Interest refers to the region of the image used for calculating the Histogram values.


