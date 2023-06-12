//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class ImageUtil
{
    static func convertImageToBase64String (img: UIImage) -> String {
        return img.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
        //return img.pngData()?.base64EncodedString() ?? ""
    }
    
    static func convertBase64StringToImage (imageBase64String:String) -> UIImage {
        let imageData = Data(base64Encoded: imageBase64String)
        let image = UIImage(data: imageData!)
        return image!
    }
    
    static func sizeForImage(at url: URL) -> CGSize? {

        print("sizeForImage")
        guard let imageSource = CGImageSourceCreateWithURL(url as CFURL, nil)
            , let imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, nil) as? [AnyHashable: Any]
            , let pixelWidth = imageProperties[kCGImagePropertyPixelWidth as String]
            , let pixelHeight = imageProperties[kCGImagePropertyPixelHeight as String]
            //, let orientationNumber = imageProperties[kCGImagePropertyOrientation as String]
            else {
                return nil
        }

        var width: CGFloat = 0, height: CGFloat = 0, orientation: Int = 0
        CFNumberGetValue(pixelWidth as! CFNumber, .cgFloatType, &width)
        CFNumberGetValue(pixelHeight as! CFNumber, .cgFloatType, &height)

        let orientationNumber = imageProperties[kCGImagePropertyOrientation as String]
        print("orientationNumber",orientationNumber)
        if let orN = orientationNumber
        {
            CFNumberGetValue(orientationNumber as! CFNumber, .intType, &orientation)
            if orientation > 4 { let temp = width; width = height; height = temp }
            print("flipping",orientation)
        }

        // Check orientation and flip size if required
        
        return CGSize(width: width, height: height)
    }

    static func downsample(imageAt imageURL: URL,
                    to pointSize: CGSize,
                    scale: CGFloat = UIScreen.main.scale) -> UIImage? {
        // Create an CGImageSource that represent an image
        let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
        guard let imageSource = CGImageSourceCreateWithURL(imageURL as CFURL, imageSourceOptions) else {
            return nil
        }

        let maxDimensionInPixels = max(pointSize.width, pointSize.height) * scale
        
        // Perform downsampling
        let downsampleOptions = [
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceShouldCacheImmediately: true,
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels
        ] as CFDictionary
        guard let downsampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampleOptions) else {
            return nil
        }
        
        // Return the downsampled image as UIImage
        return UIImage(cgImage: downsampledImage)
    }
    
    static func downsample(uiImage : UIImage, scale: CGFloat) -> UIImage? {
        let data = uiImage.pngData()! as NSData
        let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
        guard let imageSource = CGImageSourceCreateWithData(data as CFData, imageSourceOptions) else {
            return nil
        }

        let maxDimensionInPixels = max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) * scale
        
        // Perform downsampling
        let downsampleOptions = [
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceShouldCacheImmediately: true,
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels
        ] as CFDictionary
        guard let downsampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampleOptions) else {
            return nil
        }
        return UIImage(cgImage: downsampledImage)
    }

}
