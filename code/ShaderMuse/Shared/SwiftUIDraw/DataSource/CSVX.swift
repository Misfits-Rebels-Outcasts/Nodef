//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class CSVX: Codable, ObservableObject {
    
    @Published var firstRowAsColumnHeaders: Bool = true
    @Published var csvRowList = [CSVRowX]()

    init() {

    }
    
    func add(csvRowX: CSVRowX)
    {
        csvRowList.append(csvRowX)
    }
    
    func getRowValue(_ labelCounter: Int,_ column:Int)->String {
        
        if labelCounter >= 0 && labelCounter < csvRowList.count
        {
            if column == 1 {
                return csvRowList[labelCounter].column1
            }
            else if column == 2 {
                return csvRowList[labelCounter].column2
            }
            else if column == 3 {
                return csvRowList[labelCounter].column3
            }
            else if column == 4 {
                return csvRowList[labelCounter].column4
            }
            else if column == 5 {
                return csvRowList[labelCounter].column5
            }
            else if column == 6 {
                return csvRowList[labelCounter].column6
            }
            else if column == 7 {
                return csvRowList[labelCounter].column7
            }
            else if column == 8 {
                return csvRowList[labelCounter].column8
            }
            else if column == 9 {
                return csvRowList[labelCounter].column9
            }
            else if column == 10 {
                return csvRowList[labelCounter].column10
            }
            /*
            else if column == 11 {
                return csvRowList[labelCounter].column11
            }
            else if column == 12 {
                return csvRowList[labelCounter].column12
            }
            else if column == 13 {
                return csvRowList[labelCounter].column13
            }
            else if column == 14 {
                return csvRowList[labelCounter].column14
            }
            else if column == 15 {
                return csvRowList[labelCounter].column15
            }
            else if column == 16 {
                return csvRowList[labelCounter].column16
            }
            else if column == 17 {
                return csvRowList[labelCounter].column17
            }
            else if column == 18 {
                return csvRowList[labelCounter].column18
            }
            else if column == 19 {
                return csvRowList[labelCounter].column19
            }
            else if column == 20 {
                return csvRowList[labelCounter].column20
            }
             */
            else {
                return ""
            }
        }
        return ""
        
    }
    
    enum CodingKeys: String, CodingKey {
      case csvRowList
      case firstRowAsColumnHeaders
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        firstRowAsColumnHeaders = try container.decodeIfPresent(Bool.self, forKey: .firstRowAsColumnHeaders) ?? false
        
        var csvArrayForType = try container.nestedUnkeyedContainer(forKey: CodingKeys.csvRowList)
        var newCSVList = [CSVRowX]()

        while(!csvArrayForType.isAtEnd)
        {
            newCSVList.append(try csvArrayForType.decode(CSVRowX.self))
        }
        self.csvRowList = newCSVList
    }

    func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(firstRowAsColumnHeaders, forKey: .firstRowAsColumnHeaders)
      try container.encode(csvRowList, forKey: .csvRowList)
    }
    
}
