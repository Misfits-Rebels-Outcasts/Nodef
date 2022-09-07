//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class BaseGeneratorFX: FilterX {
          
    @Published var cropToFormat:Bool = true
    override init()
    {
        super.init()
    }
    
    override init(_ type:String) {
        super.init(type)
    }
    
    enum CodingKeys : String, CodingKey {
        case cropToFormat

    }

    required init(from decoder: Decoder) throws {
 
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cropToFormat = try values.decodeIfPresent(Bool.self, forKey: .cropToFormat) ?? true

    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(cropToFormat, forKey: .cropToFormat)
    }
    
    func setCIFilterAndCropImage(inputImage: CIImage) {

        var cropFilter: CIFilter
        if ciFilter != nil {
            cropFilter = ciFilter!
        } else {
            cropFilter = CIFilter(name: "CICrop")!
        }
        
        cropFilter.setValue(inputImage, forKey: kCIInputImageKey)
        let rect = CIVector(cgRect: CGRect(x:0, y: 0, width: CGFloat(size.width), height: CGFloat(size.height)))
        cropFilter.setValue(rect, forKey: "inputRectangle")
        ciFilter=cropFilter

    }
    
    override func getDisplayNameFX() -> String
    {

        let fxStr = "input - none"
        return fxStr
   
    }
    
    /*
    override func getCIFilter() -> CIFilter {
        print("base generator type(error if shown):",type)
        ciFilter = CIFilter(name: type)
        return ciFilter!

    }
*/
}
