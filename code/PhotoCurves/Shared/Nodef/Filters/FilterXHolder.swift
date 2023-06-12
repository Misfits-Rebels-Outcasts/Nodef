//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

class FilterXHolder: Codable, ObservableObject, Identifiable, Equatable {
    static func == (lhs: FilterXHolder, rhs: FilterXHolder) -> Bool {
        return lhs.id==rhs.id
    }
    
    var id = UUID()    
    @Published var filter: FilterX = ColorControlsFX()
    init()
    {
        
    }
    
    enum CodingKeys: String, CodingKey {
        case filter
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        filter = try values.decodeIfPresent(FilterX.self, forKey: .filter) ?? ColorControlsFX()
        
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(filter, forKey: .filter)
    }
    
}
