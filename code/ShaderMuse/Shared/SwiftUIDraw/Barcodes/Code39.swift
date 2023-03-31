//
//  Copyright © 2022 James Boo. All rights reserved.
//



import Foundation

extension String {
    subscript (index: Int) -> Character {
        let charIndex = self.index(self.startIndex, offsetBy: index)
        return self[charIndex]
    }

    subscript (range: Range<Int>) -> Substring {
        let startIndex = self.index(self.startIndex, offsetBy: range.startIndex)
        let stopIndex = self.index(self.startIndex, offsetBy: range.startIndex + range.count)
        return self[startIndex..<stopIndex]
    }

}

/*
extension String {
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
}
*/
public struct Code39 {

    let CODE39MAP = ["0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","-","."," ","$","/","+","%"]
    
    public var inputData=""
    public var checkDigit=1
    public var humanReadableText=""
    
    init() {
        self.inputData="12345678"
        self.checkDigit=1
    }
    
    public init(_ inputData:String, _ checkDigit:Int) {
        self.inputData=inputData
        self.checkDigit=checkDigit
    }

    func getCode39Value(_ inputChar:Character) -> Int {
        
        guard let cVal = CODE39MAP.firstIndex(of: "\(inputChar)") else {
            return -1
        }
     
        return cVal;
    }
    
    func filterInput (_ inputData:String) -> String {
        var retStr=""
        inputData.forEach { char in
            if (CODE39MAP.contains("\(char)"))
            {
                retStr = retStr + "\(char)"
            }
        }
        return retStr
    }
    
    public mutating func encode () -> String {
        
        var cd=""
        var result=""
        var filtereddata = filterInput(inputData)
        let filteredlength=filtereddata.count
        
        if (checkDigit==1)
        {
            if (filteredlength > 254)
            {
                filtereddata=String(filtereddata.prefix(254))
            }
            cd=generateCheckDigit(filtereddata);
        }
        else
        {
            if (filteredlength > 255)
            {
                filtereddata=String(filtereddata.prefix(255))
            }
        }
        result="*"+filtereddata+cd+"*"
        humanReadableText=result
        return result
    
        
    }
    
    public func getHumanReadableText()->String{
        return humanReadableText
    }
    
    func getCode39Character(_ inputdecimal:Int) -> String
    {
        let str=CODE39MAP[inputdecimal]
        return str
    }
    
    func generateCheckDigit(_ bdata:String)->String
    {
        var datalength=0
        var sum = 0
        var result = -1
        var strResult=""
        
        datalength=bdata.count
        //guard the for loop
        if datalength>0
        {
            for x in 0...datalength-1
            {
                let barcodechar = bdata[bdata.index(bdata.startIndex, offsetBy: x)]
                sum = sum + getCode39Value(barcodechar);
            }
        }
        result=sum % 43
        strResult=getCode39Character(result)
        
        return strResult
        
    }


}
