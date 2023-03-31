//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class CSVRowX: Codable, ObservableObject, Identifiable, Equatable {
    static func == (lhs: CSVRowX, rhs: CSVRowX) -> Bool {
        return lhs.id==rhs.id
    }
    var id = UUID()
    
    init()
    {
        
    }
    
    @Published var column1: String = ""
    @Published var column2: String = ""
    @Published var column3: String = ""
    @Published var column4: String = ""
    @Published var column5: String = ""
    @Published var column6: String = ""
    @Published var column7: String = ""
    @Published var column8: String = ""
    @Published var column9: String = ""
    @Published var column10: String = ""
/*
    @Published var column11: String = ""
    @Published var column12: String = ""
    @Published var column13: String = ""
    @Published var column14: String = ""
    @Published var column15: String = ""
    @Published var column16: String = ""
    @Published var column17: String = ""
    @Published var column18: String = ""
    @Published var column19: String = ""
    @Published var column20: String = ""
*/
    enum CodingKeys: String, CodingKey {
        case column1
        case column2
        case column3
        case column4
        case column5
        case column6
        case column7
        case column8
        case column9
        case column10
        /*
        case column11
        case column12
        case column13
        case column14
        case column15
        case column16
        case column17
        case column18
        case column19
        case column20
         */
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        column1 = try container.decodeIfPresent(String.self, forKey: .column1) ?? ""
        column2 = try container.decodeIfPresent(String.self, forKey: .column2) ?? ""
        column3 = try container.decodeIfPresent(String.self, forKey: .column3) ?? ""
        column4 = try container.decodeIfPresent(String.self, forKey: .column4) ?? ""
        column5 = try container.decodeIfPresent(String.self, forKey: .column5) ?? ""
        column6 = try container.decodeIfPresent(String.self, forKey: .column6) ?? ""
        column7 = try container.decodeIfPresent(String.self, forKey: .column7) ?? ""
        column8 = try container.decodeIfPresent(String.self, forKey: .column8) ?? ""
        column9 = try container.decodeIfPresent(String.self, forKey: .column9) ?? ""
        column10 = try container.decodeIfPresent(String.self, forKey: .column10) ?? ""
        
        /*
        column11 = try container.decodeIfPresent(String.self, forKey: .column11) ?? ""
        column12 = try container.decodeIfPresent(String.self, forKey: .column12) ?? ""
        column13 = try container.decodeIfPresent(String.self, forKey: .column13) ?? ""
        column14 = try container.decodeIfPresent(String.self, forKey: .column14) ?? ""
        column15 = try container.decodeIfPresent(String.self, forKey: .column15) ?? ""
        column16 = try container.decodeIfPresent(String.self, forKey: .column16) ?? ""
        column17 = try container.decodeIfPresent(String.self, forKey: .column17) ?? ""
        column18 = try container.decodeIfPresent(String.self, forKey: .column18) ?? ""
        column19 = try container.decodeIfPresent(String.self, forKey: .column19) ?? ""
        column20 = try container.decodeIfPresent(String.self, forKey: .column20) ?? ""
        */
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(column1, forKey: .column1)
        try container.encode(column2, forKey: .column2)
        try container.encode(column3, forKey: .column3)
        try container.encode(column4, forKey: .column4)
        try container.encode(column5, forKey: .column5)
        try container.encode(column6, forKey: .column6)
        try container.encode(column7, forKey: .column7)
        try container.encode(column8, forKey: .column8)
        try container.encode(column9, forKey: .column9)
        try container.encode(column10, forKey: .column10)
        /*
        try container.encode(column11, forKey: .column11)
        try container.encode(column12, forKey: .column12)
        try container.encode(column13, forKey: .column13)
        try container.encode(column14, forKey: .column14)
        try container.encode(column15, forKey: .column15)
        try container.encode(column16, forKey: .column16)
        try container.encode(column17, forKey: .column17)
        try container.encode(column18, forKey: .column18)
        try container.encode(column19, forKey: .column19)
        try container.encode(column20, forKey: .column20)
         */
    }
    
}
