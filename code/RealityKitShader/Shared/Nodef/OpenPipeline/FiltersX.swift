//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI
//import Combine
import MetalKit

class FiltersX: Codable, ObservableObject, Identifiable, Equatable{
    
    static func == (lhs: FiltersX, rhs: FiltersX) -> Bool {
        return lhs.id==rhs.id
    }
    
    var id = UUID()
    
    @Published var presetName : String = "" //no need to save
    @Published var presetLongName : String = "" //no need to save

    @Published var filterList = [FilterXHolder]()
    @Published var size: CGSize =  CGSize(width:0,height:0)
    @Published var boundsCenter: CIVector =  CIVector(x:0,y:0) //no need to save
    
    @Published var viewerIndex:Int = -1
    @Published var viewerCIFilterX : CIFilter?
    
    
    @Published var photoARView:PhotoARView! = Singleton.photoARView //= PhotoARView(frame: .zero, cameraMode: .nonAR, automaticallyConfigureSession: true)
    
    
    var context:CIContext? = nil
    
    init(_ context: CIContext? = nil) {
        if context==nil
        {

            self.context = CIContext(options: [
                                       CIContextOption.workingColorSpace: NSNull()])
        }
        else
        {
            self.context=context
        }

    }

    func add(filterHolder: FilterXHolder)
    {
        let filterXHolder = filterHolder
        filterXHolder.filter.setupProperties(self)

        filterList.append(filterHolder)
        reassignIndexWithoutId()

    }
    
    func clear()
    {
        filterList = [FilterXHolder]()
        presetName=""
        presetLongName=""
        viewerIndex = -1
    }
    
    enum CodingKeys: String, CodingKey {
        case size
        case boundsCenter
        case filterList
    }
        
    enum FilterTypeKey: CodingKey {
       case type
    }

    enum FilterTypes: String, Decodable {
        
        case colorControls = "CIColorControls"


    }
 
    required init(from decoder: Decoder) throws {
        
        if context==nil
        {
            self.context=CIContext()

        }
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        size = try container.decodeIfPresent(CGSize.self, forKey: .size) ?? CGSize(width:0.0,height:0.0)
        boundsCenter=CIVector(x:size.width/2.0, y:size.height/2.0)

        var filterArrayForType = try container.nestedUnkeyedContainer(forKey: CodingKeys.filterList)
        var newFilterList = [FilterXHolder]()
        var filtersArray = filterArrayForType //JSONUnkeyedDecodingContainer that contains a currentIndex. assignining it this way gives you another object which currentIndex is independent

        while(!filterArrayForType.isAtEnd)
        {
            //isAtEnd and the nestedContainer will loop through
            //Get the shape which is a KeyedDecodingContainer
            let filter = try filterArrayForType.nestedContainer(keyedBy: FilterTypeKey.self) //causes the currentIndex to increase
            let type = try filter.decode(FilterTypes.self, forKey: FilterTypeKey.type)
  
            let filterXHolder = FilterXHolder()
            switch type {
                
            case .colorControls:
                filterXHolder.filter=try filtersArray.decode(ColorControlsFX.self)

            }

            filterXHolder.filter.parent=self
            newFilterList.append(filterXHolder)

        }
        self.filterList = newFilterList
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(size, forKey: .size)

        var filterListWithNoHolder = [FilterX]()
        filterList.forEach
        {
            let currentFilterHolder = $0 as FilterXHolder
            filterListWithNoHolder.append(currentFilterHolder.filter)
        }
        print("count:",filterListWithNoHolder.count)
        try container.encode(filterListWithNoHolder, forKey: .filterList)
        
        //try container.encode(filterList, forKey: .filterList)
    }

    func getFilterWithHolder(_ filterName: String)->FilterXHolder {
        
        var innerFilter: FilterX
        var type = "CI"+filterName.filter { !$0.isWhitespace }

        if type == "CIColorControls"
        {
            innerFilter = ColorControlsFX()
        }
        else if type == "CITerrian"
        {
            innerFilter = TerrianFX(photoARView: self.photoARView)
            (innerFilter as! TerrianFX).startPlaying()
        }

        else{
            innerFilter = ColorControlsFX()

        }
        
        innerFilter.setupProperties(self)

        
        if innerFilter is BaseBlendFX{
            innerFilter.backgroundImageAlias="0"
        }
        
        
        if innerFilter is BaseTransitionFX{
            innerFilter.inputImageAlias=""
            (innerFilter as! BaseTransitionFX).targetImageAlias="0"
        }
        
        let filterXHolder = FilterXHolder()
        filterXHolder.filter=innerFilter
        return filterXHolder

    }

    func handleAlias(inputAlias: String, inputImage: CIImage, beginImage: CIImage)->CIImage
    {
        if inputAlias != ""
        {
            let num = Int(inputAlias)
            if num != nil {
                
                if num == 0{
                    return beginImage
                }
                
                if let filterWithInputAlias = filterList.first(where: {$0.filter.nodeIndex == num}) {
                    //print("handleAlias#")
                    if let cifilterUw = filterWithInputAlias.filter.getCIFilter()
                    {
                        return cifilterUw.outputImage!
                    }
                }
            }
            else {
                if let filterWithInputAlias = filterList.first(where: {$0.filter.alias == inputAlias}) {
                    //print("handleAlias")
                    if let cifilterUw = filterWithInputAlias.filter.getCIFilter()
                    {
                        return cifilterUw.outputImage!
                    }
                }
            }
            
        }
        return inputImage
    }
    
