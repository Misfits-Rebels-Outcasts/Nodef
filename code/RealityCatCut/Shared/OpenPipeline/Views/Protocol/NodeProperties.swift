//
//  Copyright © 2022-2023 James Boo. All rights reserved.
//

protocol NodeProperties {

    var parent: FilterPropertiesViewX? { get set }
    
}

extension NodeProperties {

    func applyFilter(_ editing: Bool) {
        
        editing == true ? applyFilter("start",parent) : applyFilter("stop",parent)

    }
    
    func applyFilter() {
        
        applyFilter("change",parent)

    }
    
    func applyFilter(_ changeType: String, _ parent: FilterPropertiesViewX?) {
               
        guard let gotParent = parent else {
            return
        }
        gotParent.applyFilter(changeType)
        
    }
    

}
