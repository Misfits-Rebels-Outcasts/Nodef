//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

struct CSVColumn: Codable, Identifiable {
    var id = UUID()
    let csvNumber: String
    let csvValue: String
}

class CSVX_: Codable, ObservableObject, Identifiable, Equatable {
    static func == (lhs: CSVX_, rhs: CSVX_) -> Bool {
        return lhs.id==rhs.id
    }
    var id = UUID()
    
    init(_ pcsvNumber:Int)
    {
        csvNumber=pcsvNumber
        
    }
    
    @Published var csvNumber: Int = 0
    @Published var firstRowAsColumnHeaders: Bool = true
    @Published var csvRowList = [CSVColumn]()
    //@Published var csvRowList = [String]()
    //@Published var csvRowList = [CSVRowX]()
    
    func getColumnValue(_ labelCounter: Int)->String {
        
        if labelCounter >= 0 && labelCounter < csvRowList.count
        {
            return csvRowList[labelCounter].csvValue
        }
        return ""
        
    }
      
    
    enum CodingKeys: String, CodingKey {
        case csvNumber
        case firstRowAsColumnHeaders
        case csvRowList
 
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        csvNumber = try container.decodeIfPresent(Int.self, forKey: .csvNumber) ?? 0
        firstRowAsColumnHeaders = try container.decodeIfPresent(Bool.self, forKey: .firstRowAsColumnHeaders) ?? false
        
        var csvRowsArrayForType = try container.nestedUnkeyedContainer(forKey: CodingKeys.csvRowList)
        var newCSVRowList = [CSVColumn]()
        //var newCSVRowList = [String]()

        while(!csvRowsArrayForType.isAtEnd)
        {
            newCSVRowList.append(try csvRowsArrayForType.decode(CSVColumn.self))
        }
        self.csvRowList = newCSVRowList
        
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(csvNumber, forKey: .csvNumber)
        try container.encode(firstRowAsColumnHeaders, forKey: .firstRowAsColumnHeaders)

        try container.encode(csvRowList, forKey: .csvRowList)
 
    }
    
}
