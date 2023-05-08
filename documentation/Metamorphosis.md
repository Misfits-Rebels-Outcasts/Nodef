# Metamorphosis (Under Construction)

Metamorphosis is used to describe a change of physical form, structure, or substance. In Nodef Digital Compositing Pipeline, we use Metamorphosis for animating objects or motion graphics. We simply add a MetaMorph node to the Pipeline to perform MetaMorphosis.

## MetaMorph NOde

A MetaMorph node is a node in the Pipeline that is used to change the properties of another node. This appears unintuitive initially, since we can change the properties of the node directly. For example, if we use a Color Control node to change the Brightness of our photo with the following:

Pipeline

1. Color Control (0) : Brightness = 50

We can add a MetaMorph node to the Pipeline to achieve the same thing:

Pipeline

1. Color Control
2. MetaMorph (1) : change = Brightness

Why then do we want to do that?

The reason is a MetaMorph node have access to other useful variables such as the Time variable of a video and a Math Formula Field.

## Properties of MetaMorph Node

This enables us to perform many interesting operations such as animating the brightness of our Photo with respect to time of a sine curve or other mathematical function.

* change = Color Control -> Brightness
* Duration: Start Time and Stop Time
* Math Formula = Sin(Time or Frame during the Duration) * Brightness

