//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

class FilterNames
{
    static func GetFilterType() -> [String]
    {
        GetLabelMonoFilterType()
            
    }
    
    static func GetLabelMonoFilterType() -> [String]
    {
        let filterType = [
            "Color Controls",
          
        ]
        return filterType.sorted()
    }

    static func GetShaderType() -> [String]
    {
        let shaderType = [
                        
            "Tortise Shell Voronoi"


        ]
        return shaderType.sorted()
    }
    
    static func GetMonoFilterType() -> [String]
    {
        let filterType = [
            "Color Controls",

        ]
        return filterType.sorted()
    }
    
    static func GetBlendFilterType() -> [String]
    {
        let filterType = [
                          "Mix"
        ]
        return filterType.sorted()
    }
}
