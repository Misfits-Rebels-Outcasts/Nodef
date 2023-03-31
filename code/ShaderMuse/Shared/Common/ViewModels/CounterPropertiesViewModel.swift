//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class CounterPropertiesViewModel:  ObservableObject {

    @Published var counterFieldType: String = "Counter: 01"
    @Published var startValue: String = "1"
    @Published var stepValue: String = "1"
    @Published var counterLength: String = "5"
    @Published var stepOperation: String = "Increment"
    @Published var padding: String = "No Padding"
    @Published var padCharacter: String = " "
    @Published var prefix: String = ""
    @Published var suffix: String = ""

    @Published var rollOverMinimum: String = "1"
    @Published var rollOverMaximum: String = "99999"
    
    var skipSetPadding: Bool = false
    
    func setupSelectedProperties()
    {
      
    }
    
}

