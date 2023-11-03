//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI
import RealityKit
class BaseGeneratorEntityFX: BaseEntityFX {

    override init()
    {
        super.init()
    }
    
    override init(_ type:String) {
        super.init(type)
    }
    
    required init(from decoder: Decoder) throws {
 
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    
    override func getDisplayNameFX() -> String
    {

        let fxStr = "input - none"
        return fxStr
   
    }
}
