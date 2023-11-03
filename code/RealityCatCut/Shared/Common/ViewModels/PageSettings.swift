//
//  Copyright © 2022 James Boo. All rights reserved.
//


import Foundation
import SwiftUI
import AVFoundation
import Vision
import VideoToolbox
import PhotosUI
import RealityKit
import ARKit

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

    // @Published var backgroundURL: URL?
    @Published var originalBackgroundImage: UIImage?
    @Published var backgroundImage: UIImage?
    @Published var filteredBackgroundImage: UIImage?
    var filteredBackgroundImageForVideo: UIImage?
    //ANCHISES
    //@Published var videoPreviewImage: UIImage?
    //@Published var currentPreviewImage: UIImage?
    
    //@Published var thumbImage = UIImage(named: "PhotoImageSmall")!
    @Published var thumbImage = UIImage(named: "MonaLisa")!
    //@Published var filters:FiltersX = FiltersX()
    @Published var filters:FiltersX = FiltersX()
    @Published var presets: PresetsX = PresetsX(presetType: "Photo Effects")
    //ANCHISES
    @Published var size=CGSize(width:320,height:180)
    
    @Published var readFX:ReadImageFX?
    //ANCHISES
    @Published var readVideoFX:ReadVideoFX?
    @Published var avAsset: AVAsset?
    @Published var avPlayerItem: AVPlayerItem?
    @Published var avPlayer: AVPlayer? = Singleton.getAVPlayerView()
    //@Published var selectedItem: PhotosPickerItem?
    enum LoadState {
        case unknown, loading, loaded(MovieX), failed
    }
    @Published var loadState = LoadState.unknown
         
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
    
    func isBusy()->Bool {
        switch loadState {
        case .unknown:
            return true
        case .loading:
            return true
        case .loaded(let movieX):
            return false
        case .failed:
            return true
        }
    }
    //ANCHISES
    @MainActor
    func initVideo(image: UIImage) {
   

        Task {

            
            var node=filters.add("Read Video")
            await (node as! ReadVideoFX).setupVideoProperties(url: node.assetURL1)

            node=filters.add("Pointillize")
            /*
            node=filters.add("Read Video")
            (node as! ReadVideoFX).assetURL1 = Bundle.main.url(forResource: "two", withExtension: "MOV")!
            await (node as! ReadVideoFX).setupVideoProperties(url: node.assetURL1)

            node=filters.add("Cut Video")
             */
            /*
            node=filters.add("Read Video")
            (node as! ReadVideoFX).assetURL1 = Bundle.main.url(forResource: "two", withExtension: "MOV")!
            await (node as! ReadVideoFX).setupVideoProperties(url: node.assetURL1)
           
            node=filters.add("Join Video")
            node.inputAAlias="1"
            node.inputBAlias="2"
             */
            
            
            await applyFiltersAsync()

            /*
            node=filters.add("Color Controls")
            node=filters.add("Pointillize")
            */

        }

    }
    
    @MainActor
    func initPhoto(image: UIImage) {


        var node=filters.add("Read Image")
        setCanvas(image: (node as! ReadImageFX).inputImage!, dpi:1000)
        
        //node=filters.add("Checkerboard Generator")
        //(node as! CheckerboardGeneratorFX).width=300
        
        //_ = filters.add("Comic Effect")

        Task {
            //_ = filters.add("Mix")
            await applyFiltersAsync()
        }
    }
    
    @MainActor
    func initAR(image: UIImage) {

        let node=filters.add("Read Image")
        setCanvas(image: (node as! ReadImageFX).inputImage!, dpi:1000)

        Task {
            
            _ = filters.add("Color Monochrome")
            _ = filters.add("Sphere Reality")

            await applyFiltersAsync()
        }

      
    }
    
    @MainActor
    init(image: UIImage) {
        
        loadState = .loading
        setCanvas(image: image, dpi:1000)
        let url = urlStep
        let avPlayerItem = AVPlayerItem(asset: AVURLAsset(url: url))
        Singleton.getAVPlayerView().replaceCurrentItem(with: avPlayerItem)
        loadState = .loaded(MovieX(url: url))

        //ANCHISES commented
        //generateLabels()
        
        //initPhoto(image: image)
        //initAR(image: image)
        initVideo(image: image)
        
    }
    
    @MainActor
    func updateVideoImageAsync() async {

        
        var lastNode = filters.getCurrentNode()!
        
        //ANCHISES
        let propertiesNode=filters.getPropertiesNode()
        if propertiesNode != nil {
            lastNode=propertiesNode!
        }
                
        let ciImage = await lastNode.executeImageBackwards()
        var width=lastNode.naturalSize.width
        var height=lastNode.naturalSize.height
        if MovieX.orientationFromTransform(lastNode.preferredTransform).isPortrait {
             width=lastNode.naturalSize.height
             height=lastNode.naturalSize.width
        }
        
        if let cgimg = filters.getContext().createCGImage(ciImage!, from: CGRect(x: 0, y: 0, width: width, height: height)) {
            //DispatchQueue.main.async { [self] in
            filteredBackgroundImage = UIImage(cgImage: cgimg)
                //currentPreviewImage=videoPreviewImage
            //}
            
        }
        
    }
    
    @MainActor
    func updatePhotoImageAsync() async {

        var lastNode = filters.getCurrentNode()!
        
        //ANCHISES
        let propertiesNode=filters.getPropertiesNode()
        if propertiesNode != nil {
            lastNode=propertiesNode!
        }
        
        let ciImage = await lastNode.executeImageBackwards()

        let width=lastNode.size.width
        let height=lastNode.size.height
        /*
        var width=lastNode.naturalSize.width
        var height=lastNode.naturalSize.height
        if MovieX.orientationFromTransform(lastNode.preferredTransform).isPortrait {
             width=lastNode.naturalSize.height
             height=lastNode.naturalSize.width
        }
        */
        if let cgimg = filters.getContext().createCGImage(ciImage!, from: CGRect(x: 0, y: 0, width: width, height: height)) {
            filteredBackgroundImage = UIImage(cgImage: cgimg)
            
        }
        
    }
    
    //ANCHISES
    func updateAVPlayer() {
        let propertiesNode=filters.getPropertiesNode()
        if propertiesNode != nil {
            if propertiesNode!.videoStatus == "Completed" {
                if propertiesNode!.type == "CIReadVideo"  {
                    let avAsset = AVURLAsset(url: propertiesNode!.assetURL1)
                    let avPlayerItem = AVPlayerItem(asset: avAsset)
                    Singleton.getAVPlayerView().replaceCurrentItem(with: avPlayerItem)
                }
                else if propertiesNode!.type == "CICutVideo"  {
                    let avAsset = AVURLAsset(url: propertiesNode!.assetURL2)
                    let avPlayerItem = AVPlayerItem(asset: avAsset)
                    Singleton.getAVPlayerView().replaceCurrentItem(with: avPlayerItem)
                }
                else {
                  
                    let avPlayerItem = AVPlayerItem(asset: propertiesNode!.composition)
                    avPlayerItem.videoComposition = propertiesNode!.videoComposition
                    Singleton.getAVPlayerView().replaceCurrentItem(with: avPlayerItem)
                }
            }
            return
        }
        
        let currentNode=filters.getCurrentNode()!
        
        if currentNode.videoStatus == "Completed" {
            if currentNode.type == "CIReadVideo" ||  currentNode.type == "CICutVideo"  {
                let avAsset = AVURLAsset(url: currentNode.assetURL1)
                let avPlayerItem = AVPlayerItem(asset: avAsset)
                Singleton.getAVPlayerView().replaceCurrentItem(with: avPlayerItem)
            }
            else {
              
                let avPlayerItem = AVPlayerItem(asset: currentNode.composition)
                avPlayerItem.videoComposition = currentNode.videoComposition
                Singleton.getAVPlayerView().replaceCurrentItem(with: avPlayerItem)
            }
        }
                    
    }
    
    @MainActor
    func generateVideo() {
    
        Task {
            loadState = .loading
            //ANCHISES
            //await filters.generateVideoAsync()
            cleanUpVideoFiles()
            filters.removeGeneratedVideos()
            let currentNode = filters.getCurrentNode()!
            await currentNode.executeBackwards()
            updateAVPlayer()
            loadState = .loaded(MovieX(url: currentNode.assetURL1))
        }
    }
    
    func cleanUpVideoFiles() {
        do {
            let documentDirectory = try FileManager.default.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            )
            let directoryContents = try FileManager.default.contentsOfDirectory(
                at: documentDirectory,
                includingPropertiesForKeys: nil
            )
            for url in directoryContents {
                
                var fileUsed=false
                print(url.lastPathComponent)

                for i in 0...filters.filterList.count-1 {
                    let filter = filters.filterList[i].filter
                    
                    //if (url.lastPathComponent == filter.id.uuidString+".mp4")
                    if (url.lastPathComponent == filter.assetURL1.lastPathComponent)
                    {
                        fileUsed=true
                    }
                }

                if fileUsed==false {
                    print("removing",url.lastPathComponent)
                    try FileManager.default.removeItem(at: url)
                }

            }
        }
        catch {
            print(error)
        }
    }
    
    //ANCHISES
    func getPresets(presetType: String)->PresetsXA
    {
        return PresetsXA(presetType: presetType)
    }
    

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
          
                //sometimes pagewidth and pageheight after centimeters etc. the rounding can caused small little
                //e.g pageWidth 4.13 vs 4.1299212 etc. use us envelope 10 to test this out in centimeters
                //multiply the dpi will exercerbate the problem
                
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
            self.originalBackgroundImage = ImageUtil.convertBase64StringToImage(imageBase64String:data!)
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
        if originalBackgroundImage != nil{
            try container.encode(ImageUtil.convertImageToBase64String(img:originalBackgroundImage!), forKey: .backgroundImage)
        }
        /*
        if backgroundImage != nil{
            try container.encode(ImageUtil.convertImageToBase64String(img:backgroundImage!), forKey: .backgroundImage)
         }
         */
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
    
    //ANCHISES
    @MainActor
    func setCanvas(dpi: Double) {
        let image = filteredBackgroundImage!
        let heightInPoints = image.size.height
        let heightInPixels = heightInPoints * image.scale
        let widthInPoints = image.size.width
        let widthInPixels = widthInPoints * image.scale

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
         
        generateLabels()

        //applyFilters()
        
    }
    
    @MainActor
    func setCanvas(image: UIImage, dpi: Double) {
        backgroundImage=image
        filteredBackgroundImage=image
        setCanvas(dpi: dpi)
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
                
        //print("initPage:",labelTemplatesAll.count)

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
         
        //takeoutmiximagesize
        filters.size=CGSize(width:widthInPoints, height:heightInPixels)
        filters.boundsCenter=CIVector(x:filters.size.width/2.0,y:filters.size.height/2.0)
        filters.reassignAllBounds()
        
        
        applyFilters()
        
        generateLabels()
        
    }
    @MainActor
    func applyFiltersAsync() async
    {
        print(filters.currentNodeType())
        if filters.currentNodeType() == "Video" {
                await updateVideoImageAsync()
        }
        else if filters.currentNodeType() == "AR"  {
                await updatePhotoImageAsync()
        }
        else {
                await updatePhotoImageAsync()
        }
        updateAVPlayer()
        self.objectWillChange.send()
        
        //redflag
        setCanvas(dpi:1000)
       
    }
    
    func applyFilters()
    {
        print("applyFilters")
        print(filters.currentNodeType())
        if filters.currentNodeType() == "Video" {
            Task {
                await updateVideoImageAsync()
                updateAVPlayer()
                DispatchQueue.main.async { [self] in
                    self.objectWillChange.send()
                    //redflag
                    self.setCanvas(dpi:1000)

                }
            }
        }
        else if filters.currentNodeType() == "AR"  {
            Task {
                await updatePhotoImageAsync()
                updateAVPlayer()
                DispatchQueue.main.async { [self] in
                    self.objectWillChange.send()
                    //redflag
                    self.setCanvas(dpi:1000)

                }
            }
        }
        else {
            Task {
                await updatePhotoImageAsync()
                updateAVPlayer()
                DispatchQueue.main.async { [self] in
                    self.objectWillChange.send()
                    //redflag
                    self.setCanvas(dpi:1000)

                }
            }
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
        applyFilters()
    }
    
    func getARViewerType()->Bool {


        if filters.filterList.count == 0 {
            return false
        }
        
        if getViewerNodeIndex() == -1 {
            if filters.filterList[filters.filterList.count-1].filter is BaseEntityFX {
                return true
            }
        }
        else
        {
            if filters.filterList[getViewerNodeIndex()-1].filter is BaseEntityFX {
                return true
            }
        }
        return false
    }
    
    func getViewerNodeIndex()->Int
    {
        return filters.viewerIndex
    }
    
    func setViewer(filterXHolder: FilterXHolder)
    {
        /*
        filters.setViewer(nodeIndex: filterXHolder.filter.nodeIndex)
        applyFilters()
        
        //takeoutmiximagesize
        //reset canvas size here
        */
        
        //ANCHISES
        if filterXHolder.filter.nodeIndex == filters.viewerIndex {
            filters.viewerIndex = -1
        }
        else {
            //existing code
            filters.setViewer(nodeIndex: filterXHolder.filter.nodeIndex)
        }
                
        //ANCHISES
        applyFilters()
        /*
        if filterXHolder.filter.parent?.currentNodeType() == "Video" {
            //filters.getCurrentNode()?.updateStatus()
            applyFilters()
            //updateAVPlayer()
        } else {
            //existing code
            
            applyFilters()

        }
          */

    }
}



