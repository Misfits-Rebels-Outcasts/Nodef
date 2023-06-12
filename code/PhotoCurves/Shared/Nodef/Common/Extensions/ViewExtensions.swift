//
//  Copyright © 2022 James Boo. All rights reserved.
//


import Foundation
import SwiftUI

extension View {
    
    func applyFilter(_ editing: Bool, _ parent: FilterPropertiesViewX?) {
               
        guard let gotParent = parent else {
 
            return
        }
        
        if editing == true
        {

        }
        else{
            gotParent.applyFilter()
        }
    }
    
    func applyFilter(_ mode: String,_ res:String, _ parent: FilterPropertiesViewX?) {
        
        guard let gotParent = parent else {

            return
        }
        
        //if mode=="Shader" || res != "High Resolution"
        //{
            gotParent.applyFilter()
        //}
    }
    
}