    func setViewer(nodeIndex: Int)
    {
        viewerIndex=nodeIndex
    }
    func resetViewer()
    {
        viewerIndex = -1
    }
    
    func initNodeIndex()
    {
        viewerIndex = -1
        
        var counter=1
        filterList.forEach
        {
            let currentFilter = $0.filter
            currentFilter.nodeIndex=counter
            counter=counter+1
        }
        filterList.forEach
        {
            let currentFilter = $0.filter
            if currentFilter.inputImageAlias != "" && currentFilter.inputImageAlias != "0" {
                
                filterList.forEach
                {
                    let innerFilter = $0.filter
                    if currentFilter.inputImageAlias == String(innerFilter.nodeIndex) {
                        currentFilter.inputImageAliasId = innerFilter.id.uuidString
                    }
                }
            }
            if currentFilter.backgroundImageAlias != "" && currentFilter.backgroundImageAlias != "0" {
                
                filterList.forEach
                {
                    let innerFilter = $0.filter
                    if currentFilter.backgroundImageAlias == String(innerFilter.nodeIndex) {
                        currentFilter.backgroundImageAliasId = innerFilter.id.uuidString
                    }
                }
            }
            
            if currentFilter is BaseTransitionFX {
                let cf = currentFilter as! BaseTransitionFX
                if cf.targetImageAlias != "" && cf.targetImageAlias != "0" {
                    filterList.forEach
                    {
                        let innerFilter = $0.filter
                        if cf.targetImageAlias == String(innerFilter.nodeIndex) {
                            cf.targetImageAliasId = innerFilter.id.uuidString
                        }
                    }
                }
            }
                   
        }
    }
    
    func reassignIndexWithoutId()
    {
        viewerIndex = -1
        
        var counter=1
        filterList.forEach
        {
            let currentFilter = $0.filter
            currentFilter.nodeIndex=counter
            counter=counter+1
        }
    }
    
    func reassignIds()
    {
        filterList.forEach
        {
            let currentFilter = $0.filter
            currentFilter.id = UUID()
        }
    }
    
    func reassignIndex()
    {
        viewerIndex = -1
        
        var counter=1
        filterList.forEach
        {
            let currentFilter = $0.filter
            currentFilter.nodeIndex=counter
            counter=counter+1
        }
        
        filterList.forEach
        {
            let currentFilter = $0.filter
            if currentFilter.inputImageAlias != "" && currentFilter.inputImageAlias != "0" {
                var found=false
                filterList.forEach
                {
                    let innerFilter = $0.filter
                    if currentFilter.inputImageAliasId == innerFilter.id.uuidString {
                        if innerFilter.nodeIndex < currentFilter.nodeIndex {
                            currentFilter.inputImageAlias = String(innerFilter.nodeIndex)
                        }
                        else {
                            currentFilter.inputImageAlias = "#REF!"
                        }
                        found=true
                    }
                }
                if found == false {
                    currentFilter.inputImageAlias = "#REF!"
                }
            }
            
            if currentFilter.backgroundImageAlias != "" && currentFilter.backgroundImageAlias != "0" {
                var found=false
                filterList.forEach
                {
                    let innerFilter = $0.filter
                    if currentFilter.backgroundImageAliasId == innerFilter.id.uuidString {
                        if innerFilter.nodeIndex < currentFilter.nodeIndex {
                            currentFilter.backgroundImageAlias = String(innerFilter.nodeIndex)
                        }
                        else {
                            currentFilter.backgroundImageAlias = "#REF!"
                        }
                        found=true

                    }
                }
                if found == false {
                    currentFilter.backgroundImageAlias = "#REF!"
                }

            }
            
            if currentFilter is BaseTransitionFX {
                let cf = currentFilter as! BaseTransitionFX
                if cf.targetImageAlias != "" && cf.targetImageAlias != "0" {
                    var found=false
                    filterList.forEach
                    {
                        let innerFilter = $0.filter
                        if cf.targetImageAliasId == innerFilter.id.uuidString {
                            if innerFilter.nodeIndex < currentFilter.nodeIndex {
                                cf.targetImageAlias = String(innerFilter.nodeIndex)
                            }
                            else {
                                cf.targetImageAlias = "#REF!"
                            }
                            found=true

                        }
                        
                    }
                    if found == false {
                        cf.targetImageAlias = "#REF!"
                    }
                }
            }
            

  


            

            
         
            

            
           
 
            
            
        }
        
    }

    
    
    
    func reAdjustProperties()
    {
        filterList.forEach
        {
            let filterXHolder = $0
            filterXHolder.filter.adjustPropertiesToBounds(self)
        }
    }
    
