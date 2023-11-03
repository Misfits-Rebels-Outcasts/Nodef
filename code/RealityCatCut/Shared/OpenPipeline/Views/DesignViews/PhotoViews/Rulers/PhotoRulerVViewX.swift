//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI
@available(iOS 15.0, *)
struct PhotoRulerVViewX: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
     @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
   
    @Binding var offsetY: CGFloat
    var rulerHeight: CGFloat
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var pageSettings: PageSettings
    var body: some View {
        Canvas { context, size in
            
            var dpi = 72.0*appSettings.dpiScale
            if appSettings.units == "Centimeters"
            {
                dpi = dpi / 2.54
            }
            
            let heighty = pageSettings.labelHeight*72.0*appSettings.dpiScale*appSettings.zoomFactor
            let thickness = horizontalSizeClass == .regular && verticalSizeClass == .regular ? appSettings.VRulerWidthRegular*72.0 : appSettings.VRulerWidth*72.0
            let spacingy = 0.1*dpi*appSettings.zoomFactor
            //let countx = heighty / spacingy
            let heightSmallTicks = 0.1*72.0
            let spacingyBig = 1.0*dpi*appSettings.zoomFactor
            let countxBig = (offsetY + heighty) / spacingyBig
            let heightBigTicks = 0.2*72.0
            let spacingyMed = 1.0*dpi*appSettings.zoomFactor
            let countxMed = (offsetY + heighty) / spacingyMed
            let heightMedTicks = 0.155*72.0

            var currenty = offsetY + heighty
            let xpath = CGMutablePath()
//            xpath.move(to: CGPoint(x: thickness, y: currenty))
//            xpath.addLine(to: CGPoint(x: thickness-heightSmallTicks , y: currenty))

            var countzero = (offsetY + heighty) / spacingy
            countzero = countzero < 0.0 ? 0.0 : countzero
            
            for _ in 0...Int(countzero)
            {
                if (spacingy > 2.0) //prevent too small space between small ticks in centimeters
                {
                    if currenty > 0.0
                    {
                        xpath.move(to: CGPoint(x: thickness, y: currenty))
                        xpath.addLine(to: CGPoint(x: thickness-heightSmallTicks , y: currenty))
                        currenty -= spacingy
                    }
                }
            }
            
            var countend = (rulerHeight - offsetY + heighty) / spacingy
            countend = countend < 0.0 ? 0.0 : countend
            currenty = offsetY + heighty
            for _ in 0...Int(countend)
            {
                if (spacingy > 2.0) //prevent too small space between small ticks in centimeters
                {
                    if currenty > 0.0
                    {
                        xpath.move(to: CGPoint(x: thickness, y: currenty))
                        xpath.addLine(to: CGPoint(x: thickness-heightSmallTicks , y: currenty))
                        currenty += spacingy
                    }
                }
            }
            
            currenty = offsetY + heighty
            let path = CGMutablePath()
            
            for ty in 0...Int(countxBig)+1
            {
                
                let textPoint = CGPoint(x: thickness-heightBigTicks-8, y: currenty)

                var tyStr=String(ty)
                tyStr = appSettings.units == "Pixels" ? tyStr + "K" : tyStr

                let text = Text(tyStr).font(.system(size: 11))
                context.draw(text, at: textPoint, anchor: .center)
                
                path.move(to: CGPoint(x: thickness, y: currenty))
                path.addLine(to: CGPoint(x: thickness-heightBigTicks , y: currenty))
                currenty -= spacingyBig
            }

            currenty = offsetY + heighty - 0.5*dpi*appSettings.zoomFactor
            for _ in 0...Int(countxMed)
            {
                path.move(to: CGPoint(x: thickness, y: currenty))
                path.addLine(to: CGPoint(x: thickness-heightMedTicks , y: currenty))
                currenty -= spacingyMed
            }
            context.stroke(
                Path(path),
                with: .color(.black),
                lineWidth: 1.0)


            context.stroke(
                Path(xpath),
                with: .color(.black),
                lineWidth: 1.0)


        }.background(colorScheme == .dark ? Color(UIColor.lightGray) : Color.white)
    }
}

