//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class CSVsX: Codable, ObservableObject {
    @Published var csvList = [CSVX]()

    init() {
        /*
        for i in 1...5 {
            var csvx = CSVX(i)
            csvList.append(csvx)
        }
         */
    }
    
    func add(csvX: CSVX)
    {
        csvList.append(csvX)
    }
    
    enum CodingKeys: String, CodingKey {
      case csvList
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        var csvArrayForType = try container.nestedUnkeyedContainer(forKey: CodingKeys.csvList)
        var newCSVList = [CSVX]()

        while(!csvArrayForType.isAtEnd)
        {
            newCSVList.append(try csvArrayForType.decode(CSVX.self))
        }
        self.csvList = newCSVList
    }

    func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
      try container.encode(csvList, forKey: .csvList)
    }
    
}
