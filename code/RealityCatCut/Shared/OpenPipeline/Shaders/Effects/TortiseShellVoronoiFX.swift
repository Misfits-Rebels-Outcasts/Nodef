//
//  Copyright © 2022-2023 James Boo. All rights reserved.
//

import SwiftUI

class TortiseShellVoronoiFX: BaseGeneratorFX {
       
    @Published var timeElapsed:Float = 0.0
    @Published var animType:Float = 0.0
    //check if it is in use
    @Published var regenerate:Bool = false
    
    let description = "Tortise Shell Effects. This is based on Voronoi."

    override init()
    {
        let name = "CITortiseShellVoronoi"
        super.init(name)
        desc=description
        

    }

    enum CodingKeys : String, CodingKey {
        case radius

    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        //let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
     

        
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        //var container = encoder.container(keyedBy: CodingKeys.self)


    }
    
    override func getCIFilter(_ ciImage: CIImage)->CIFilter
    {
        var currentCIFilter: TortiseShellVoronoiFilter
        if ciFilter != nil {
            currentCIFilter = ciFilter as! TortiseShellVoronoiFilter
        } else {
            currentCIFilter =  TortiseShellVoronoiFilter()
            ciFilter=currentCIFilter
            //regenerate=true
        }

        currentCIFilter.inputImage = ciImage
        //currentCIFilter.inputTime = CGFloat(timeElapsed)
        timeElapsed=Float(timeElapsedX)
        currentCIFilter.inputTime = CGFloat(timeElapsed)
        
       
        _ =  CGFloat(0)

        return currentCIFilter

        
    }

}
