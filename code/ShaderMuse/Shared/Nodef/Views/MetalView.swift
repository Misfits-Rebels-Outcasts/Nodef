//
//  MetalView.swift
//  SketchEffects
//
//  Created by Chin Pin Boo on 15/9/22.
//

import Foundation

import SwiftUI
import UIKit
import MetalKit

struct MetalView: View {
  @EnvironmentObject var pageSettings: PageSettings
    
  @State private var metalView = MetalImageView()//MTKView()
  //@State private var renderer: Renderer?

  var body: some View {
    MetalViewRepresentable(metalView: $metalView)
      .onAppear {
      //  renderer = Renderer(metalView: metalView)
          //metalView.image=pageSettings.filters.applyFiltersX(image: pageSettings.backgroundImage!)
          var currentFilter = CIFilter(name: "CICheckerboardGenerator", parameters: ["inputColor0" : CIColor.white, "inputColor1" : CIColor.black, "inputCenter" : CIVector(x: 0, y: 0), "inputWidth" : 50.00])
          
          metalView.image = currentFilter?.outputImage!

          
      }
  }
}

#if os(macOS)
typealias ViewRepresentable = NSViewRepresentable
#elseif os(iOS)
typealias ViewRepresentable = UIViewRepresentable
#endif

struct MetalViewRepresentable: ViewRepresentable {
  @Binding var metalView: MetalImageView

  #if os(macOS)
  func makeNSView(context: Context) -> some NSView {
    metalView
  }
  func updateNSView(_ uiView: NSViewType, context: Context) {
    updateMetalView()
  }
  #elseif os(iOS)
  func makeUIView(context: Context) -> MTKView {
    metalView
  }

  func updateUIView(_ uiView: MTKView, context: Context) {
    updateMetalView()
  }
  #endif

  func updateMetalView() {
  }
}

struct MetalView_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      MetalView()
      Text("Metal View")
    }
  }
}


/// `MetalImageView` extends an `MTKView` and exposes an `image` property of type `CIImage` to
/// simplify Metal based rendering of Core Image filters.
class MetalImageView: MTKView
{
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    
    lazy var commandQueue: MTLCommandQueue =
    {
        [unowned self] in
        
        return self.device!.makeCommandQueue()
    }()!
    
    lazy var ciContext: CIContext =
    {
        [unowned self] in
        
        return CIContext(mtlDevice: self.device!)
    }()
    
    override init(frame frameRect: CGRect, device: MTLDevice?)
    {
        super.init(frame: frameRect,
            device: device ?? MTLCreateSystemDefaultDevice())

        if super.device == nil
        {
            fatalError("Device doesn't support Metal")
        }
        
        framebufferOnly = false
    }

    required init(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// The image to display
    var image: CIImage?
    {
        didSet
        {
            renderImage()
        }
    }
    
    func renderImage()
    {
        guard let
            image = image,
            let targetTexture = currentDrawable?.texture else
        {
            return
        }
        
        let commandBuffer = commandQueue.makeCommandBuffer()
        
        let bounds = CGRect(origin: CGPoint.zero, size: drawableSize)
        
        let originX = image.extent.origin.x
        let originY = image.extent.origin.y
        
        let scaleX = drawableSize.width / image.extent.width
        let scaleY = drawableSize.height / image.extent.height
        let scale = min(scaleX, scaleY)
        
        let scaledImage = image
            .transformed(by: CGAffineTransform(translationX: -originX, y: -originY))
            .transformed(by: CGAffineTransform(scaleX: scale, y: scale))
        
        ciContext.render(scaledImage,
            to: targetTexture,
            commandBuffer: commandBuffer,
            bounds: bounds,
            colorSpace: colorSpace)
        
        commandBuffer!.present(currentDrawable!)
        
        commandBuffer!.commit()
    }
}
