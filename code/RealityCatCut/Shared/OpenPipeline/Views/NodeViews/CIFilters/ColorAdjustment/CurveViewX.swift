//
//  Copyright © 2022-2023 James Boo. All rights reserved.
//


import SwiftUI


struct CurveViewX: View {
   
    @Binding var initialPoint0: CGSize
    @Binding var initialPoint1: CGSize
    @Binding var initialPoint2: CGSize
    @Binding var initialPoint3: CGSize
    @Binding var initialPoint4: CGSize
    
    @Binding var offsetPoint0: CGSize
    @Binding var offsetPoint1: CGSize
    @Binding var offsetPoint2: CGSize
    @Binding var offsetPoint3: CGSize
    @Binding var offsetPoint4: CGSize
    
    @Binding public var extFnHasResetOffset0: Bool
    @Binding public var extFnHasResetOffset1: Bool
    @Binding public var extFnHasResetOffset2: Bool
    @Binding public var extFnHasResetOffset3: Bool
    @Binding public var extFnHasResetOffset4: Bool 
    
    var parentView : PhotoCurvePropertiesViewX
   
    var body: some View {
       
        let primaryColor   = Color.blue
        let secondaryColor = primaryColor.opacity(0.7)

        return GeometryReader { reader in
            Color.white
            
            DrawGridLinesView(readersize: reader.size, numRows: 4, numCols: 4)
            
            let curvePoint0 = (initialPoint0 + offsetPoint0) * reader.size
            let curvePoint1 = (initialPoint1 + offsetPoint1) * reader.size
            let curvePoint2 = (initialPoint2 + offsetPoint2) * reader.size
            let curvePoint3 = (initialPoint3 + offsetPoint3) * reader.size
            let curvePoint4 = (initialPoint4 + offsetPoint4) * reader.size
            
            let x0 = curvePoint0.width;
            let y0 = curvePoint0.height
            let x1 = curvePoint1.width;
            let y1 = curvePoint1.height
            let x2 = curvePoint2.width;
            let y2 = curvePoint2.height
            let x3 = curvePoint3.width;
            let y3 = curvePoint3.height
            let x4 = curvePoint4.width;
            let y4 = curvePoint4.height
            
            let points:[SIMD2<Double>] = [[x0,y0],[x1,y1],[x2,y2],[x3,y3],[x4,y4]]

            let spline = CubicSpline(points:points)
            spline.path.stroke(secondaryColor, lineWidth: 2)

            CurveHandleViewX(idnum: 1,readersize : reader.size, parentView: parentView, initialVal:$initialPoint0, offsetVal: $offsetPoint0, extFnHasResetOffsetFlag: $extFnHasResetOffset0)
                .foregroundColor(primaryColor)
               
            CurveHandleViewX(idnum: 2,readersize : reader.size, parentView: parentView,initialVal:$initialPoint1, offsetVal: $offsetPoint1, extFnHasResetOffsetFlag: $extFnHasResetOffset1)
                .foregroundColor(primaryColor)
                          
            CurveHandleViewX(idnum: 3,readersize : reader.size, parentView: parentView,initialVal:$initialPoint2, offsetVal: $offsetPoint2, extFnHasResetOffsetFlag: $extFnHasResetOffset2)
                .foregroundColor(primaryColor)
               
            CurveHandleViewX(idnum: 4,readersize : reader.size, parentView: parentView,initialVal:$initialPoint3, offsetVal: $offsetPoint3, extFnHasResetOffsetFlag: $extFnHasResetOffset3)
                .foregroundColor(primaryColor)
            
            CurveHandleViewX(idnum: 5,readersize : reader.size, parentView: parentView,initialVal:$initialPoint4, offsetVal: $offsetPoint4, extFnHasResetOffsetFlag: $extFnHasResetOffset4)
                .foregroundColor(primaryColor)
                          
            
        }
        .aspectRatio(contentMode: .fit)
        .onAppear {
          
        }
           
       
      
       
    }
    
    //ver 5.1
    struct DrawGridLinesView : View
    {
        var readersize : CGSize
        var numRows : Int
        let numCols : Int
        
        var body: some View {
            
             let primaryColor   = Color.green
             let secondaryColor = primaryColor.opacity(0.5)
    
            let xincr = readersize.width / Double(numRows)
            let yincr = readersize.height / Double(numCols)
       
            ForEach(1..<Int(numRows), id: \.self) {
                 i in
            
                 let currenty =  yincr * CGFloat(i)
                 let cgstart = CGPoint(x: 0.0, y: currenty)
                 let cgend = CGPoint(x: readersize.width, y: currenty)
                 
                 Path { p in
                     p.move(to: cgstart)
                     p.addLine(to: cgend)
                   
                 }.stroke(secondaryColor, lineWidth: 0.5)
             }
             
             ForEach(1..<Int(numCols), id: \.self) {
                 i in
            
                 let currentx =  xincr * CGFloat(i)
                 let cgstart = CGPoint(x: currentx, y: 0)
                 let cgend = CGPoint(x: currentx, y: readersize.height)
                 
                 Path { p in
                     p.move(to: cgstart)
                     p.addLine(to: cgend)
                  
                 }.stroke(secondaryColor, lineWidth: 0.5)
                 
             }
          
        }
    }
    
}

func * (lhs: CGSize, rhs: CGSize) -> CGSize {
    .init(width: lhs.width * rhs.width, height: lhs.height * rhs.height)
}
func + (lhs: CGSize, rhs: CGSize) -> CGSize {
    .init(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
}
func / (lhs: CGSize, rhs: CGSize) -> CGSize {
    .init(width: lhs.width / rhs.width, height: lhs.height / rhs.height)
}
  
