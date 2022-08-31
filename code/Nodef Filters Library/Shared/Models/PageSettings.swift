//
//  Copyright © 2022 James Boo. All rights reserved.
//

import Foundation
import SwiftUI

class PageSettings: Codable, ObservableObject, Identifiable, Equatable {
    
    static func == (lhs: PageSettings, rhs: PageSettings) -> Bool {
        return lhs.id==rhs.id
    }
    
    var id = UUID()

    @Published var name: String = "Nodef"

    @Published var backgroundURL: URL?
    @Published var backgroundImage: UIImage? 
    @Published var filteredBackgroundImage: UIImage?
    @Published var thumbImage = UIImage(named: "PhotoImageSmall")!
    @Published var filters:FiltersX = FiltersX()
    //@Published var presets: PresetsX = PresetsX(presetType: "Photo Effects")
    @Published var readFX:ReadImageFX?
    
    init() {
        //let filterXHolder = FilterXHolder()
        //filterXHolder.filter=ColorControlsFX()
        //self.filters.add(filterHolder: filterXHolder)
    }
    
    init(image: UIImage) {
        
        let filterXHolder = FilterXHolder()
        filterXHolder.filter=ColorControlsFX()
        self.filters.add(filterHolder: filterXHolder)
        
        backgroundImage=image
        filteredBackgroundImage=image
    }
    
    func getPresets(presetType: String)->PresetsX
    {
        return PresetsX(presetType: presetType)
    }
    
    enum CodingKeys: String, CodingKey {
        case name

        case backgroundImage
        case filters
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? "Standard"
        /*
        let data = try values.decodeIfPresent(String.self, forKey: .backgroundImage) ?? nil
        if data != nil
        {
            self.filteredBackgroundImage = ImageUtil.convertBase64StringToImage(imageBase64String:data!)
            self.backgroundImage = ImageUtil.convertBase64StringToImage(imageBase64String:data!)
       
        }
         */
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

        /*
        try container.encode(ImageUtil.convertImageToBase64String(img:backgroundImage!), forKey: .backgroundImage)
         */
        try container.encode(filters, forKey: .filters)

    }
    
    func applyReadPhoto(uiImage: UIImage)
    {
        readFX?.inputImage=uiImage
        applyFilters()
    }
    
    func applyPhoto(uiImage: UIImage, dpi: Double)
    {
        backgroundImage=uiImage
        filteredBackgroundImage=uiImage
        let heightInPoints = uiImage.size.height
        let heightInPixels = heightInPoints * uiImage.scale
        let widthInPoints = uiImage.size.width
        let widthInPixels = widthInPoints * uiImage.scale

        self.name = "Photo Size"

         
        filters.size=CGSize(width:widthInPoints, height:heightInPixels)
        filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
        filters.reassignAllBounds()
        
        applyFilters()

        
    }
    
    func applyFilters()
    {

        filteredBackgroundImage=filters.applyFilters(image: backgroundImage!)
    }
    func resetViewer()
    {
        filters.resetViewer()
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

    }
}



