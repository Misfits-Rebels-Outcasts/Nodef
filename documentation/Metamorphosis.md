# Metamorphosis (Under Construction)

Metamorphosis refers to the change to oneself. 
 
In Nodef Digital Compositing Pipeline, a MetaMorph node is used to point to a node in the pipeline and then used to change its properties. This appears unintuitive initially, since we can change the properties of the node directly.
 
Pipeline 
Color Control
Metamorph (1) : change=Brightness
 
To achieve the same thing. The reason is animation. A Metamorph node have access to the Time variable and a Math Formula.
 
This enables us to perform many interesting operations such as animating the brightness of our Photo with respect to time of a sine curve or other mathematical function
