//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

struct PhotoMainViewX: View {
    
    @EnvironmentObject var pageSettings: PageSettings
    
    var body: some View {
        Image(uiImage: pageSettings.filteredBackgroundImage!)
            .resizable()
            .edgesIgnoringSafeArea(.all)
            .scaledToFit()
            .onAppear(perform: initPage)
    }
    
    func initPage() {

        pageSettings.applyPhoto(uiImage: pageSettings.backgroundImage!, dpi:1000)
        
        //Test Filter Chaining, Blending, and Compositing
        //pageSettings.filteredBackgroundImage=createOneFilter(pageSettings.backgroundImage!)
        //pageSettings.filteredBackgroundImage=chainFilters(pageSettings.backgroundImage!)
        //pageSettings.filteredBackgroundImage=blendFilters(pageSettings.backgroundImage!)
        //pageSettings.filteredBackgroundImage=generatorFilters(pageSettings.backgroundImage!)
        //pageSettings.filteredBackgroundImage=filterProperties(pageSettings.backgroundImage!)
        //pageSettings.filteredBackgroundImage=compositingFilters(pageSettings.backgroundImage!)
        pageSettings.filteredBackgroundImage=nodeGraphFilters(pageSettings.backgroundImage!)
        
        
        //Test filters JSON generate
        let filters = FiltersX()
        filters.add(filterHolder: filters.getFilterWithHolder("Color Controls"))
        filters.add(filterHolder: filters.getFilterWithHolder("Sepia Tone"))
        filters.add(filterHolder: filters.getFilterWithHolder("Zoom Blur"))
        pageSettings.filters = filters
        
        let encoder=JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        let pageSettingsData = (try? encoder.encode(pageSettings))!
        let pageSettingsDataStr = String(data: pageSettingsData, encoding: .utf8)!

        var jsonObject: [String: String] = [String: String]()
        var savedJSONStr = ""
        jsonObject["page_settings"]=pageSettingsDataStr

        
        if let jsonData = try? encoder.encode(jsonObject) {
            if let jsonString = String(data: jsonData, encoding: .utf8) {

                var jsonLabel: [String: String] = [String: String]()
                jsonLabel["nodef"]=jsonString
                
                if let jsonLabelData = try? encoder.encode(jsonLabel) {
                    if let jsonLabelString = String(data: jsonLabelData, encoding: .utf8) {
                        savedJSONStr=jsonLabelString
                    }
                }
            }
        }
        
        //Test filters JSON load
        if let data = savedJSONStr.data(using: .utf8) {
                    let labelDictionary : [String: Any] = (try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any])!
                    let labelStr = labelDictionary["nodef"] as? String
                    
                    if let attributesData = labelStr!.data(using: .utf8) {
                        let attributesDictionary : [String: Any] = (try? JSONSerialization.jsonObject(with: attributesData, options: []) as? [String: Any])!
                        let loadedPageSettingsStr = attributesDictionary["page_settings"] as? String
                        
                        print(loadedPageSettingsStr as Any)
                    }
        }

                         
    }
    
    func createOneFilter(_ inputImage: UIImage) -> UIImage {
        
        let filters = FiltersX()
        filters.add(filterHolder: filters.getFilterWithHolder("Color Monochrome"))
        return filters.applyFilters(image: inputImage)
        
    }
    
    func chainFilters(_ inputImage: UIImage) -> UIImage {
        
        let filters = FiltersX()
        filters.add(filterHolder: filters.getFilterWithHolder("Sepia Tone"))
        filters.add(filterHolder: filters.getFilterWithHolder("Zoom Blur"))
        return filters.applyFilters(image: inputImage)
        
    }
    
    func blendFilters(_ inputImage: UIImage) -> UIImage {
        
        let filters = FiltersX()
        
        filters.add(filterHolder: filters.getFilterWithHolder("Dot Screen"))
        filters.add(filterHolder: filters.getFilterWithHolder("Subtract Blend Mode"))

        return filters.applyFilters(image: inputImage)
        
    }
    
    func generatorFilters(_ inputImage: UIImage) -> UIImage {
        
        let filters = FiltersX()
        
        filters.size=CGSize(width:inputImage.size.width, height:inputImage.size.height)
        filters.add(filterHolder: filters.getFilterWithHolder("Checkerboard Generator"))
        
        return filters.applyFilters(image: inputImage)
        
    }
    
    func filterProperties(_ inputImage: UIImage) -> UIImage {
        
        let filters = FiltersX()
        filters.size=CGSize(width:inputImage.size.width, height:inputImage.size.height)
        
        let fxHolder=filters.getFilterWithHolder("Checkerboard Generator")
        (fxHolder.filter as! CheckerboardGeneratorFX).width = 500
        filters.add(filterHolder: fxHolder)
        
        return filters.applyFilters(image: inputImage)
        
    }
    
    func compositingFilters(_ inputImage: UIImage) -> UIImage {
        
        let filters = FiltersX()
        
        filters.size=CGSize(width:inputImage.size.width, height:inputImage.size.height)
        
        filters.add(filterHolder: filters.getFilterWithHolder("Color Monochrome")) //Node 1
        filters.add(filterHolder: filters.getFilterWithHolder("Checkerboard Generator")) //Node 2
        
        let fxHolder=filters.getFilterWithHolder("Multiply Blend Mode")
        (fxHolder.filter as! MultiplyBlendModeFX).inputImageAlias = "2"
        (fxHolder.filter as! MultiplyBlendModeFX).backgroundImageAlias = "1"
        filters.add(filterHolder: fxHolder)
        
        return filters.applyFilters(image: inputImage)
        
    }
    
    func nodeGraphFilters(_ inputImage: UIImage) -> UIImage {
        
        let filters = FiltersX()
        
        filters.size=CGSize(width:inputImage.size.width, height:inputImage.size.height)
        
        filters.add(filterHolder: filters.getFilterWithHolder("Line Screen")) //Node 1
        filters.add(filterHolder: filters.getFilterWithHolder("Color Monochrome")) //Node 2
        filters.add(filterHolder: filters.getFilterWithHolder("Checkerboard Generator")) //Node 3
        filters.add(filterHolder: filters.getFilterWithHolder("Triangle Tile")) //Node 4

        let fxHolder=filters.getFilterWithHolder("Multiply Blend Mode")
        (fxHolder.filter as! MultiplyBlendModeFX).inputImageAlias = "4"
        (fxHolder.filter as! MultiplyBlendModeFX).backgroundImageAlias = "2"
        filters.add(filterHolder: fxHolder)

        return filters.applyFilters(image: inputImage)
        
    }
    
}
