//
//  Copyright © 2022 James Boo. All rights reserved.
//


import Foundation

public struct POSTNET {

    
    public var inputData=""
    public var humanReadableText=""
    
    init() {
        self.inputData="12345678"
    }
    
    public init(_ inputData:String) {
        self.inputData=inputData
    }

    func getPOSTNETValue(_ inputChar:Character) -> Int {
         return (Int)(inputChar.asciiValue!) - 48
    }
    
    func filterInput (_ inputData:String) -> String {
        var retStr=""
        
        inputData.forEach { char in
            if let uchar = char.asciiValue {
                let barcodevalue=Int(uchar)

                if barcodevalue <= 57 && barcodevalue >= 48
                {
                    retStr = retStr + "\(char)"
                }
            }
        }
        
        return retStr

    }
    
    public mutating func encode () -> String {
        
        var cd=""
        var result=""
        var filtereddata = filterInput(inputData)
        let filteredlength=filtereddata.count

        if (filteredlength > 11)
        {
            filtereddata=String(filtereddata.prefix(11))
        }

        cd=generateCheckDigit(filtereddata);

        humanReadableText=filtereddata+cd
        result="{"+filtereddata+cd+"}"
        return result
    
        
    }
    
    public func getHumanReadableText()->String{
        return humanReadableText
    }
    
    func getPOSTNETCharacter(_ inputdecimal:Int) -> String
    {
        return String(UnicodeScalar(inputdecimal+48)!)
    }
    
    func generateCheckDigit(_ bdata:String)->String
    {
        var datalength=0
        var sum = 0
        var result = -1
        var strResult=""
        
        datalength=bdata.count
        if datalength>0
        {
            for x in 0...datalength-1
            {
                let barcodechar = bdata[x]
                sum = sum + getPOSTNETValue(barcodechar)
            }
        }
        
        result=sum % 10
        if result != 0
        {
            result = 10 - result
        }
        
        strResult=getPOSTNETCharacter(result)
        
        return strResult
        
    }


}
