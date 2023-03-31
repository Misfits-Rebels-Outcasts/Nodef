//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class CountersX: Codable, ObservableObject {
    
    @Published var counterList = [CounterX]()

    init() {
        for i in 1...5
        {
            counterList.append(CounterX("Counter: 0"+String(i)))
        }
    }
    
    func add(counterX: CounterX)
    {
        counterList.append(counterX)
    }
    
    enum CodingKeys: String, CodingKey {
      case counterList
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        var countersArrayForType = try container.nestedUnkeyedContainer(forKey: CodingKeys.counterList)
        var newCounterList = [CounterX]()

        while(!countersArrayForType.isAtEnd)
        {
            newCounterList.append(try countersArrayForType.decode(CounterX.self))
        }
        self.counterList = newCounterList
    }

    func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
      try container.encode(counterList, forKey: .counterList)
    }
    
}
