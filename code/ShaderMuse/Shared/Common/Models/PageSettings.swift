//
//  Copyright © 2022 James Boo. All rights reserved.
//


import Foundation
import SwiftUI

struct ILabel: Identifiable {
    var id = UUID()
    var label: Int
    var x:CGFloat
    var y:CGFloat
}

struct PageInfo: Identifiable {
    var id = UUID()
    var pageNumber: Int
    var labelInPage: Int
    var totalLabelsInPage: Int

}

class PageSettings: Codable, ObservableObject, Identifiable, Equatable {
    
    static func == (lhs: PageSettings, rhs: PageSettings) -> Bool {
        return lhs.id==rhs.id
    }
    
    var id = UUID()

    //name,category,vendor,description,orientation
    @Published var name: String = "Standard SLE005"
    @Published var category: String = "Labels"
    @Published var vendor: String = "Standard"
    @Published var description: String = "Address Label (Letter) - 10x3"
    @Published var type: String = "iso-letter"    
    
    @Published var pageWidth: Double = 8.5
    @Published var pageHeight: Double = 11.0
    @Published var leftMargin: Double = 0.188
    @Published var topMargin: Double = 0.5
    @Published var labelWidth: Double = 2.625
    @Published var labelHeight: Double = 1.0
    @Published var hSpace: Double = 0.125
    @Published var vSpace: Double = 0.0
    @Published var numRows: Int = 10
    @Published var numCols: Int = 3
    @Published var dpi: Double =  300.0//72.0
    @Published var labelList = [ILabel]()

    @Published var backgroundURL: URL?
    @Published var originalBackgroundImage: UIImage?
    @Published var backgroundImage: UIImage?
    @Published var filteredBackgroundImage: UIImage?
    var filteredBackgroundImageForVideo: UIImage?
    @Published var thumbImage = UIImage(named: "PhotoImageSmall")!
    //@Published var filters:FiltersX = FiltersX()
    @Published var filters:FiltersX = FiltersX()
    @Published var presets: PresetsX = PresetsX(presetType: "Photo Effects")
    
    @Published var readFX:ReadImageFX?
    
    @Published var isStopped: Bool = true
    @Published var timeElapsed : Double = 0
    @Published var savingInProgress: Bool = false
    
    init() {
        generateLabels()
        //self.filters.add(filter: ColorControlsFX())
        
        let filterXHolder = FilterXHolder()
        filterXHolder.filter=ColorControlsFX()
        self.filters.add(filterHolder: filterXHolder)
        
        

    }
    
    init(image: UIImage) {
        generateLabels()
        //self.filters.add(filter: ColorControlsFX())
        /*
        let filterXHolder = FilterXHolder()
        filterXHolder.filter=ColorControlsFX()
        self.filters.add(filterHolder: filterXHolder)
        */
        var filterXHolder=filters.getFilterWithHolder("Color Controls")
        filters.add(filterHolder: filterXHolder)
        filterXHolder=filters.getFilterWithHolder("Pointillize")
        filters.add(filterHolder: filterXHolder)
        filterXHolder=filters.getFilterWithHolder("FBM Noise")
        filters.add(filterHolder: filterXHolder)
        filterXHolder=filters.getFilterWithHolder("Darken Blend Mode")
        filterXHolder.filter.inputImageAlias=""
        filterXHolder.filter.backgroundImageAlias="2"
        filters.add(filterHolder: filterXHolder)
        filterXHolder=filters.getFilterWithHolder("Difference Blend Mode")
        filterXHolder.filter.inputImageAlias=""
        filterXHolder.filter.backgroundImageAlias="0"
        filters.add(filterHolder: filterXHolder)
        filters.initNodeIndex()
        
        backgroundImage=image
        filteredBackgroundImage=image
    }
    
    func getPresets(presetType: String)->PresetsX
    {
        return PresetsX(presetType: presetType)
    }
    
    /*
    init(name: String,
         category: String,
         vendor: String,
         description: String,
         type: String,
         pageWidth: Double,
         pageHeight: Double,
         leftMargin: Double,
         topMargin: Double,
         labelWidth: Double,
         labelHeight: Double,
         hSpace: Double,
         vSpace: Double,
         numRows: Int,
         numCols: Int,
         dpi: Double) {
        
        self.name=name
        self.category=category
        self.vendor=vendor
        self.description=description
        self.type=type
        self.pageWidth=pageWidth
        self.pageHeight=pageHeight
        self.leftMargin=leftMargin
        self.topMargin=topMargin
        self.labelWidth=labelWidth
        self.labelHeight=labelHeight
        self.hSpace=hSpace
        self.vSpace=vSpace
        self.numRows=numRows
        self.numCols=numCols
        self.dpi=dpi
        
        generateLabels()
        
        self.filters.add(filter: ColorControlsFX())
    }
    */
    func generateLabels()
    {
        generateLabels(dpi:dpi)
    }

