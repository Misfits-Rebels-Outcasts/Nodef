//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class CSVRowX_: Codable, ObservableObject, Identifiable, Equatable {
    static func == (lhs: CSVRowX_, rhs: CSVRowX_) -> Bool {
        return lhs.id==rhs.id
    }
    var id = UUID()
    
    init()
    {
        
    }
    
    @Published var csvColumnList = [String]()

    enum CodingKeys: String, CodingKey {
        case csvColumnList
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        var columnsArrayForType = try container.nestedUnkeyedContainer(forKey: CodingKeys.csvColumnList)
        var newCSVColumnList = [String]()

        while(!columnsArrayForType.isAtEnd)
        {
            newCSVColumnList.append(try columnsArrayForType.decode(String.self))
        }
        self.csvColumnList = newCSVColumnList
        
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(csvColumnList, forKey: .csvColumnList)

    }
    
}
