//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

@available(macOS 12.0, *)
@available(iOS 15.0, *)
struct PhotoRulerHViewX: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
     @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    
    @Binding var offsetX: CGFloat
    var rulerWidth: CGFloat
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var pageSettings: PageSettings
    var body: some View {
        Canvas { context, size in
            /*
            let kxpath = CGMutablePath()
            let kheightSmallTicks = 0.1*72.0
            let kthickness = horizontalSizeClass == .regular && verticalSizeClass == .regular ? appSettings.HRulerWidthRegular*72.0 : appSettings.HRulerWidth*72.0
            let kbottomy = kthickness
            var kcurrentx = 0.0
            kcurrentx = offsetX + kthickness
       
            kxpath.move(to: CGPoint(x: kcurrentx, y: kbottomy))
            kxpath.addLine(to: CGPoint(x: kcurrentx, y: kbottomy-kheightSmallTicks))
            print("LLL",pageSettings.labelWidth)
            
            kcurrentx=kcurrentx+1000/1024.0*72.0*appSettings.dpiScale*appSettings.zoomFactor
            kxpath.move(to: CGPoint(x: kcurrentx, y: kbottomy))
            kxpath.addLine(to: CGPoint(x: kcurrentx, y: kbottomy-kheightSmallTicks))

            kcurrentx=kcurrentx+pageSettings.labelWidth*72.0*appSettings.dpiScale*appSettings.zoomFactor
            kxpath.move(to: CGPoint(x: kcurrentx, y: kbottomy))
            kxpath.addLine(to: CGPoint(x: kcurrentx, y: kbottomy-kheightSmallTicks))

            context.stroke(
                Path(kxpath),
                with: .color(.blue),
                lineWidth: 1.0)
            */
                          
            var dpi = 72.0*appSettings.dpiScale
            
            if appSettings.units == "Centimeters"
            {
                dpi = dpi / 2.54
            }
            
            //let widthx = 2.625*72.0*appSettings.dpiScale*appSettings.zoomFactor
            let widthx = pageSettings.labelWidth*72.0*appSettings.dpiScale*appSettings.zoomFactor
        
            //let thickness = 0.37*72.0
            let thickness = horizontalSizeClass == .regular && verticalSizeClass == .regular ? appSettings.HRulerWidthRegular*72.0 : appSettings.HRulerWidth*72.0
              
            let spacingx = 0.1*dpi*appSettings.zoomFactor
            let countx = widthx / spacingx
            let bottomy = thickness
            let heightSmallTicks = 0.1*72.0
            
            let spacingxBig = 1.0*dpi*appSettings.zoomFactor
            let countxBig = widthx / spacingxBig
            let bottomyBig = thickness
            let heightSmallTicksBig = 0.2*72.0
                             
            let spacingxMed = 1.0*dpi*appSettings.zoomFactor
            let countxMed = widthx / spacingxMed
            let bottomyMed = thickness
            let heightSmallTicksMed = 0.15*72.0
         
            
            
            var currentx = 0.0
            
            var countzero = (offsetX + thickness) / spacingx
            //var darkColor: UIColor = UIColor.black
            let path = CGMutablePath()
            let xpath = CGMutablePath()
            currentx = offsetX + thickness
            countzero = countzero < 0.0 ? 0.0 : countzero
            for _ in 0...Int(countzero)
            {
                if (spacingx > 2.0) //prevent too small space between small ticks in centimeters
                {
                if currentx > 0.0
                {
                    xpath.move(to: CGPoint(x: currentx, y: bottomy))
                    xpath.addLine(to: CGPoint(x: currentx, y: bottomy-heightSmallTicks))
                    currentx -= spacingx
                }
                }
            }
            
            let storecurrentx = currentx
  
            currentx = offsetX + thickness

            for _ in 0...Int(countx)
            {
                if (spacingx > 2.0) //prevent too small space between small ticks in centimeters
                {
                path.move(to: CGPoint(x: currentx, y: bottomy))
                path.addLine(to: CGPoint(x: currentx, y: bottomy-heightSmallTicks))
                currentx += spacingx
                }
            }
            
            currentx = offsetX + thickness + 0.0*dpi*appSettings.zoomFactor
            
            
            for tx in 0...Int(countxBig)+1
            {
                
                let textPoint = CGPoint(x: currentx, y: bottomyBig-heightSmallTicksBig-3)
                
                var txStr=String(tx)
                txStr = appSettings.units == "Pixels" ? txStr + "K" : txStr
                
                let text = Text(txStr).font(.system(size: 11))
                
                context.draw(text, at: textPoint, anchor: .center)

                path.move(to: CGPoint(x: currentx, y: bottomyBig))
                path.addLine(to: CGPoint(x: currentx, y: bottomyBig-heightSmallTicksBig+3))
                currentx += spacingxBig
            }
                                
            currentx = offsetX + thickness + 0.5*dpi*appSettings.zoomFactor
            for _ in 0...Int(countxMed)
            {
                path.move(to: CGPoint(x: currentx, y: bottomyMed))
                path.addLine(to: CGPoint(x: currentx, y: bottomyBig-heightSmallTicksMed))
                currentx += spacingxMed
            }
            
            context.stroke(
                Path(path),
                with: .color(.black),
                lineWidth: 1)
         
            currentx = storecurrentx
            var countend = (rulerWidth - currentx) / spacingx
            countend = countend < 0.0 ? 0.0 : countend
            
            for _ in 0...Int(countend)
            {
                if (spacingx > 2.0) //prevent too small space between small ticks in centimeters
                {

                xpath.move(to: CGPoint(x: currentx, y: bottomy))
                xpath.addLine(to: CGPoint(x: currentx, y: bottomy-heightSmallTicks))
                currentx += spacingx
                }
            }
            context.stroke(
                Path(xpath),
                with: .color(.black),
                lineWidth: 1.0)
            
        }.background(colorScheme == .dark ? Color(UIColor.lightGray) : Color.white)
    }
}