    func validLabels(dpi :Double) -> Bool
    {
        labelList = [ILabel]()
        var x = leftMargin * dpi
        var y = topMargin * dpi
        let adjustX = labelWidth / 2.0 * dpi
        let adjustY = labelHeight / 2.0 * dpi
        var count = 1
        var gotValidLabel = false
        for _ in 1...numRows {
            for _ in 1...numCols {
                
                var outsideBoundary = false
                
                if  x < 0 ||
                    y < 0 ||
                    x > pageWidth*dpi ||
                    y > pageHeight*dpi ||
                    x + labelWidth*dpi < 0 ||
                    y + labelHeight*dpi < 0 ||
                    x/dpi + labelWidth - pageWidth > 0.1 ||
                    y/dpi + labelHeight - pageHeight > 0.1
                {
                    outsideBoundary = true
                }
                                
                if outsideBoundary == false
                {
                    labelList.append(ILabel(label: count, x: x + adjustX, y: y + adjustY))
                    gotValidLabel=true
                }
                
                count=count+1
                x = x + hSpace * dpi
                x = x + labelWidth * dpi
            }
            x = leftMargin * dpi
            y = y + vSpace * dpi
            y = y + labelHeight * dpi
        }
        return gotValidLabel
    }
    
    func generateLabels(dpi :Double)
    {
        labelList = [ILabel]()
        var x = leftMargin * dpi
        var y = topMargin * dpi
        let adjustX = labelWidth / 2.0 * dpi
        let adjustY = labelHeight / 2.0 * dpi
        var count = 1
        print ("Label:",numRows,":",numCols,":",pageWidth,":",pageHeight,":",labelWidth,":",labelHeight)
        
        for _ in 1...numRows {
            for _ in 1...numCols {
                
                var outsideBoundary = false
                /*
                print(x,":",y)
                print(labelWidth*dpi,":",labelHeight*dpi)
                print(pageWidth*dpi,":",pageHeight*dpi)
                print("diff:",x/dpi + labelWidth - pageWidth)
                print("diff:",x/dpi + labelHeight - pageHeight)
                 */
                //sometimes pagewidth and pageheight after centimeters etc. the rounding can caused small little
                //e.g pageWidth 4.13 vs 4.1299212 etc. use us envelope 10 to test this out in centimeters
                //multiply the dpi will exercerbate the problem
                /*
                if  x < 0 ||
                    y < 0 ||
                    x > pageWidth*dpi ||
                    y > pageHeight*dpi ||
                    x + labelWidth*dpi < 0 ||
                    y + labelHeight*dpi < 0 ||
                    x + labelWidth*dpi > pageWidth*dpi ||
                    y + labelHeight*dpi > pageHeight*dpi
                 */
                if  x < 0 ||
                    y < 0 ||
                    x > pageWidth*dpi ||
                    y > pageHeight*dpi ||
                    x + labelWidth*dpi < 0 ||
                    y + labelHeight*dpi < 0 ||
                    x/dpi + labelWidth - pageWidth > 0.1 ||
                    y/dpi + labelHeight - pageHeight > 0.1
                    //in inches if x+labelwidth is more than pagewidth  by more than 0.1 inch than outside to give some leeway
                {
                    outsideBoundary = true
                }
                                
                if outsideBoundary == false
                {
                    labelList.append(ILabel(label: count, x: x + adjustX, y: y + adjustY))
                }
                
                count=count+1
                x = x + hSpace * dpi
                x = x + labelWidth * dpi
            }
            x = leftMargin * dpi
            y = y + vSpace * dpi
            y = y + labelHeight * dpi
        }
        print("ee:",labelList.count)
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case category
        case vendor
        case description
        case type
        case pageWidth
        case pageHeight
        case leftMargin
        case topMargin
        case labelWidth
        case labelHeight
        case hSpace
        case vSpace
        case numRows
        case numCols
        case dpi
        case backgroundImage
        case filters
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? "Standard"
        category = try values.decodeIfPresent(String.self, forKey: .category) ?? "Labels"
        vendor = try values.decodeIfPresent(String.self, forKey: .vendor) ?? "Standard"
        description = try values.decodeIfPresent(String.self, forKey: .description) ?? "Address Label (Letter) - 10x3"
        type = try values.decodeIfPresent(String.self, forKey: .type) ?? "iso-letter"
        pageWidth = try values.decodeIfPresent(Double.self, forKey: .pageWidth) ?? 8.5
        pageHeight = try values.decodeIfPresent(Double.self, forKey: .pageHeight) ?? 11.0
        leftMargin = try values.decodeIfPresent(Double.self, forKey: .leftMargin) ?? 0.188
        topMargin = try values.decodeIfPresent(Double.self, forKey: .topMargin) ?? 0.5
        labelWidth = try values.decodeIfPresent(Double.self, forKey: .labelWidth) ?? 2.625
        labelHeight = try values.decodeIfPresent(Double.self, forKey: .labelHeight) ?? 1.0
        hSpace = try values.decodeIfPresent(Double.self, forKey: .hSpace) ??  0.125
        vSpace = try values.decodeIfPresent(Double.self, forKey: .vSpace) ?? 0.0
        numRows = try values.decodeIfPresent(Int.self, forKey: .numRows) ?? 10
        numCols = try values.decodeIfPresent(Int.self, forKey: .numCols) ?? 3
        dpi = try values.decodeIfPresent(Double.self, forKey: .dpi) ?? 300.0
        
        let data = try values.decodeIfPresent(String.self, forKey: .backgroundImage) ?? nil
        if data != nil
        {
            self.filteredBackgroundImage = ImageUtil.convertBase64StringToImage(imageBase64String:data!)
            self.backgroundImage = ImageUtil.convertBase64StringToImage(imageBase64String:data!)
       
        }

        filters = try values.decodeIfPresent(FiltersX.self, forKey: .filters) ??  FiltersX()

        if filters.filterList.count==0
        {
            let filterXHolder = FilterXHolder()
            filterXHolder.filter=ColorControlsFX()
            filters.add(filterHolder: filterXHolder)
        }

    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(category, forKey: .category)        
        try container.encode(vendor, forKey: .vendor)
        try container.encode(description, forKey: .description)
        try container.encode(type, forKey: .type)
        try container.encode(pageWidth, forKey: .pageWidth)
        try container.encode(pageHeight, forKey: .pageHeight)
        try container.encode(leftMargin, forKey: .leftMargin)
        try container.encode(topMargin, forKey: .topMargin)
        try container.encode(labelWidth, forKey: .labelWidth)
        try container.encode(labelHeight, forKey: .labelHeight)
        try container.encode(hSpace, forKey: .hSpace)
        try container.encode(vSpace, forKey: .vSpace)
        try container.encode(numRows, forKey: .numRows)
        try container.encode(numCols, forKey: .numCols)
        try container.encode(dpi, forKey: .dpi)
        if backgroundImage != nil{
            try container.encode(ImageUtil.convertImageToBase64String(img:backgroundImage!), forKey: .backgroundImage)
        }
        try container.encode(filters, forKey: .filters)
        //try container.encode(filters, forKey: .filters)
    }
    