    func reSetupProperties()
    {
        filterList.forEach
        {
            let filterXHolder = $0
            filterXHolder.filter.setupProperties(self)
        }
    }
    
    func reassignAllBounds()
    {
        filterList.forEach
        {
            let filterXHolder = $0
            filterXHolder.filter.size=self.size
            filterXHolder.filter.boundsCenter=self.boundsCenter
            
            //setupSizeBoundsAndCenterIfAny(filterXHolder: filterXHolder)
        }
    }
    
    func setPresetName(name: String){
        presetLongName=name
                
        let lowerCase = CharacterSet.lowercaseLetters
        let upperCase = CharacterSet.uppercaseLetters

        //let name = String(name.dropFirst(2))
        var firstTime = true
        var retName = String("")
        var counter=0
        var lastCapIndex=0
        for currentCharacter in name.unicodeScalars {
            
            if upperCase.contains(currentCharacter) {
                if firstTime {
                    retName = String(currentCharacter)
                    firstTime=false
                    lastCapIndex=counter
                }
                else{
                    retName = retName + "" + String(currentCharacter)
                    lastCapIndex=counter
                }
            } else {
                //print("Character code \(currentCharacter) is neither upper- nor lowercase.")
                //print("Character code \(currentCharacter) is neither upper- nor lowercase.")
                //print("Character code \(currentCharacter) is neither upper- nor lowercase.")
            }
            counter=counter+1
        }
        
        lastCapIndex=lastCapIndex+1
  
        presetName=String(retName.prefix(4))

    }
    
    
    
    func applyFilters(image: UIImage) -> UIImage
    {
        //NSLog("FiltersX applyFilters Started*****")

        //print("applying filter",filterList.count)
        let beginImage = CIImage(image: image)
       

        if filterList.count == 0
        {
            return image
        }

        var currentCIFilter : CIFilter = CIFilter()
        var viewerCIFilter : CIFilter = CIFilter()
        var currentImage = beginImage!
        
        //var previousFilterO: FilterX?
        
        filterList.forEach
        {
            let currentFilterHolder = $0
            let currentFilter = currentFilterHolder.filter //$0 as FilterX
            //print("current id",currentFilter.id,currentFilter.type,currentFilter.alias)
            //NSLog("Time")

            if currentFilter is BaseEntityFX {
                                
                //(currentFilter as! SphereFX).setupScene()
                                
                if let currentCIFilterUw = currentFilter.getCIFilter(currentImage: currentImage, beginImage: beginImage!)
                {
                    currentCIFilter = currentCIFilterUw
                    currentImage=currentCIFilter.outputImage!

                    if viewerIndex == -1 || currentFilter.nodeIndex <= viewerIndex{
                        viewerCIFilter=currentCIFilter
                    }
                }
            }
            else {
                if let currentCIFilterUw = currentFilter.getCIFilter(currentImage: currentImage, beginImage: beginImage!)
                {
                    currentCIFilter = currentCIFilterUw
                    currentImage=currentCIFilter.outputImage!

                    if viewerIndex == -1 || currentFilter.nodeIndex <= viewerIndex{
                        viewerCIFilter=currentCIFilter
                    }
                }
            }
       
        }
        
        viewerCIFilterX=viewerCIFilter


        if let cgimg = context!.createCGImage(viewerCIFilter.outputImage!, from: beginImage!.extent) {
      
            let processedImage = UIImage(cgImage: cgimg, scale: image.scale, orientation: image.imageOrientation)
            
            return processedImage
        }


        
        return image
        
            
    }
    
    func applyFiltersX(image: UIImage) -> CIImage
    {

        print("applying filter",filterList.count)
        let beginImage = CIImage(image: image)
       

        if filterList.count == 0
        {
            return beginImage!
        }

        var currentCIFilter : CIFilter = CIFilter()
        var viewerCIFilter : CIFilter = CIFilter()
        var currentImage = beginImage!
        
        filterList.forEach
        {
            let currentFilterHolder = $0
            let currentFilter = currentFilterHolder.filter //$0 as FilterX
            print("current id",currentFilter.id,currentFilter.type,currentFilter.alias)

            if let currentCIFilterUw = currentFilter.getCIFilter(currentImage: currentImage, beginImage: beginImage!)
            {
                currentCIFilter = currentCIFilterUw
                currentImage=currentCIFilter.outputImage!
                print("currentImage",currentImage.extent.size)
                //NSLog("Time")
                if viewerIndex == -1 || currentFilter.nodeIndex <= viewerIndex{
                    viewerCIFilter=currentCIFilter
                }

            }
   
            
        }
   
        return viewerCIFilter.outputImage!
            
    }
    
    func gotShaderEffects() -> Bool
    {
        var gotShader=false
        filterList.forEach
        {
            let currentFilterHolder = $0
            let currentFilter = currentFilterHolder.filter

            for eName in FilterNames.GetShaderType() {
                let tName="CI"+eName.replacingOccurrences(of: " ",with: "")
                if currentFilter.type == tName
                {
                    gotShader=true
                }
            }

        }
        return gotShader
    }

}


