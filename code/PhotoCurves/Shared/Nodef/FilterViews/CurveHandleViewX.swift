//
//  Copyright © 2022-2023 James Boo. All rights reserved.
//


import SwiftUI


struct CurveHandleViewX: View {
    
    var idnum : Int = 0
    var readersize : CGSize = CGSize.zero
    var parentView : PhotoCurvePropertiesViewX
    @Binding var initialVal: CGSize
    @Binding var offsetVal: CGSize
    @Binding var extFnHasResetOffsetFlag: Bool
    
    @State var dragOffset: CGSize = .zero
    private let size: CGFloat = 20
    
    var body: some View {
        
       
        let dragGesture = DragGesture()
        .onChanged { (value) in
                        
            //prevents jumping of handle when external function set vertex directly
            if (extFnHasResetOffsetFlag)
            {
                dragOffset = CGSize.zero
                extFnHasResetOffsetFlag = false
            }
            
            self.offsetVal  =  dragOffset + value.translation / readersize
          
            parentView.onCurveHandlerChanged()
        }
        .onEnded { (value) in
            
            //the handle may jump a little after external function is directly applied to the curve / vertices and then moved
            //prob because dragOffset is not reset to zero
            
            //prevents jumping of handle when external function set vertex directly
            if (extFnHasResetOffsetFlag)
            {
                dragOffset = CGSize.zero
                extFnHasResetOffsetFlag = false
            }
            
            self.offsetVal  =  dragOffset + value.translation / readersize
            dragOffset = self.offsetVal
       
            parentView.onCurveHandlerChanged()
            
        }
        
        
        let actualOffset  = (initialVal + offsetVal)*readersize
        
        
        Circle()
            .frame(width: size, height: size)
            .overlay(
                Circle()
                    .stroke(Color.white, lineWidth: 2)
        )
            .offset(x: -size/2+actualOffset.width, y: -size/2+actualOffset.height)
            .gesture(dragGesture)
        
        Text(String(idnum))
            .offset(x: 5+actualOffset.width, y: 5+actualOffset.height)
    }
}


