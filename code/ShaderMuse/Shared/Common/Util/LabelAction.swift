//
//  Copyright © 2022 James Boo. All rights reserved.
//


import Foundation
import Contacts
class LabelAction
{
    let pageSettings: PageSettings
    let dataSettings: DataSettings
    let shapes: ShapesX
    
    init(shapes: ShapesX, pageSettings: PageSettings, dataSettings: DataSettings) {
       self.shapes = shapes
       self.pageSettings = pageSettings
       self.dataSettings = dataSettings
                
    }

    func generate() -> String{
        let encoder=JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        let shapesData = (try? encoder.encode(shapes))!
        let shapesDataStr = String(data: shapesData, encoding: .utf8)!
        let pageSettingsData = (try? encoder.encode(pageSettings))!
        let pageSettingsDataStr = String(data: pageSettingsData, encoding: .utf8)!

        let contactsSettingsData = (try? encoder.encode(dataSettings.contactsX))!
        let contactsSettingsDataStr = String(data: contactsSettingsData, encoding: .utf8)!

        let countersSettingsData = (try? encoder.encode(dataSettings.countersX))!
        let countersSettingsDataStr = String(data: countersSettingsData, encoding: .utf8)!

        let csvsSettingsData = (try? encoder.encode(dataSettings.csvx))!
        let csvsSettingsDataStr = String(data: csvsSettingsData, encoding: .utf8)!

        let csvsSettingsHeader = (try? encoder.encode(dataSettings.csvHeader))!
        let csvsSettingsHeaderStr = String(data: csvsSettingsHeader, encoding: .utf8)!
        
        var jsonObject: [String: String] = [String: String]()
        
        jsonObject["page_settings"]=pageSettingsDataStr
        jsonObject["shapes"]=shapesDataStr
        jsonObject["contacts"]=contactsSettingsDataStr
        jsonObject["counters"]=countersSettingsDataStr
        jsonObject["csvs"]=csvsSettingsDataStr
        jsonObject["csvs_headers"]=csvsSettingsHeaderStr
        
        if let jsonData = try? encoder.encode(jsonObject) {
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                //print(jsonString)

                var jsonLabel: [String: String] = [String: String]()
                if appType == "B"
                {
                    jsonLabel["label"]=jsonString
                }
                else
                {
                    jsonLabel["nodef"]=jsonString
                }

                if let jsonLabelData = try? encoder.encode(jsonLabel) {
                    if let jsonLabelString = String(data: jsonLabelData, encoding: .utf8) {
                                             
                        return jsonLabelString
                
                    }
                }
                
            }
        }
        
