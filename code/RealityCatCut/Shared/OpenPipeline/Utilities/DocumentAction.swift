//
//  Copyright © 2022 James Boo. All rights reserved.
//


import Foundation
import Contacts
class DocumentAction
{
    let pageSettings: PageSettings

    
    init(pageSettings: PageSettings) {
       //self.shapes = shapes
       self.pageSettings = pageSettings
       //self.dataSettings = dataSettings
                
    }
    
    func generate() -> String{
        let encoder=JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        let pageSettingsData = (try? encoder.encode(pageSettings))!
        let pageSettingsDataStr = String(data: pageSettingsData, encoding: .utf8)!

    
        var jsonObject: [String: String] = [String: String]()
        
        jsonObject["page_settings"]=pageSettingsDataStr

        
        if let jsonData = try? encoder.encode(jsonObject) {
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                //print(jsonString)

                var jsonLabel: [String: String] = [String: String]()
                jsonLabel["nodef"]=jsonString

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
                    let strType="nodef"
           
            
                    let labelStr = labelDictionary[strType] as? String
                    
                    if let attributesData = labelStr!.data(using: .utf8) {
                        let attributesDictionary : [String: Any] = (try? JSONSerialization.jsonObject(with: attributesData, options: []) as? [String: Any])!
                        let loadedPageSettingsStr = attributesDictionary["page_settings"] as? String
                        let loadedPageSettings = (try? JSONDecoder().decode(PageSettings.self, from: loadedPageSettingsStr!.data(using: .utf8)!))!
                                                            
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
                        //shapes.shapeList=loadedShapes.shapeList
                        //setupInputTypes()
                        
                        //print("ccount",dataSettings.contactsX.contactList.count)

                        pageSettings.generateLabels() //File Open
                        pageSettings.applyFilters()
                        print("loadedPageSettings:",loadedPageSettings.name,":",loadedPageSettings.numRows,":",loadedPageSettings.numCols)
                                                
                    }
                    

            }

    }
    

}
