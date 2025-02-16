# Metamorphosis (Under Construction)

Metamorphosis is used to describe a change of physical form, structure, or substance. In Nodef Digital Compositing Pipeline, we use Metamorphosis for animating objects or motion graphics. We simply add a Metamorph node to the Pipeline to perform Metamorphosis.

## Metamorph Node

A Metamorph node is a node in the Pipeline that is used to change the properties of another node. This appears unintuitive initially, since we can change the properties of the node directly. For example, if we use a Color Control node to change the Brightness of our photo with the following:

     Pipeline

     1. Color Control (0) : Brightness = 50

We can add a Metamorph node to the Pipeline to achieve the same thing:

     Pipeline

     1. Color Control
     2. MetaMorph (1) : change = Brightness

Why do we want to do that?

The reason is a Metamorph node have access to other useful variables such as the Time variable of a video and a Math Formula Field. This enables us to perform many interesting operations such as animating the brightness of our Photo with respect to time of a sine curve or other mathematical function.

## Properties of Metamorph Node

* change = Color Control -> Brightness
* Duration: Start Time and Stop Time
* Math Formula = Sin(Time or Frame during the Duration) * Brightness

Instead of a Math Formula, we can also use a Mathematical Curve to express how we want to perform our animation.

