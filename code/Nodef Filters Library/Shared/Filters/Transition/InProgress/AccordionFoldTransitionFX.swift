//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class AccordionFoldTransitionFX: BaseTransitionFX {
       
    @Published var bottomHeight:Float = 1000.0//0.0
    @Published var numberOfFolds:Float = 3
    @Published var foldShadowAmount:Float = 0.1

    
    let description = "Transitions from one image to another of differing dimensions by unfolding and crossfading."

    override init()
    {
        let name="CIAccordionFoldTransition"
        super.init(name)
        desc=description
        
        time = 0.5
        
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
        
    }

    enum CodingKeys : String, CodingKey {
        case bottomHeight
        case numberOfFolds
        case foldShadowAmount
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        
        bottomHeight = try values.decodeIfPresent(Float.self, forKey: .bottomHeight) ?? 0
        numberOfFolds = try values.decodeIfPresent(Float.self, forKey: .numberOfFolds) ?? 0
        foldShadowAmount = try values.decodeIfPresent(Float.self, forKey: .foldShadowAmount) ?? 0

    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
  
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(bottomHeight, forKey: .bottomHeight)
        try container.encode(numberOfFolds, forKey: .numberOfFolds)
        try container.encode(foldShadowAmount, forKey: .foldShadowAmount)

    }
    
    override func getCIFilter(currentImage: CIImage, beginImage: CIImage) -> CIFilter? {
            
        var currentCIFilter: CIFilter
        if ciFilter != nil {
            currentCIFilter = ciFilter!
        } else {
            currentCIFilter = CIFilter(name: type)!
            ciFilter=currentCIFilter
        }
        
        let inputImage=handleAlias(alias: inputImageAlias,
                                      inputImage: currentImage,
                                      beginImage: beginImage)
        
        var targetImage=handleAlias(alias: targetImageAlias,
                                      inputImage: currentImage,
                                      beginImage: beginImage)
        
        //revisit test code
        if let parentUw = parent{
            let rect = CGRect(x: 0, y: 0, width: 1374, height: 2048)
            if let cgimg = parentUw.context!.createCGImage(targetImage, from: rect) {
                //let processedImage = UIImage(cgImage: cgimg, scale: 1.0, orientation: image.imageOrientation)
                let processedImage = UIImage(cgImage: cgimg, scale: 1.0, orientation: UIImage.Orientation.up)
                let newSize = CGSize(width:processedImage.size.width*1.0, height:processedImage.size.height*1.0)
                 UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
                processedImage.draw(in: CGRect(x:0, y:0, width:newSize.width, height:newSize.height))
                let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
                UIGraphicsEndImageContext()
                targetImage = CIImage(image: newImage)!
            }
        }
        print("accordion getFilter type",type)

        currentCIFilter.setValue(inputImage, forKey: kCIInputImageKey) 
        currentCIFilter.setValue(targetImage, forKey: kCIInputTargetImageKey)
        
        currentCIFilter.setValue(bottomHeight, forKey: "inputBottomHeight")
        currentCIFilter.setValue(numberOfFolds, forKey: "inputNumberOfFolds")
        currentCIFilter.setValue(foldShadowAmount, forKey: "inputFoldShadowAmount")
        currentCIFilter.setValue(time, forKey: kCIInputTimeKey)

        return currentCIFilter

    }

}
