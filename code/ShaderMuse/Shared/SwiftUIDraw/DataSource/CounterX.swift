//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class CounterX: Codable, ObservableObject, Identifiable, Equatable {
    static func == (lhs: CounterX, rhs: CounterX) -> Bool {
        return lhs.id==rhs.id
    }
    var id = UUID()
    
    init(_ counterFieldType: String)
    {
        self.counterFieldType=counterFieldType
        currentValue=startValue-1
    }
    
    @Published var counterFieldType: String = "Counter: 01"
    @Published var startValue: Int = 1
    @Published var stepValue: Int = 1
    @Published var counterLength: Int = 5
    
    @Published var stepOperation: String = "Increment" //Increment, Decrement
    @Published var prefix: String = ""
    @Published var suffix: String = ""
    @Published var padding: String = "No Padding" //Pad Zeros, Pad Spaces, No Padding, Custom Padding
    @Published var padCharacter: String = " "
    
    @Published var rollOverMinimum: Int = 1
    @Published var rollOverMaximum: Int = 99999
    
    
    var currentValue: Int = 0
    var currentValues = [String]()
    
    func resetRollOver(){
        var rollOverMinimumStr = String(rollOverMinimum)
        var rollOverMaximumStr = String(rollOverMaximum)
        
        if counterLength < rollOverMinimumStr.count{
            let i = rollOverMinimumStr.count - counterLength
            for _ in 1...i {
                rollOverMinimumStr.removeLast()
            }
            rollOverMinimum = Int(rollOverMinimumStr) ?? 1
        }
        
        if counterLength < rollOverMaximumStr.count{
            let i = rollOverMaximumStr.count - counterLength
            for _ in 1...i {
                rollOverMaximumStr.removeLast()
            }
            rollOverMaximum = Int(rollOverMaximumStr) ?? 99999
        }
    }
    
    func resetStartValue(){
        var startValueStr = String(startValue)
        
        if counterLength < startValueStr.count{
            let i = startValueStr.count - counterLength
            for _ in 1...i {
                startValueStr.removeLast()
            }
            startValue = Int(startValueStr) ?? 1
        }
        
    }
    
    func initCounterValues() {
        currentValue=startValue
        //genCurrentValue=startValue
        currentValues = [String]()
    }
    
    func getCounterValue(_ labelCounter: Int)->String {
        
        return currentValues[labelCounter]
    }
        
    func generateCounterValues(numLabels: Int){
        if currentValues.count < numLabels{
            for _ in 1...numLabels{
                currentValues.append(getCounterValue())
            }
        }
    }
    
    func getCounterValue()->String {
        var returnValue = currentValue
        
        if stepOperation == "Increment"
        {
            currentValue=currentValue+stepValue
            if currentValue > rollOverMaximum{
                currentValue = rollOverMinimum
            }
        }
        else if stepOperation == "Decrement"
        {
            currentValue=currentValue-stepValue
            if currentValue < rollOverMinimum{
                currentValue = rollOverMaximum
            }
        }
        
        var paddedValue=String(returnValue)
        if paddedValue.count < counterLength
        {
            if padding == "Pad Zeros" {
                paddedValue = String(repeatElement("0", count: counterLength - paddedValue.count)) + paddedValue
            }
            else if padding == "Pad Spaces" {
                paddedValue = String(repeatElement(" ", count: counterLength - paddedValue.count)) + paddedValue
            }
            else if padding == "Custom Padding" {
                paddedValue = String(repeatElement(padCharacter[0], count: counterLength - paddedValue.count)) + paddedValue
            }
        }
        else if paddedValue.count > counterLength{
            let removeCount = paddedValue.count - counterLength
            for _ in 1...removeCount
            {
                paddedValue.removeLast()
            }
        }

        return prefix+paddedValue+suffix
    }
        
    enum CodingKeys: String, CodingKey {
        case counterFieldType
        case startValue
        case stepValue
        case counterLength
        case stepOperation
        case prefix
        case suffix
        case padding
        case padCharacter
        case rollOverMinimum
        case rollOverMaximum
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        counterFieldType = try values.decodeIfPresent(String.self, forKey: .counterFieldType) ?? "Counter: 01"
        startValue = try values.decodeIfPresent(Int.self, forKey: .startValue) ?? 1
        stepValue = try values.decodeIfPresent(Int.self, forKey: .stepValue) ?? 1
        counterLength = try values.decodeIfPresent(Int.self, forKey: .counterLength) ?? 5

        stepOperation = try values.decodeIfPresent(String.self, forKey: .stepOperation) ?? ""
        
        prefix = try values.decodeIfPresent(String.self, forKey: .prefix) ?? ""
        suffix = try values.decodeIfPresent(String.self, forKey: .suffix) ?? ""
        padding = try values.decodeIfPresent(String.self, forKey: .padding) ?? "No Padding"
        padCharacter = try values.decodeIfPresent(String.self, forKey: .padCharacter) ?? "X"

        rollOverMinimum = try values.decodeIfPresent(Int.self, forKey: .rollOverMinimum) ?? 1
        rollOverMaximum = try values.decodeIfPresent(Int.self, forKey: .rollOverMaximum) ?? 99999

    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(counterFieldType, forKey: .counterFieldType)
        try container.encode(startValue, forKey: .startValue)
        try container.encode(stepValue, forKey: .stepValue)
        try container.encode(counterLength, forKey: .counterLength)
        try container.encode(stepOperation, forKey: .stepOperation)

        try container.encode(prefix, forKey: .prefix)
        try container.encode(suffix, forKey: .suffix)
        try container.encode(padding, forKey: .padding)
        try container.encode(padCharacter, forKey: .padCharacter)
        try container.encode(rollOverMinimum, forKey: .rollOverMinimum)
        try container.encode(rollOverMaximum, forKey: .rollOverMaximum)
    }
    
}
