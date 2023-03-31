//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class TemplateViewModel: BaseViewModel {
    //need to put as published??
    //this is different from shapepropertiesviewmodel
    //as there is no bind
    //it is also possible to inject environment variable in here
    //so that the setup can be in this class
    @Published var name: String = "Standard SLE005"
    @Published var category: String = "Labels"
    @Published var vendor: String = "Standard"
    @Published var description: String = "Address Label (Letter) - 10x3"
    @Published var type: String = "iso-letter"
    @Published var units: String = "Inches"
    @Published var pageWidth: String = "8.5"
    @Published var pageHeight: String = "11.0"
    @Published var leftMargin: String = "0.188"
    @Published var topMargin: String = "0.5"
    @Published var labelWidth: String = "2.625"
    @Published var labelHeight: String = "1.0"
    @Published var hSpace: String = "0.125"
    @Published var vSpace: String = "0.0"
    @Published var numRows: String = "10"
    @Published var numCols: String = "3"
    //var dpi: Double =  300.0
    @Published var selectedTemplateIndex: Int = 0
    @Published var templateCount: Int = 11
    
    @Published var previewFactor: Double = 0.25
    
    @Published var templateHeaderName = "Template"
    @Published var previewHeaderName = "Preview"
    @Published var pageHeaderName = "Page Dimensions"
    @Published var labelHeaderName = "Label Dimensions"
    
    //@Published var focusTop = false
    
    //see TemplateViewX skipOnCh angeNotes
    var skipOnChange = false

    //@Published var selectedCategoryIndex: Int = 0
    //@Published var selectedVendorIndex: Int = 0
    
    let pageSettings: PageSettings
    init(units: String, pageSettings: PageSettings) {
       self.units=units
       self.pageSettings = pageSettings
        
        name = pageSettings.name
        category = pageSettings.category
        print("PS:",pageSettings.vendor)
        vendor = pageSettings.vendor
        description = pageSettings.description
        type = pageSettings.type
        
        var inchOrCM = 1.0
        if units != "Inches"
        {
            inchOrCM = 2.54
        }
        pageWidth = String(format: "%.3f", pageSettings.pageWidth*inchOrCM)
        pageHeight = String(format: "%.3f", pageSettings.pageHeight*inchOrCM)
        leftMargin = String(format: "%.3f", pageSettings.leftMargin*inchOrCM)
        topMargin = String(format: "%.3f", pageSettings.topMargin*inchOrCM)
        labelWidth = String(format: "%.3f", pageSettings.labelWidth*inchOrCM)
        labelHeight = String(format: "%.3f", pageSettings.labelHeight*inchOrCM)
        hSpace = String(format: "%.3f", pageSettings.hSpace*inchOrCM)
        vSpace = String(format: "%.3f", pageSettings.vSpace*inchOrCM)
        numRows = String(pageSettings.numRows)
        numCols = String(pageSettings.numCols)

    }

    func setupPageSettingsAndTemplateModel(tempPageSettings: PageSettings, selectedTemplateIndex: Int)
    {
        
        templateHeaderName = "Template"
        
        let x = selectedTemplateIndex
        print("setupPageSettingsAndTemplateModel:",x)
        tempPageSettings.name = labelTemplates[x][0]
        tempPageSettings.category = labelTemplates[x][1]
        tempPageSettings.vendor = labelTemplates[x][2]
        tempPageSettings.description = labelTemplates[x][3]
        tempPageSettings.type = labelTemplates[x][4]
        print(tempPageSettings.description)
        if tempPageSettings.type == "envelope-landscape"
        {
            tempPageSettings.pageHeight = Double(labelTemplates[x][5]) ?? 1.0
            tempPageSettings.pageWidth = Double(labelTemplates[x][6]) ?? 1.0
            tempPageSettings.labelHeight = Double(labelTemplates[x][7]) ?? 1.0
            tempPageSettings.labelWidth = Double(labelTemplates[x][8]) ?? 1.0
            tempPageSettings.vSpace = Double(labelTemplates[x][9]) ?? 0.0
            tempPageSettings.hSpace = Double(labelTemplates[x][10]) ?? 0.0
            tempPageSettings.numCols = Int(labelTemplates[x][11]) ?? 1
            tempPageSettings.numRows = Int(labelTemplates[x][12]) ?? 1
            tempPageSettings.topMargin = Double(labelTemplates[x][13]) ?? 0.0
            tempPageSettings.leftMargin = Double(labelTemplates[x][14]) ?? 0.0
        }
        else{
            tempPageSettings.pageWidth = Double(labelTemplates[x][5]) ?? 1.0
            tempPageSettings.pageHeight = Double(labelTemplates[x][6]) ?? 1.0
            tempPageSettings.labelWidth = Double(labelTemplates[x][7]) ?? 1.0
            tempPageSettings.labelHeight = Double(labelTemplates[x][8]) ?? 1.0
            tempPageSettings.hSpace = Double(labelTemplates[x][9]) ?? 0.0
            tempPageSettings.vSpace = Double(labelTemplates[x][10]) ?? 0.0
            tempPageSettings.numRows = Int(labelTemplates[x][11]) ?? 1
            tempPageSettings.numCols = Int(labelTemplates[x][12]) ?? 1
            tempPageSettings.leftMargin = Double(labelTemplates[x][13]) ?? 0.0
            tempPageSettings.topMargin = Double(labelTemplates[x][14]) ?? 0.0
        }
        
        tempPageSettings.generateLabels(dpi:72)
        
        
        name = tempPageSettings.name
        category = tempPageSettings.category
        vendor = tempPageSettings.vendor
        description = tempPageSettings.description
        type = tempPageSettings.type
        var inchOrCM = 1.0
        if units != "Inches"
        {
            inchOrCM = 2.54
        }
        pageWidth = String(format: "%.3f", tempPageSettings.pageWidth*inchOrCM)
        pageHeight = String(format: "%.3f", tempPageSettings.pageHeight*inchOrCM)
        leftMargin = String(format: "%.3f", tempPageSettings.leftMargin*inchOrCM)
        topMargin = String(format: "%.3f", tempPageSettings.topMargin*inchOrCM)
        labelWidth = String(format: "%.3f", tempPageSettings.labelWidth*inchOrCM)
        labelHeight = String(format: "%.3f", tempPageSettings.labelHeight*inchOrCM)
        hSpace = String(format: "%.3f", tempPageSettings.hSpace*inchOrCM)
        vSpace = String(format: "%.3f", tempPageSettings.vSpace*inchOrCM)
        numRows = String(tempPageSettings.numRows)
        numCols = String(tempPageSettings.numCols)
    }


    //use by create label only
    func setupPageSettings(selectedTemplateIndex: Int)
    {
        let x = selectedTemplateIndex
        print("setupPageSettings:",x)
        pageSettings.name = labelTemplates[x][0]
        pageSettings.category = labelTemplates[x][1]
        pageSettings.vendor = labelTemplates[x][2]
        pageSettings.description = labelTemplates[x][3]
        pageSettings.type = labelTemplates[x][4]
        if pageSettings.type == "envelope-landscape"
        {
            pageSettings.pageHeight = Double(labelTemplates[x][5]) ?? 1.0
            pageSettings.pageWidth = Double(labelTemplates[x][6]) ?? 1.0
            pageSettings.labelHeight = Double(labelTemplates[x][7]) ?? 1.0
            pageSettings.labelWidth = Double(labelTemplates[x][8]) ?? 1.0
            pageSettings.vSpace = Double(labelTemplates[x][9]) ?? 0.0
            pageSettings.hSpace = Double(labelTemplates[x][10]) ?? 0.0
            pageSettings.numCols = Int(labelTemplates[x][11]) ?? 1
            pageSettings.numRows = Int(labelTemplates[x][12]) ?? 1
            pageSettings.topMargin = Double(labelTemplates[x][13]) ?? 0.0
            pageSettings.leftMargin = Double(labelTemplates[x][14]) ?? 0.0
        }
        else{
            pageSettings.pageWidth = Double(labelTemplates[x][5]) ?? 1.0
            pageSettings.pageHeight = Double(labelTemplates[x][6]) ?? 1.0
            pageSettings.labelWidth = Double(labelTemplates[x][7]) ?? 1.0
            pageSettings.labelHeight = Double(labelTemplates[x][8]) ?? 1.0
            pageSettings.hSpace = Double(labelTemplates[x][9]) ?? 0.0
            pageSettings.vSpace = Double(labelTemplates[x][10]) ?? 0.0
            pageSettings.numRows = Int(labelTemplates[x][11]) ?? 1
            pageSettings.numCols = Int(labelTemplates[x][12]) ?? 1
            pageSettings.leftMargin = Double(labelTemplates[x][13]) ?? 0.0
            pageSettings.topMargin = Double(labelTemplates[x][14]) ?? 0.0
        }
        
        pageSettings.generateLabels()
    }

}

