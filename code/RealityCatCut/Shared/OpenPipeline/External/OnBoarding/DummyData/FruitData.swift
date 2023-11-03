//
//  FruitData.swift
//  OnBoardingViewSwiftUI
//
//  Created by Krupanshu Sharma on 06/02/23.
//

import Foundation
import SwiftUI

// MARK: - FRUITS DATA

let fruitsData: [Fruit] = [
  Fruit(
      title: "Reality ^Cat Cut",
      headline: "Reality ^Cat Cut is an Open-Source Video Editor and Augmented Reality Movie Maker with a Digital Compositing workflow.",
      image: "blueberry",
      gradientColors: [Color("ColorBlueberryLight"), Color("ColorBlueberryDark")]
    ),
    Fruit(
      title: "DIGITAL COMPOSITING",
      headline: "In professional Film Making, Digital Compositing is commonly used as the underlying backbone for creating Animations, Visual Effects (VFX), Augmented Reality (AR), and Computer-Generated Imagery (CGI).",
      image: "strawberry",
      gradientColors: [Color("ColorStrawberryLight"), Color("ColorStrawberryDark")]
    ),
    Fruit(
      title: "AGILE",
      headline: "Reality ^Cat Cut enables Digital Compositing on modern Touch and Spatial devices with an AGILE node-graph.",
      image: "watermelon",
      gradientColors: [Color("ColorWatermelonLight"), Color("ColorWatermelonDark")]
    ),
    Fruit(
      title: "OPEN-SOURCE",
      headline: "Reality ^Cat Cut and OPEN ^GRAPHICS PIPELINE (Nodef) are open-source projects. Support our projects in GitHub. v0.1 source code is now available.",
      image: "gooseberry",
      gradientColors: [Color("ColorGooseberryLight"), Color("ColorGooseberryDark")]
    ),
  
    
  Fruit(
    title: "DIGITAL COMPOSITING",
    headline: "Digital Compositing is the process of combining two or more images (or filters and videos) to produce the appearance of a single image. It involves adding and compositing nodes in a node graph.",
    image: "lime",
    gradientColors: [Color("ColorLimeLight"), Color("ColorLimeDark")]
  ),
  
  Fruit(
    title: "STEP-by-STEP",
    headline: "We can think of a Node Graph as a list of steps to be carried out on our video. For example, adding a Pointillize node causes our video to be rendered in a pointillistic style.",
    image: "plum",
    gradientColors: [Color("ColorPlumLight"), Color("ColorPlumDark")]
  ),
  Fruit(
    title: "CHAINING",
    headline: "We can chain multiple nodes by adding them sequentially to the node graph. For example, after adding a Pointillize node, we can further add a Gaussian Blur node.",
    image: "grapefruit",
    gradientColors: [Color("ColorGrapefruitLight"), Color("ColorGrapefruitDark")]
  ),
  Fruit(
    title: "PROPERTIES",
    headline: "Every node comes with properties that we can customize. For example, we can specify the Intensity of a Gaussian Blur node.",
    image: "pomegranate",
    gradientColors: [Color("ColorPomegranateLight"), Color("ColorPomegranateDark")]
  ),
  
  Fruit(
    title: "COMPOSITE",
    headline: "We can combine nodes with a Composite node. For example, we can overlay a Video A on top of another Video B with an Overlay Blend Mode node.",
    image: "mango",
    gradientColors: [Color("ColorMangoLight"), Color("ColorMangoDark")]
  ),
  Fruit(
    title: "INPUT NODE",
    headline: "A node can be applied to the output of the previous node or any other Input Node that we specify.",
    image: "pear",
    gradientColors: [Color("ColorPearLight"), Color("ColorPearDark")]
  ),
  Fruit(
    title: "INPUT A & B",
    headline: "A Composite node requires two (or more) Input Nodes: A & B.",
    image: "gooseberry",
    gradientColors: [Color("ColorGooseberryLight"), Color("ColorGooseberryDark")]
  ),
  Fruit(
    title: "GENERATOR",
    headline: "Some nodes such as the Checkerboard Generator does not require an Input Node. A Generator is usually used for compositing with other nodes.",
    image: "apple",
    gradientColors: [Color("ColorAppleLight"), Color("ColorAppleDark")]
  ),
  Fruit(
    title: "VIEWER",
    headline: "'Long pressing' on the yellow color socket of a Node enables us to view the rendered output of the node.",
    image: "lemon",
    gradientColors: [Color("ColorLemonLight"), Color("ColorLemonDark")]
  ),
  
  Fruit(
    title: "Read Video",
    headline: "You can import a video using a Read Video node. In node properties, simply tap on 'Select Video'.",
    image: "grapefruit",
    gradientColors: [Color("ColorGrapefruitLight"), Color("ColorGrapefruitDark")]
  ),
  Fruit(
    title: "Trim",
    headline: "You can use the Cut Video node to trim a video. In node properties, adjust the yellow color Trimmer box.",
    image: "cherry",
    gradientColors: [Color("ColorCherryLight"), Color("ColorCherryDark")]
  ),
  Fruit(
    title: "Join",
    headline: "You can use the Join Video node to concat two video clips. For example, 1. Read Video, 2. Read Video, 3. Join (1,2). Or 1. Read Video, 2. Comic Effect, 3. Join (2,1).",
    image: "blueberry",
    gradientColors: [Color("ColorBlueberryLight"), Color("ColorBlueberryDark")]
  )
]