        return ""
    }
    
    func load(jsonLabelStr: String)
    {
        if let data = jsonLabelStr.data(using: .utf8) {
                //do {
                    let labelDictionary : [String: Any] = (try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any])!
                    var strType="label"
                    if appType == "B"
                    {
                        strType="label"
                    }
                    else
                    {
                        strType="nodef"
                    }
            
                    let labelStr = labelDictionary[strType] as? String
                    
                    if let attributesData = labelStr!.data(using: .utf8) {
                        let attributesDictionary : [String: Any] = (try? JSONSerialization.jsonObject(with: attributesData, options: []) as? [String: Any])!
                        let loadedPageSettingsStr = attributesDictionary["page_settings"] as? String
                        let loadedPageSettings = (try? JSONDecoder().decode(PageSettings.self, from: loadedPageSettingsStr!.data(using: .utf8)!))!
                        let loadedShapesStr = attributesDictionary["shapes"] as? String
                        let loadedShapes = (try? JSONDecoder().decode(ShapesX.self, from: loadedShapesStr!.data(using: .utf8)!))!
                        
                        let loadedContactsStr = attributesDictionary["contacts"] as? String
                        if loadedContactsStr == nil //failsafe for loading existing labels
                        {
                            dataSettings.clearContactsX()
                        }
                        else{
                            let loadedContacts = (try? JSONDecoder().decode(ContactsX.self, from: loadedContactsStr!.data(using: .utf8)!))!
                            dataSettings.contactsX.contactList=loadedContacts.contactList
                            dataSettings.contactCounter=0
                            dataSettings.contacts=[CNContact]()
                        }
                        
                        let loadedCountersStr = attributesDictionary["counters"] as? String
                        if loadedCountersStr == nil //failsafe for loading existing labels
                        {
                            dataSettings.clearCountersX()
                        }
                        else{
                            let loadedCounters = (try? JSONDecoder().decode(CountersX.self, from: loadedCountersStr!.data(using: .utf8)!))!
                            dataSettings.countersX.counterList=loadedCounters.counterList
                        }
                        
                        let loadedCSVsStr = attributesDictionary["csvs"] as? String
                        let loadedCSVHeadersStr = attributesDictionary["csvs_headers"] as? String

                        if loadedCSVsStr == nil //failsafe for loading existing labels
                        {
                            dataSettings.clearCSVX()
                        }
                        else{
                            let loadedCSVs = (try? JSONDecoder().decode(CSVX.self, from: loadedCSVsStr!.data(using: .utf8)!))!
                            dataSettings.csvx.csvRowList=loadedCSVs.csvRowList
                        }
                        if loadedCSVHeadersStr == nil {
                            dataSettings.csvHeader.column1=""
                            dataSettings.csvHeader.column2=""
                            dataSettings.csvHeader.column3=""
                            dataSettings.csvHeader.column4=""
                            dataSettings.csvHeader.column5=""
                            dataSettings.csvHeader.column6=""
                            dataSettings.csvHeader.column7=""
                            dataSettings.csvHeader.column8=""
                            dataSettings.csvHeader.column9=""
                            dataSettings.csvHeader.column10=""
                        }
                        else{
                            let loadedCSVHeaders = (try? JSONDecoder().decode(CSVRowX.self, from: loadedCSVHeadersStr!.data(using: .utf8)!))!
                            dataSettings.csvHeader.column1=loadedCSVHeaders.column1
                            dataSettings.csvHeader.column2=loadedCSVHeaders.column2
                            dataSettings.csvHeader.column3=loadedCSVHeaders.column3
                            dataSettings.csvHeader.column4=loadedCSVHeaders.column4
                            dataSettings.csvHeader.column5=loadedCSVHeaders.column5
                            dataSettings.csvHeader.column6=loadedCSVHeaders.column6
                            dataSettings.csvHeader.column7=loadedCSVHeaders.column7
                            dataSettings.csvHeader.column8=loadedCSVHeaders.column8
                            dataSettings.csvHeader.column9=loadedCSVHeaders.column9
                            dataSettings.csvHeader.column10=loadedCSVHeaders.column10
                            
                        }
                                                                        
                        pageSettings.dpi=loadedPageSettings.dpi
                        pageSettings.name=loadedPageSettings.name
                        pageSettings.category=loadedPageSettings.category
                        pageSettings.vendor=loadedPageSettings.vendor
                        pageSettings.description=loadedPageSettings.description
                        pageSettings.type=loadedPageSettings.type
                        pageSettings.pageWidth=loadedPageSettings.pageWidth
                        pageSettings.pageHeight=loadedPageSettings.pageHeight
                        pageSettings.labelWidth=loadedPageSettings.labelWidth
                        pageSettings.labelHeight=loadedPageSettings.labelHeight
                        pageSettings.leftMargin=loadedPageSettings.leftMargin
                        pageSettings.topMargin=loadedPageSettings.topMargin
                        pageSettings.labelWidth=loadedPageSettings.labelWidth
                        pageSettings.hSpace=loadedPageSettings.hSpace
                        pageSettings.vSpace=loadedPageSettings.vSpace
                        pageSettings.numRows=loadedPageSettings.numRows
                        pageSettings.numCols=loadedPageSettings.numCols
                        pageSettings.dpi=loadedPageSettings.dpi
                        pageSettings.backgroundImage=loadedPageSettings.backgroundImage
                        pageSettings.filteredBackgroundImage=loadedPageSettings.backgroundImage
                        pageSettings.filters=loadedPageSettings.filters
                        //pageSettings.filters.reassignIndex()
                        pageSettings.filters.initNodeIndex()
                        pageSettings.filters.reassignAllBounds()
                        shapes.shapeList=loadedShapes.shapeList
                        setupInputTypes()
                        
                        print("ccount",dataSettings.contactsX.contactList.count)

                        pageSettings.generateLabels() //File Open
                        pageSettings.applyFilters()
                        print("loadedPageSettings:",loadedPageSettings.name,":",loadedPageSettings.numRows,":",loadedPageSettings.numCols)
                                                
                    }
                    

            }

    }
    
    
    func setupInputTypes(){

        for x in 0...textTypes.count-1 {
            
            if textTypes[x].starts(with: "CSV Column: 01")
            {
                if dataSettings.csvHeader.column1 != "" {
                    textTypes[x]="CSV Column: 01"+" ("+dataSettings.csvHeader.column1+")"
                }
                else {
                    textTypes[x]="CSV Column: 01"
                }
            }
            else if textTypes[x].starts(with: "CSV Column: 02")
            {
                if dataSettings.csvHeader.column2 != "" {
                    textTypes[x]="CSV Column: 02"+" ("+dataSettings.csvHeader.column2+")"
                }
                else {
                    textTypes[x]="CSV Column: 02"
                }
            }
            else if textTypes[x].starts(with: "CSV Column: 03")
            {
                if dataSettings.csvHeader.column3 != "" {
                    textTypes[x]="CSV Column: 03"+" ("+dataSettings.csvHeader.column3+")"
                }
                else {
                    textTypes[x]="CSV Column: 03"
                }
            }
            else if textTypes[x].starts(with: "CSV Column: 04")
            {
                if dataSettings.csvHeader.column4 != "" {
                    textTypes[x]="CSV Column: 04"+" ("+dataSettings.csvHeader.column4+")"
                }
                else {
                    textTypes[x]="CSV Column: 04"
                }
            }
            else if textTypes[x].starts(with: "CSV Column: 05")
            {
                if dataSettings.csvHeader.column5 != "" {
                    textTypes[x]="CSV Column: 05"+" ("+dataSettings.csvHeader.column5+")"
                }
                else {
                    textTypes[x]="CSV Column: 05"
                }
            }
            else if textTypes[x].starts(with: "CSV Column: 06")
            {
                if dataSettings.csvHeader.column6 != "" {
                    textTypes[x]="CSV Column: 06"+" ("+dataSettings.csvHeader.column6+")"
                }
                else {
                    textTypes[x]="CSV Column: 06"
                }
            }
            else if textTypes[x].starts(with: "CSV Column: 07")
            {
                if dataSettings.csvHeader.column7 != "" {
                    textTypes[x]="CSV Column: 07"+" ("+dataSettings.csvHeader.column7+")"
                }
                else {
                    textTypes[x]="CSV Column: 07"
                }
            }
            else if textTypes[x].starts(with: "CSV Column: 08")
            {
                if dataSettings.csvHeader.column8 != "" {
                    textTypes[x]="CSV Column: 08"+" ("+dataSettings.csvHeader.column8+")"
                }
                else {
                    textTypes[x]="CSV Column: 08"
                }
            }
            else if textTypes[x].starts(with: "CSV Column: 09")
            {
                if dataSettings.csvHeader.column9 != "" {
                    textTypes[x]="CSV Column: 09"+" ("+dataSettings.csvHeader.column9+")"
                }
                else {
                    textTypes[x]="CSV Column: 09"
                }
            }
            else if textTypes[x].starts(with: "CSV Column: 10")
            {
                if dataSettings.csvHeader.column10 != "" {
                    textTypes[x]="CSV Column: 10"+" ("+dataSettings.csvHeader.column10+")"
                }
                else {
                    textTypes[x]="CSV Column: 10"
                }
            }

        }
        
        for x in 0...barcodeInputTypes.count-1 {
            
            if barcodeInputTypes[x].starts(with: "CSV Column: 01")
            {
                if dataSettings.csvHeader.column1 != "" {
                    barcodeInputTypes[x]="CSV Column: 01"+" ("+dataSettings.csvHeader.column1+")"
                }
                else {
                    barcodeInputTypes[x]="CSV Column: 01"
                }
            }
            else if barcodeInputTypes[x].starts(with: "CSV Column: 02")
            {
                if dataSettings.csvHeader.column2 != "" {
                    barcodeInputTypes[x]="CSV Column: 02"+" ("+dataSettings.csvHeader.column2+")"
                }
                else {
                    barcodeInputTypes[x]="CSV Column: 02"
                }
            }
            else if barcodeInputTypes[x].starts(with: "CSV Column: 03")
            {
                if dataSettings.csvHeader.column3 != "" {
                    barcodeInputTypes[x]="CSV Column: 03"+" ("+dataSettings.csvHeader.column3+")"
                }
                else {
                    barcodeInputTypes[x]="CSV Column: 03"
                }
            }
            else if barcodeInputTypes[x].starts(with: "CSV Column: 04")
            {
                if dataSettings.csvHeader.column4 != "" {
                    barcodeInputTypes[x]="CSV Column: 04"+" ("+dataSettings.csvHeader.column4+")"
                }
                else {
                    barcodeInputTypes[x]="CSV Column: 04"
                }
            }
            else if barcodeInputTypes[x].starts(with: "CSV Column: 05")
            {
                if dataSettings.csvHeader.column5 != "" {
                    barcodeInputTypes[x]="CSV Column: 05"+" ("+dataSettings.csvHeader.column5+")"
                }
                else {
                    barcodeInputTypes[x]="CSV Column: 05"
                }
            }
            else if barcodeInputTypes[x].starts(with: "CSV Column: 06")
            {
                if dataSettings.csvHeader.column6 != "" {
                    barcodeInputTypes[x]="CSV Column: 06"+" ("+dataSettings.csvHeader.column6+")"
                }
                else {
                    barcodeInputTypes[x]="CSV Column: 06"
                }
            }
            else if barcodeInputTypes[x].starts(with: "CSV Column: 07")
            {
                if dataSettings.csvHeader.column7 != "" {
                    barcodeInputTypes[x]="CSV Column: 07"+" ("+dataSettings.csvHeader.column7+")"
                }
                else {
                    barcodeInputTypes[x]="CSV Column: 07"
                }
            }
            else if barcodeInputTypes[x].starts(with: "CSV Column: 08")
            {
                if dataSettings.csvHeader.column8 != "" {
                    barcodeInputTypes[x]="CSV Column: 08"+" ("+dataSettings.csvHeader.column8+")"
                }
                else {
                    barcodeInputTypes[x]="CSV Column: 08"
                }
            }
            else if barcodeInputTypes[x].starts(with: "CSV Column: 09")
            {
                if dataSettings.csvHeader.column9 != "" {
                    barcodeInputTypes[x]="CSV Column: 09"+" ("+dataSettings.csvHeader.column9+")"
                }
                else {
                    barcodeInputTypes[x]="CSV Column: 09"
                }
            }
            else if barcodeInputTypes[x].starts(with: "CSV Column: 10")
            {
                if dataSettings.csvHeader.column10 != "" {
                    barcodeInputTypes[x]="CSV Column: 10"+" ("+dataSettings.csvHeader.column10+")"
                }
                else {
                    barcodeInputTypes[x]="CSV Column: 10"
                }
            }

        }
    }
    
}
