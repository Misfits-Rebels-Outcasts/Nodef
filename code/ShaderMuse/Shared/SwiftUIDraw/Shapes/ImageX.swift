//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

//image orientation
class ImageX: ShapeX {
    @Published var image: UIImage = UIImage(named: "LabelImage")!
    @Published var filteredimage: UIImage = UIImage(named: "LabelImage")!
    @Published var maintainAspectRatio:Bool = false
    @Published var scale:String = "Fill"
    //@Published var filters:FiltersXBack = FiltersXBack()
    @Published var filters:FiltersX = FiltersX()
    @Published var readFX:ReadImageFX?
    
    init(_ dpi:Double, _ location: CGPoint, _ size: CGSize, _ canvasSize: CGSize, _ isSelected: Bool) {
        super.init(dpi,"Image",location,size,canvasSize,isSelected)
        print(location)
        print(size)
        print(canvasSize)
        print(isSelected)
        //var x=ColorControlsFX()
        //print("cid",x.id)
        //filters.add(filter:x)
        //filters.add(filter:PhotoEffectNoirFX())
        //filters.add(filter:ColorControlsFX())
        
        let filterXHolder = FilterXHolder()
        filterXHolder.filter=ColorControlsFX()
        self.filters.add(filterHolder: filterXHolder)
        
        applyFilter()
    }

    enum CodingKeys : String, CodingKey {
      case image
      case maintainAspectRatio
      case scale
      case filters
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)



        let data = try container.decodeIfPresent(String.self, forKey: .image) ?? nil
        if data != nil
        {
            //self.image = convertBase64StringToImage(imageBase64String:data!)
            self.filteredimage = ImageUtil.convertBase64StringToImage(imageBase64String:data!)
            self.image = ImageUtil.convertBase64StringToImage(imageBase64String:data!)
       
        }
        maintainAspectRatio = try container.decodeIfPresent(Bool.self, forKey: .maintainAspectRatio) ??  false
        scale = try container.decodeIfPresent(String.self, forKey: .scale) ??  "Fill"
        /*
        filters = try container.decodeIfPresent(FiltersXBack.self, forKey: .filters) ??  FiltersXBack()
        
        if filters.filterList.count==0
        {
            filters.add(filter: ColorControlsFX())
        }
         */
        filters = try container.decodeIfPresent(FiltersX.self, forKey: .filters) ??  FiltersX()

        filters.initNodeIndex()
        filters.reassignAllBounds()
        /*
        if filters.filterList.count==0
        {
            let filterXHolder = FilterXHolder()
            filterXHolder.filter=ColorControlsFX()
            filters.add(filterHolder: filterXHolder)
        }
        */
        applyFilter()
         
      }
/*
    func convertImageToBase64String (img: UIImage) -> String {
        return img.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
        //return img.pngData()?.base64EncodedString() ?? ""
    }
    
    func convertBase64StringToImage (imageBase64String:String) -> UIImage {
        let imageData = Data(base64Encoded: imageBase64String)
        let image = UIImage(data: imageData!)
        return image!
    }
  */
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(ImageUtil.convertImageToBase64String(img:image), forKey: .image)
        try container.encode(maintainAspectRatio, forKey: .maintainAspectRatio)
        try container.encode(scale, forKey: .scale)
        try container.encode(filters, forKey: .filters)
      }


    override func view() -> AnyView {
        AnyView(
            //Image(uiImage: UIImage(data: imageData)!)
            Image(uiImage: filteredimage)
                .resizable()
                //.aspectRatio(contentMode: .fill)
                .aspectRatio(arFlag:maintainAspectRatio, scale: scale)
                .frame(width: self.size.width, height: self.size.height, alignment: .center)
                //.clipShape(Circle()) //fill with clip circle need to be here. though sometimes still jumpy in ios15
                //.clipShape(Circle()) //fit with clip circle here funny
                .clipped()
                .position(self.location)
            )
        }
    
    func applyFilter()
    {
        //filteredimage=image
        
        DispatchQueue.main.async(execute: { [self] in
            filteredimage=filters.applyFilters(image: image)
        })
        
        //filteredimage=filters.applyFilters(image: image)
        /*
        print("applying filter",self.filters.filterList.count)
        let beginImage = CIImage(image: image)
        let context = CIContext()
        
        if self.filters.filterList.count == 0
        {
            filteredimage=image
            return
        }

        var currentCIFilter : CIFilter = CIFilter()
        var currentImage = beginImage!

        self.filters.filterList.forEach
        {
            let currentFilter = $0 as FilterX
            print("current id",currentFilter.id,currentFilter.type,currentFilter.alias)
            if currentFilter is BaseBlendFX
            {
                let blendFilter = currentFilter as! BaseBlendFX
                var currentBlendInputImage = currentImage
                var currentBlendBackgroundImage = currentImage
                
                print("iA",blendFilter.inputImageAlias)
                print("bA",blendFilter.backgroundImageAlias)

                if blendFilter.inputImageAlias != ""
                {
                    if let filterWithInputAlias = self.filters.filterList.first(where: {$0.alias == blendFilter.inputImageAlias}) {
                        print("found iA")
                        if let cifilterUw = filterWithInputAlias.getCIFilter()
                        {
                            currentBlendInputImage=cifilterUw.outputImage!
                        }
                    }
                }

                if (blendFilter.backgroundImageAlias != "")
                {
                    if let filterWithBackgroundAlias = self.filters.filterList.first(where: {$0.alias == blendFilter.backgroundImageAlias}) {
                        print("found bA")
                        if let cifilterUw = filterWithBackgroundAlias.getCIFilter()
                        {
                            currentBlendBackgroundImage=cifilterUw.outputImage!
                        }
                    }
                }

                currentCIFilter = blendFilter.getCIFilter(inputImage:currentBlendInputImage, backgroundImage:currentBlendBackgroundImage)
                currentImage=currentCIFilter.outputImage!

                
            }
            else
            {
                var currentInputImage = currentImage
                if currentFilter.inputImageAlias != ""
                {
                    if let filterWithInputAlias = self.filters.filterList.first(where: {$0.alias == currentFilter.inputImageAlias}) {
                        print("found iA")
                        if let cifilterUw = filterWithInputAlias.getCIFilter()
                        {
                            currentInputImage=cifilterUw.outputImage!
                        }
                    }
                }
                
                currentCIFilter = currentFilter.getCIFilter(currentInputImage)
                currentImage=currentCIFilter.outputImage!
            }
        }
        

        if let output = currentCIFilter.outputImage {
            if let cgimg = context.createCGImage(output, from: output.extent) {
                filteredimage = UIImage(cgImage: cgimg, scale: self.image.scale, orientation: self.image.imageOrientation)
            }
             
        }
        */
        
    }
    
    func setViewer(filterXHolder: FilterXHolder)
    {
        filters.setViewer(nodeIndex: filterXHolder.filter.nodeIndex)
        applyFilter()

    }
    func getViewerNodeIndex()->Int
    {
        return filters.viewerIndex
    }
    
    func applyReadPhoto(uiImage: UIImage)
    {
        readFX?.inputImage=uiImage
        applyFilter()
    }
}



extension Image {
    @ViewBuilder
    func aspectRatio(arFlag: Bool, scale: String) -> some View {
        if arFlag {
            self.aspectRatio(contentMode: scale=="Fit" ? ContentMode.fit : ContentMode.fill)
        } else {
            self
        }
    }
}