    func applyReadPhoto(uiImage: UIImage)
    {
        readFX?.inputImage=uiImage
        applyFilters()
    }

    func storeOriginalAndApplyPhoto(originalImage:UIImage, backgroundImage: UIImage, dpi: Double)
    {
        originalBackgroundImage=originalImage
        applyPhoto(uiImage: backgroundImage, dpi: dpi)
    }
    
    func applyPhoto(uiImage: UIImage, dpi: Double)
    {
        backgroundImage=uiImage
        filteredBackgroundImage=uiImage
        let heightInPoints = uiImage.size.height
        let heightInPixels = heightInPoints * uiImage.scale
        let widthInPoints = uiImage.size.width
        let widthInPixels = widthInPoints * uiImage.scale
        print("height",heightInPixels)
        print("width",widthInPixels)
                
        print("initPage:",labelTemplatesAll.count)

        self.dpi=dpi
        self.name = "Photo Size"
        category = "Papers"
        vendor = "Standard"
        description = "Photo Size 1x1"
        type = "paper-portrait"
        
        pageWidth = widthInPixels/dpi
        pageHeight = heightInPixels/dpi
        labelWidth = widthInPixels/dpi
        labelHeight = heightInPixels/dpi
        
        hSpace = 0.0
        vSpace = 0.0
        numRows = 1
        numCols = 1
        leftMargin = 0.0
        topMargin = 0.0
         
        filters.size=CGSize(width:widthInPoints, height:heightInPixels)
        filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
        filters.reassignAllBounds()
        
        applyFilters()
        generateLabels()
        
    }
    
    func applyFilters()
    {
        //filteredBackgroundImage=filters.applyFilters(image: backgroundImage)
        if backgroundImage != nil {
            //Fixes - Publishing changes from within view updates is not allowed, this will cause undefined behavior.
            DispatchQueue.main.async(execute: { [self] in
                filteredBackgroundImage=filters.applyFilters(image: backgroundImage!)
            })

        }
    }
    
    func applyFiltersForVideo()
    {
        //filteredBackgroundImage=filters.applyFilters(image: backgroundImage)
        filteredBackgroundImageForVideo=filters.applyFilters(image: backgroundImage!)
    }
    
    func resetViewer()
    {
        filters.resetViewer()
        //comeback
        applyFilters()
    }
    
    func getViewerNodeIndex()->Int
    {
        return filters.viewerIndex
    }
    
    func setViewer(filterXHolder: FilterXHolder)
    {
        filters.setViewer(nodeIndex: filterXHolder.filter.nodeIndex)
        applyFilters()
        /*
        let beginImage = CIImage(image: backgroundImage!)
        
        if let cgimg = filters.context!.createCGImage((filterXHolder.filter.getCIFilter()?.outputImage)!, from: beginImage!.extent) {
            let processedImage = UIImage(cgImage: cgimg, scale: backgroundImage!.scale, orientation: backgroundImage!.imageOrientation)
            filteredBackgroundImage = processedImage
        }
        */
    }
}



