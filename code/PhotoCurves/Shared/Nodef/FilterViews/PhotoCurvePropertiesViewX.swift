//
//  Copyright © 2022 James Boo. All rights reserved.
//



import SwiftUI


@available(iOS 15.0, *)
struct PhotoCurvePropertiesViewX: View {

    @EnvironmentObject var appSettings: AppSettings

    //@ObservedObject public  var cp: CurvePoints

    //var functionArray = ["Identity", "Sin0To90", "Sin270To360","SinMinus90To90", "Invert","Quadrant","Sigmoid"]
    var curveProfileArray = ["Linear", "Lighten", "Decrease Contrast","Posterize", "Sine Curve 0 to 90", "Sine Curve 270 to 360","Sine Curve -90 to 90", "Negative","Quadrant","Sigmoid","Invert Curve Vertically", "Invert Curve Horizontally", "Invert Vertices","Shift Curve Left", "Shift Curve Right"]
    
    @State public var selectedFunction: String = "Identity"
    @State var mbb_funcNo: Double = 0
    

    @ObservedObject var fx: ToneCurveFX = ToneCurveFX()
    
    @ObservedObject public var cp: CurvePoints = CurvePoints()
    
    var parent: FilterPropertiesViewX?
    @State private var showingAdvancedOptions1 = false
    @State private var showingAdvancedOptions2 = false
    @State private var showingAdvancedOptions3 = false
    @State private var showingAdvancedOptions4 = false
    @State private var showingAdvancedOptions5 = false
    @State private var selectedCurveIndex = 0
    
    var body: some View {
    
        Section(header: Text("Tone Curve - "+(fx.channelMode == "RGB" ? fx.channel : fx.channelMode))){
            VStack(alignment: .center) {
                HStack {
                    Spacer()
                    CurveViewX(
                        initialPoint0: $cp.cinitialPoint0, initialPoint1: $cp.cinitialPoint1, initialPoint2: $cp.cinitialPoint2, initialPoint3: $cp.cinitialPoint3, initialPoint4: $cp.cinitialPoint4, offsetPoint0:  $cp.coffsetPoint0, offsetPoint1:  $cp.coffsetPoint1, offsetPoint2:  $cp.coffsetPoint2, offsetPoint3:  $cp.coffsetPoint3, offsetPoint4:  $cp.coffsetPoint4,
                        extFnHasResetOffset0 : $cp.extFnHasResetOffset0,
                        extFnHasResetOffset1 : $cp.extFnHasResetOffset1,
                        extFnHasResetOffset2 : $cp.extFnHasResetOffset2,
                        extFnHasResetOffset3 : $cp.extFnHasResetOffset3,
                        extFnHasResetOffset4 : $cp.extFnHasResetOffset4,
                        parentView: self)
                    .aspectRatio(contentMode: .fill)
                    .border(Color.green, width: 1.0)
                    .frame(width: 240, height: 240)
                    .padding(40)
                    Spacer()
                }
            }.onAppear(perform: setupViewModel)
            
        }
        
        Section(header: Text("Set Curve")){
            HStack{
                /*
                Picker("", selection: $selectedFunction) {
                    ForEach(curveProfileArray, id: \.self) {
                        Text($0)
                    }
                }
                .labelsHidden()
                .pickerStyle(.menu)
                */
                Picker("", selection: $selectedCurveIndex,
                       content: {
                               ForEach(0..<curveProfileArray.count, content: { index in
                                   Text(curveProfileArray[index])
                               })
                        })
                        .labelsHidden()
                        .pickerStyle(.menu)
                
                Spacer()
                
                Button("Apply")
                {
  
                    if curveProfileArray[selectedCurveIndex]=="Linear"
                    {
                        mapFunctionToIdentity()
                                
                    }
                    else if curveProfileArray[selectedCurveIndex]=="Lighten"
                    {
                        mapFunctionToLighten()
                                
                    }
                    else if curveProfileArray[selectedCurveIndex]=="Decrease Contrast"
                    {
                        mapFunctionToDecreaseContrast()
                                
                    }
                    else if curveProfileArray[selectedCurveIndex]=="Posterize"
                    {
                        mapFunctionToPosterize()
                                
                    }
                    else  if curveProfileArray[selectedCurveIndex]=="Sine Curve 0 to 90"
                    {
                        mapFunctionToInitialsSin90()
                        
                    }
                    else  if curveProfileArray[selectedCurveIndex]=="Sine Curve 270 to 360"
                    {
                        mapFunctionToInitialsSin270To360()
                        
                    }
                    else  if curveProfileArray[selectedCurveIndex]=="Sine Curve -90 to 90"
                    {
                        mapFunctionToInitialsSinMinus90To90()
                        
                    }
                    else  if curveProfileArray[selectedCurveIndex]=="Negative"
                    {
                        mapFunctionToInvert()
                        
                    }
                    else  if curveProfileArray[selectedCurveIndex]=="Quadrant"
                    {
                        mapFunctionToQuadrant()
                        
                    }
                    else  if curveProfileArray[selectedCurveIndex]=="Sigmoid"
                    {
                        mapFunctionToSigmoid()
                        
                    }
                    else if curveProfileArray[selectedCurveIndex] == "Invert Curve Vertically" {
                        curveEditInvertY()
                    }
                    else if curveProfileArray[selectedCurveIndex] == "Invert Curve Horizontally" {
                        curveEditInvertX()
                    }
                    else if curveProfileArray[selectedCurveIndex] == "Invert Vertices" {
                        curveEditInvertVertices()
                    }
                    else if curveProfileArray[selectedCurveIndex] == "Shift Curve Left" {
                        curveEditMoveLeft()
                    }
                    else if curveProfileArray[selectedCurveIndex] == "Shift Curve Right" {
                        curveEditMoveRight()
                    }
                    else
                    {
                        mapFunctionToIdentity()
                    }
                    
                    onCurveHandlerChanged()
                    
                    //applyToCurve()
                    updateToneCurveFromSlider()
                    applyFilter()
                }

            }
            
        }
        

        Section(header: Text("Fine Tune Vertex Position")){
            Toggle("Point 1", isOn: $showingAdvancedOptions1.animation())
            if showingAdvancedOptions1 {
                HStack{
                    Text("X")
                    Spacer()
                    Text(String(format: "%.2f", cp.pointX0))
                }
                            
                Slider(value: $cp.pointX0, in: 0.0...1.0, step: 0.01, onEditingChanged: {editing in
                    if editing {
                        
                    }
                    else {
                        updateToneCurveFromSlider()
                    }
                    applyFilter(editing)
                })

                HStack{
                    Text("Y")
                    Spacer()
                    Text(String(format: "%.2f", cp.pointY0))
                }

                Slider(value: $cp.pointY0, in: 0.0...1.0, step:0.01, onEditingChanged: {editing in
                    if editing {
                        
                    }
                    else {
                        updateToneCurveFromSlider()
                    }
                    applyFilter(editing)

                })

            }
            Toggle("Point 2", isOn: $showingAdvancedOptions2.animation())
            if showingAdvancedOptions2 {
                HStack{
                    Text("X")
                    Spacer()
                    Text(String(format: "%.2f", cp.pointX1))
                }
                            
                Slider(value: $cp.pointX1, in: 0.0...1.0, step:0.01, onEditingChanged: {editing in
                    if editing {
                        
                    }
                    else {
                        updateToneCurveFromSlider()
                    }
                    applyFilter(editing)

                })
      

                HStack{
                    Text("Y")
                    Spacer()
                    Text(String(format: "%.2f", cp.pointY1))
                }

                Slider(value: $cp.pointY1, in: 0.0...1.0, step:0.01, onEditingChanged: {editing in
                    if editing {
                        
                    }
                    else {
                        updateToneCurveFromSlider()
                    }
                    applyFilter(editing)

                })
            }
            Toggle("Point 3", isOn: $showingAdvancedOptions3.animation())
            if showingAdvancedOptions3 {
                HStack{
                    Text("X")
                    Spacer()
                    Text(String(format: "%.2f", cp.pointX2))
                }
                            
                Slider(value: $cp.pointX2, in: 0.0...1.0, step:0.01, onEditingChanged: {editing in
                    if editing {
                        
                    }
                    else {
                        updateToneCurveFromSlider()
                    }
                    applyFilter(editing)

                })
       

                HStack{
                    Text("Y")
                    Spacer()
                    Text(String(format: "%.2f", cp.pointY2))
                }

                Slider(value: $cp.pointY2, in: 0.0...1.0, step:0.01, onEditingChanged: {editing in
                    if editing {
                        
                    }
                    else {
                        updateToneCurveFromSlider()
                    }
                    applyFilter(editing)

                })
            }
            Toggle("Point 4", isOn: $showingAdvancedOptions4.animation())
            if showingAdvancedOptions4 {
                HStack{
                    Text("X")
                    Spacer()
                    Text(String(format: "%.2f", cp.pointX3))
                }
                            
                Slider(value: $cp.pointX3, in: 0.0...1.0, step:0.01, onEditingChanged: {editing in
                    if editing {
                        
                    }
                    else {
                        updateToneCurveFromSlider()
                    }
                    applyFilter(editing)

                })
      

                HStack{
                    Text("Y")
                    Spacer()
                    Text(String(format: "%.2f", cp.pointY3))
                }

                Slider(value: $cp.pointY3, in: 0.0...1.0 , step:0.01, onEditingChanged: {editing in
                    if editing {
                        
                    }
                    else {
                        updateToneCurveFromSlider()
                    }
                    applyFilter(editing)

                })
     


            }
            Toggle("Point 5", isOn: $showingAdvancedOptions5.animation())
            if showingAdvancedOptions5 {
                HStack{
                    Text("X")
                    Spacer()
                    Text(String(format: "%.2f", cp.pointX4))
                }
                            
                Slider(value: $cp.pointX4, in: 0.0...1.0, step:0.01, onEditingChanged: {editing in
                    if editing {
                        
                    }
                    else {
                        updateToneCurveFromSlider()
                    }
                    applyFilter(editing)

                })
      

                HStack{
                    Text("Y")
                    Spacer()
                    Text(String(format: "%.2f", cp.pointY4))
                }

                Slider(value: $cp.pointY4, in: 0.0...1.0 , onEditingChanged: {editing in
                    if editing {
                        
                    }
                    else {
                        updateToneCurveFromSlider()
                    }
                    applyFilter(editing)

                })
     
            }

        }
        

    }

    
    func applyFilter(_ editing: Bool) {
        applyFilter(editing,parent)
    }
    
    func applyFilter() {
        applyFilter(appSettings.mode,appSettings.imageRes,parent)
    }
    
    func setupViewModel()
    {
 
    }
    
    func updateToneCurveFromSlider() {
        
        cp.cinitialPoint0.width=cp.pointX0
        cp.cinitialPoint0.height=1.0-cp.pointY0
        cp.coffsetPoint0  = CGSize.zero
        cp.extFnHasResetOffset0 = true
        //fx.cinitialPoint0=cp.cinitialPoint0
        //fx.coffsetPoint0=cp.coffsetPoint0
        
        cp.cinitialPoint1.width=cp.pointX1
        cp.cinitialPoint1.height=1.0-cp.pointY1
        cp.coffsetPoint1  = CGSize.zero
        cp.extFnHasResetOffset1 = true
        //fx.cinitialPoint1=cp.cinitialPoint1
        //fx.coffsetPoint1=cp.coffsetPoint1

        cp.cinitialPoint2.width=cp.pointX2
        cp.cinitialPoint2.height=1.0-cp.pointY2
        cp.coffsetPoint2  = CGSize.zero
        cp.extFnHasResetOffset2 = true
        //fx.cinitialPoint2=cp.cinitialPoint2
        //fx.coffsetPoint2=cp.coffsetPoint2

        cp.cinitialPoint3.width=cp.pointX3
        cp.cinitialPoint3.height=1.0-cp.pointY3
        cp.coffsetPoint3  = CGSize.zero
        cp.extFnHasResetOffset3 = true
        //fx.cinitialPoint3=cp.cinitialPoint3
        //fx.coffsetPoint3=cp.coffsetPoint3

        cp.cinitialPoint4.width=cp.pointX4
        cp.cinitialPoint4.height=1.0-cp.pointY4
        cp.coffsetPoint4  = CGSize.zero
        cp.extFnHasResetOffset4 = true
        //fx.cinitialPoint4=cp.cinitialPoint4
        //fx.coffsetPoint4=cp.coffsetPoint4

        
       
    }

    func calculateToneCurvePosition() {
        
        if (cp.cinitialPoint0 + cp.coffsetPoint0).width < 0.0 {
            cp.coffsetPoint0.width = 0.0 - cp.cinitialPoint0.width
        }
        if (cp.cinitialPoint0 + cp.coffsetPoint0).width > 1.0 {
            cp.coffsetPoint0.width = 1.0 - cp.cinitialPoint0.width
        }

        if (cp.cinitialPoint0 + cp.coffsetPoint0).height < 0.0 {
            cp.coffsetPoint0.height = 0.0 - cp.cinitialPoint0.height
        }

        if (cp.cinitialPoint0 + cp.coffsetPoint0).height > 1.0 {
            cp.coffsetPoint0.height = 1.0 - cp.cinitialPoint0.height
        }

        if (cp.cinitialPoint1 + cp.coffsetPoint1).width < 0.0 {
            cp.coffsetPoint1.width = 0.0 - cp.cinitialPoint1.width
        }
        if (cp.cinitialPoint1 + cp.coffsetPoint1).width > 1.0 {
            cp.coffsetPoint1.width = 1.0 - cp.cinitialPoint1.width
        }
        if (cp.cinitialPoint1 + cp.coffsetPoint1).height < 0 {
            cp.coffsetPoint1.height = 0.0 - cp.cinitialPoint1.height
        }
        if (cp.cinitialPoint1 + cp.coffsetPoint1).height > 1.0 {
            cp.coffsetPoint1.height = 1.0 - cp.cinitialPoint1.height
        }

        if (cp.cinitialPoint2 + cp.coffsetPoint2).width < 0.0 {
            cp.coffsetPoint2.width = 0.0 - cp.cinitialPoint2.width
        }
        if (cp.cinitialPoint2 + cp.coffsetPoint2).width > 1.0 {
            cp.coffsetPoint2.width = 1.0 - cp.cinitialPoint2.width
        }
        if (cp.cinitialPoint2 + cp.coffsetPoint2).height < 0.0 {
            cp.coffsetPoint2.height = 0.0 - cp.cinitialPoint2.height
        }
        if (cp.cinitialPoint2 + cp.coffsetPoint2).height > 1.0 {
            cp.coffsetPoint2.height = 1.0 - cp.cinitialPoint2.height
        }
      
        if (cp.cinitialPoint3 + cp.coffsetPoint3).width < 0.0 {
            cp.coffsetPoint3.width = 0.0 - cp.cinitialPoint3.width
        }
        if (cp.cinitialPoint3 + cp.coffsetPoint3).width > 1.0 {
            cp.coffsetPoint3.width = 1.0 - cp.cinitialPoint3.width
        }
        if (cp.cinitialPoint3 + cp.coffsetPoint3).height < 0.0 {
            cp.coffsetPoint3.height = 0.0 - cp.cinitialPoint3.height
        }
        if (cp.cinitialPoint3 + cp.coffsetPoint3).height > 1.0 {
            cp.coffsetPoint3.height = 1.0 - cp.cinitialPoint3.height
        }
        
        if (cp.cinitialPoint4 + cp.coffsetPoint4).width < 0.0 {
            cp.coffsetPoint4.width = 0.0 - cp.cinitialPoint4.width
        }
        if (cp.cinitialPoint4 + cp.coffsetPoint4).width > 1.0 {
            cp.coffsetPoint4.width = 1.0 - cp.cinitialPoint4.width
        }
        if (cp.cinitialPoint4 + cp.coffsetPoint4).height < 0.0 {
            cp.coffsetPoint4.height = 0.0 - cp.cinitialPoint4.height
        }
        if (cp.cinitialPoint4 + cp.coffsetPoint4).height > 1.0 {
            cp.coffsetPoint4.height = 1.0 - cp.cinitialPoint4.height
        }
        
        let p0 = cp.cinitialPoint0 + cp.coffsetPoint0
        let cp0 = CGPoint(x: p0.width,y: 1.0-p0.height)
        
        let p1 = cp.cinitialPoint1 + cp.coffsetPoint1
        let cp1 = CGPoint(x: p1.width,y: 1.0-p1.height)
       
        let p2 = cp.cinitialPoint2 + cp.coffsetPoint2
        let cp2 = CGPoint(x: p2.width,y: 1.0-p2.height)
       
        let p3 = cp.cinitialPoint3 + cp.coffsetPoint3
        let cp3 = CGPoint(x: p3.width,y: 1.0-p3.height)
        
        let p4 = cp.cinitialPoint4 + cp.coffsetPoint4
        let cp4 = CGPoint(x: p4.width,y: 1.0-p4.height)
        
        /*
        fx.cinitialPoint0 = cp.cinitialPoint0
        fx.coffsetPoint0 = cp.coffsetPoint0
        fx.cinitialPoint1 = cp.cinitialPoint1
        fx.coffsetPoint1 = cp.coffsetPoint1
        fx.cinitialPoint2 = cp.cinitialPoint2
        fx.coffsetPoint2 = cp.coffsetPoint2
        fx.cinitialPoint3 = cp.cinitialPoint3
        fx.coffsetPoint3 = cp.coffsetPoint3
        fx.cinitialPoint4 = cp.cinitialPoint4
        fx.coffsetPoint4 = cp.coffsetPoint4
        */
        
        cp.pointX0 = cp0.x
        cp.pointY0 = cp0.y

        cp.pointX1 = cp1.x
        cp.pointY1 = cp1.y

        cp.pointX2 = cp2.x
        cp.pointY2 = cp2.y

        cp.pointX3 = cp3.x
        cp.pointY3 = cp3.y

        cp.pointX4 = cp4.x
        cp.pointY4 = cp4.y
    }
    
    func onCurveHandlerChanged() {
        
        calculateToneCurvePosition()
        applyFilter(appSettings.mode,appSettings.imageRes,parent)
        
    }
    
    func setFlagToResetOffset()
    {
        cp.extFnHasResetOffset0 = true
        cp.extFnHasResetOffset1 = true
        cp.extFnHasResetOffset2 = true
        cp.extFnHasResetOffset3 = true
        cp.extFnHasResetOffset4 = true

    }
    
    func mapFunctionToDecreaseContrast()
    {
        
        //need to invert by 1 for y due to SwiftUI : higher y is down
       
        var xval : Double = 0.0
        cp.cinitialPoint0.width = xval;
        cp.cinitialPoint0.height = 1.0-0.0;
        
        xval = 0.19;
        cp.cinitialPoint1.width = xval;
        cp.cinitialPoint1.height = 1.0-0.38
        
        xval = 0.5;
        cp.cinitialPoint2.width = xval;
        cp.cinitialPoint2.height = 1.0-0.58;
        
        xval = 0.81;
        cp.cinitialPoint3.width = xval;
        cp.cinitialPoint3.height = 1.0-0.72;
        
        xval = 1.0;
        cp.cinitialPoint4.width = xval;
        cp.cinitialPoint4.height = 1.0-1.0;
        
        cp.coffsetPoint0  = CGSize.zero
        cp.coffsetPoint1  = CGSize.zero
        cp.coffsetPoint2  = CGSize.zero
        cp.coffsetPoint3  = CGSize.zero
        cp.coffsetPoint4  = CGSize.zero
        
        setFlagToResetOffset()
        
    }
    
    func mapFunctionToPosterize()
    {
        
        //need to invert by 1 for y due to SwiftUI : higher y is down
       
        var xval : Double = 0.48
        cp.cinitialPoint0.width = xval;
        cp.cinitialPoint0.height = 1.0-0.0;
        
        xval = 0.49;
        cp.cinitialPoint1.width = xval;
        cp.cinitialPoint1.height = 1.0-0.25
        
        xval = 0.5;
        cp.cinitialPoint2.width = xval;
        cp.cinitialPoint2.height = 1.0-0.5;
        
        xval = 0.51;
        cp.cinitialPoint3.width = xval;
        cp.cinitialPoint3.height = 1.0-0.75;
        
        xval = 0.52;
        cp.cinitialPoint4.width = xval;
        cp.cinitialPoint4.height = 1.0-1.0;
        
        cp.coffsetPoint0  = CGSize.zero
        cp.coffsetPoint1  = CGSize.zero
        cp.coffsetPoint2  = CGSize.zero
        cp.coffsetPoint3  = CGSize.zero
        cp.coffsetPoint4  = CGSize.zero
        
        setFlagToResetOffset()
        
    }
    
    
    func mapFunctionToLighten()
    {
        
        //need to invert by 1 for y due to SwiftUI : higher y is down
       
        var xval : Double = 0.0
        cp.cinitialPoint0.width = xval;
        cp.cinitialPoint0.height = 1.0-0.5;
        
        xval = 0.25;
        cp.cinitialPoint1.width = xval;
        cp.cinitialPoint1.height = 1.0-0.625
        
        xval = 0.5;
        cp.cinitialPoint2.width = xval;
        cp.cinitialPoint2.height = 1.0-0.75;
        
        xval = 0.75;
        cp.cinitialPoint3.width = xval;
        cp.cinitialPoint3.height = 1.0-0.875;
        
        xval = 1.0;
        cp.cinitialPoint4.width = xval;
        cp.cinitialPoint4.height = 1.0-1.0;
        
        cp.coffsetPoint0  = CGSize.zero
        cp.coffsetPoint1  = CGSize.zero
        cp.coffsetPoint2  = CGSize.zero
        cp.coffsetPoint3  = CGSize.zero
        cp.coffsetPoint4  = CGSize.zero
        
        setFlagToResetOffset()
        
    }
    
     func mapFunctionToIdentity()
     {
         
         //need to invert by 1 for y due to SwiftUI : higher y is down
        
         var xval : Double = 0.0
         cp.cinitialPoint0.width = xval;
         cp.cinitialPoint0.height = 1.0-xval;
         
         xval = 0.25;
         cp.cinitialPoint1.width = xval;
         cp.cinitialPoint1.height = 1.0-xval
         
         xval = 0.5;
         cp.cinitialPoint2.width = xval;
         cp.cinitialPoint2.height = 1.0-xval;
         
         xval = 0.75;
         cp.cinitialPoint3.width = xval;
         cp.cinitialPoint3.height = 1.0-xval;
         
         xval = 1.0;
         cp.cinitialPoint4.width = xval;
         cp.cinitialPoint4.height = 1.0-xval;
         
         cp.coffsetPoint0  = CGSize.zero
         cp.coffsetPoint1  = CGSize.zero
         cp.coffsetPoint2  = CGSize.zero
         cp.coffsetPoint3  = CGSize.zero
         cp.coffsetPoint4  = CGSize.zero
         
         setFlagToResetOffset()
         
     }
    func mapFunctionToInvert()
    {
        
        //need to invert by 1 for y due to SwiftUI : higher y is down
       
        var xval : Double = 0.0
        cp.cinitialPoint0.width = xval;
        cp.cinitialPoint0.height = xval;
        
        xval = 0.25;
        cp.cinitialPoint1.width = xval;
        cp.cinitialPoint1.height = xval
        
        xval = 0.5;
        cp.cinitialPoint2.width = xval;
        cp.cinitialPoint2.height = xval;
        
        xval = 0.75;
        cp.cinitialPoint3.width = xval;
        cp.cinitialPoint3.height = xval;
        
        xval = 1.0;
        cp.cinitialPoint4.width = xval;
        cp.cinitialPoint4.height = xval;
        
        cp.coffsetPoint0  = CGSize.zero
        cp.coffsetPoint1  = CGSize.zero
        cp.coffsetPoint2  = CGSize.zero
        cp.coffsetPoint3  = CGSize.zero
        cp.coffsetPoint4  = CGSize.zero
        
        setFlagToResetOffset()
        
    }
  
    
    
    func mapFunctionToInitialsSin90()
    {
        let PI2 = 3.141592654/2.0  //90 degrees
        
        
        //need to invert by 1 for y due to SwiftUI : higher y is down
       
        var xval : Double = 0.0
        cp.cinitialPoint0.width = xval;
        cp.cinitialPoint0.height = 1.0-sin(xval);
        
        xval = 0.25;
        cp.cinitialPoint1.width = xval;
        cp.cinitialPoint1.height = 1.0-sin(xval*PI2);
        
        xval = 0.5;
        cp.cinitialPoint2.width = xval;
        cp.cinitialPoint2.height = 1.0-sin(xval*PI2);
        
        xval = 0.75;
        cp.cinitialPoint3.width = xval;
        cp.cinitialPoint3.height = 1.0-sin(xval*PI2);
        
        xval = 1.0;
        cp.cinitialPoint4.width = xval;
        cp.cinitialPoint4.height = 1.0-sin(xval*PI2);
        
        cp.coffsetPoint0  = CGSize.zero
        cp.coffsetPoint1  = CGSize.zero
        cp.coffsetPoint2  = CGSize.zero
        cp.coffsetPoint3  = CGSize.zero
        cp.coffsetPoint4  = CGSize.zero
        
        setFlagToResetOffset()
        
    }
    
    
    func mapFunctionToInitialsSin270To360()
    {
        let PI2 = 3.141592654/2.0  //90 degrees
        let PI = 3.141592654 //180
        let PI3 = PI+PI2
        
        
        //need to invert by 1 for y due to SwiftUI : higher y is down
        var xval : Double = 0.0
        cp.cinitialPoint0.width = xval;
        cp.cinitialPoint0.height = 1.0-(sin(xval + PI3)+1.0);
        
       
        xval = 0.25;
        cp.cinitialPoint1.width = xval;
        cp.cinitialPoint1.height = 1.0-(sin(xval*PI2 + PI3)+1.0);
        
        xval = 0.5;
        cp.cinitialPoint2.width = xval;
        cp.cinitialPoint2.height = 1.0-(sin(xval*PI2 + PI3)+1.0);
        
        xval = 0.75;
        cp.cinitialPoint3.width = xval;
        cp.cinitialPoint3.height = 1.0-(sin(xval*PI2 + PI3)+1.0);
        
        xval = 1.0;
        cp.cinitialPoint4.width = xval;
        cp.cinitialPoint4.height = 1.0-(sin(xval*PI2 + PI3)+1.0);
        
        cp.coffsetPoint0  = CGSize.zero
        cp.coffsetPoint1  = CGSize.zero
        cp.coffsetPoint2  = CGSize.zero
        cp.coffsetPoint3  = CGSize.zero
        cp.coffsetPoint4  = CGSize.zero
       
        setFlagToResetOffset()
        
    }
    
    func mapFunctionToInitialsSinMinus90To90()
    {
        let PI2 = 3.141592654/2.0  //90 degrees
        let PI = 3.141592654 //180
        let PI3 = PI2-PI //minus 90
        
        
        //need to invert by 1 for y due to SwiftUI : higher y is down
        var xval : Double = 0.0
        cp.cinitialPoint0.width = xval;
        cp.cinitialPoint0.height = 1.0-((sin(xval + PI3)+1.0))/2.0;
        
       
        xval = 0.3;
        cp.cinitialPoint1.width = xval;
        cp.cinitialPoint1.height = 1.0-((sin(xval*PI + PI3)+1.0))/2.0;
        
        xval = 0.5;
        cp.cinitialPoint2.width = xval;
        cp.cinitialPoint2.height = 1.0-((sin(xval*PI + PI3)+1.0))/2.0;
        
        xval = 0.7;
        cp.cinitialPoint3.width = xval;
        cp.cinitialPoint3.height = 1.0-((sin(xval*PI + PI3)+1.0))/2.0;
        
        xval = 1.0;
        cp.cinitialPoint4.width = xval;
        cp.cinitialPoint4.height = 1.0-((sin(xval*PI + PI3)+1.0))/2.0;
        
        cp.coffsetPoint0  = CGSize.zero
        cp.coffsetPoint1  = CGSize.zero
        cp.coffsetPoint2  = CGSize.zero
        cp.coffsetPoint3  = CGSize.zero
        cp.coffsetPoint4  = CGSize.zero
       
        setFlagToResetOffset()
        
    }
   
     
    func mapFunctionToQuadrant()
    {
        let PI2 = 3.141592654/2.0  //90 degrees
        let PI = 3.141592654 //180
        let PI3 = PI+PI2
       
        
        
        //need to invert by 1 for y due to SwiftUI : higher y is down
       
        var xval : Double = 0.0
        cp.cinitialPoint0.width = sin(xval*PI2+PI3)
        cp.cinitialPoint0.height = cos(xval*PI2+PI3)
        cp.cinitialPoint0.width = 1.0 + cp.cinitialPoint0.width
        cp.cinitialPoint0.height = 1.0 - cp.cinitialPoint0.height
        
        xval = 0.25;
        cp.cinitialPoint1.width = sin(xval*PI2+PI3)
        cp.cinitialPoint1.height = cos(xval*PI2+PI3)
        cp.cinitialPoint1.width = 1.0 + cp.cinitialPoint1.width
        cp.cinitialPoint1.height = 1.0 - cp.cinitialPoint1.height
        
        xval = 0.5;
        cp.cinitialPoint2.width = sin(xval*PI2+PI3)
        cp.cinitialPoint2.height = cos(xval*PI2+PI3)
        cp.cinitialPoint2.width = 1.0 + cp.cinitialPoint2.width
        cp.cinitialPoint2.height = 1.0 - cp.cinitialPoint2.height
        
        xval = 0.75;
        cp.cinitialPoint3.width = sin(xval*PI2+PI3)
        cp.cinitialPoint3.height = cos(xval*PI2+PI3)
        cp.cinitialPoint3.width = 1.0 + cp.cinitialPoint3.width
        cp.cinitialPoint3.height = 1.0 - cp.cinitialPoint3.height
        
        xval = 1.0;
        cp.cinitialPoint4.width = sin(xval*PI2+PI3)
        cp.cinitialPoint4.height = cos(xval*PI2+PI3)
        cp.cinitialPoint4.width = 1.0 + cp.cinitialPoint4.width
        cp.cinitialPoint4.height = 1.0 - cp.cinitialPoint4.height
        
        cp.coffsetPoint0  = CGSize.zero
        cp.coffsetPoint1  = CGSize.zero
        cp.coffsetPoint2  = CGSize.zero
        cp.coffsetPoint3  = CGSize.zero
        cp.coffsetPoint4  = CGSize.zero
        
        setFlagToResetOffset()
        
    }
    
    
    func smoothstepFn(x: Double, e0 : Double, e1 : Double) -> Double
    {
       var t : Double = 0
       t = (x - e0) / (e1 - e0)
       if (t<=e0)
       {
           t=0.1
       }
       else if (t>=e1)
       {
           t=0.9
       }
     
       return t * t * (3.0 - 2.0 * t);
    }
    
    
    func mapFunctionToSigmoid()
    {
        
        //need to invert by 1 for y due to SwiftUI : higher y is down
        var xval : Double = 0.0
        var yval : Double = 0.0
        let edge0 = 0.3
        let edge1 = 0.7
        
        xval = 0.0;
        cp.cinitialPoint0.width = xval;
        yval = smoothstepFn(x: xval, e0: edge0, e1: edge1)
        cp.cinitialPoint0.height = 1.0-(yval)
        
        xval = 0.33;
        cp.cinitialPoint1.width = xval;
        yval = smoothstepFn(x: xval, e0: edge0, e1: edge1)
        cp.cinitialPoint1.height = 1.0-(yval)
        
        xval = 0.5;
        cp.cinitialPoint2.width = xval;
        yval = smoothstepFn(x: xval, e0: edge0, e1: edge1)
        cp.cinitialPoint2.height = 1.0-(yval)
        
        xval = 0.67;
        cp.cinitialPoint3.width = xval;
        yval = smoothstepFn(x: xval, e0: edge0, e1: edge1)
        cp.cinitialPoint3.height = 1.0-(yval)
        
        
        xval = 1.0;
        cp.cinitialPoint4.width = xval;
        yval = smoothstepFn(x: xval, e0: edge0, e1: edge1)
        cp.cinitialPoint4.height = 1.0-(yval)
        
        
        cp.coffsetPoint0  = CGSize.zero
        cp.coffsetPoint1  = CGSize.zero
        cp.coffsetPoint2  = CGSize.zero
        cp.coffsetPoint3  = CGSize.zero
        cp.coffsetPoint4  = CGSize.zero
       
        setFlagToResetOffset()
        
    }
    
    func applyToCurve()
    {
        let sel = Int(mbb_funcNo)
        
        if (sel==0)
        {
            mapFunctionToIdentity()
                    
        }
        else  if (sel==1)
        {
            mapFunctionToInitialsSin90()
            
        }
        else  if (sel==2)
        {
            mapFunctionToInitialsSin270To360()
            
        }
        else  if (sel==3)
        {
            mapFunctionToInitialsSinMinus90To90()
            
        }
        else  if (sel==4)
        {
            mapFunctionToInvert()
            
        }
        else  if (sel==5)
        {
            mapFunctionToQuadrant()
            
        }
        else  if (sel==6)
        {
            mapFunctionToSigmoid()
            
        }
        else
        {
            mapFunctionToIdentity()
        }
        
        onCurveHandlerChanged()
        
    }
    
     func curveEditInvertY()
     {
        
         cp.cinitialPoint0.height = 1.0 - cp.cinitialPoint0.height
         cp.cinitialPoint1.height = 1.0 - cp.cinitialPoint1.height
         cp.cinitialPoint2.height = 1.0 - cp.cinitialPoint2.height
         cp.cinitialPoint3.height = 1.0 - cp.cinitialPoint3.height
         cp.cinitialPoint4.height = 1.0 - cp.cinitialPoint4.height
         
         cp.coffsetPoint0.height =  -cp.coffsetPoint0.height
         cp.coffsetPoint1.height =  -cp.coffsetPoint1.height
         cp.coffsetPoint2.height =  -cp.coffsetPoint2.height
         cp.coffsetPoint3.height =  -cp.coffsetPoint3.height
         cp.coffsetPoint4.height =  -cp.coffsetPoint4.height
         
         setFlagToResetOffset()
        
         onCurveHandlerChanged()
     }
     
     func curveEditInvertX()
     {
        
         cp.cinitialPoint0.width = 1.0 - cp.cinitialPoint0.width
         cp.cinitialPoint1.width = 1.0 - cp.cinitialPoint1.width
         cp.cinitialPoint2.width = 1.0 - cp.cinitialPoint2.width
         cp.cinitialPoint3.width = 1.0 - cp.cinitialPoint3.width
         cp.cinitialPoint4.width = 1.0 - cp.cinitialPoint4.width
         
         cp.coffsetPoint0.width =  -cp.coffsetPoint0.width
         cp.coffsetPoint1.width =  -cp.coffsetPoint1.width
         cp.coffsetPoint2.width =  -cp.coffsetPoint2.width
         cp.coffsetPoint3.width =  -cp.coffsetPoint3.width
         cp.coffsetPoint4.width =  -cp.coffsetPoint4.width
         
         setFlagToResetOffset()
        
         onCurveHandlerChanged()
     }
     
     
     //may change shape of curve....
     func curveEditInvertVertices()
     {
         let temp0i = cp.cinitialPoint0;
         let temp1i = cp.cinitialPoint1;
         let temp2i = cp.cinitialPoint2;
         let temp3i = cp.cinitialPoint3;
         let temp4i = cp.cinitialPoint4;
        
         cp.cinitialPoint0 = temp4i;
         cp.cinitialPoint1 = temp3i;
         cp.cinitialPoint2 = temp2i;
         cp.cinitialPoint3 = temp1i;
         cp.cinitialPoint4 = temp0i;
         
         let temp0o = cp.coffsetPoint0;
         let temp1o = cp.coffsetPoint1;
         let temp2o = cp.coffsetPoint2;
         let temp3o = cp.coffsetPoint3;
         let temp4o = cp.coffsetPoint4;
         
         cp.coffsetPoint0 = temp4o;
         cp.coffsetPoint1 = temp3o;
         cp.coffsetPoint2 = temp2o;
         cp.coffsetPoint3 = temp1o;
         cp.coffsetPoint4 = temp0o;
         
         setFlagToResetOffset()
        
         onCurveHandlerChanged()
     }
     
     //handles become jumpy after move
     func curveEditMoveLeft()
     {
         let moveAmt = 0.1
        
         cp.cinitialPoint0.width = cp.cinitialPoint0.width - moveAmt
         cp.cinitialPoint1.width = cp.cinitialPoint1.width - moveAmt
         cp.cinitialPoint2.width = cp.cinitialPoint2.width - moveAmt
         cp.cinitialPoint3.width = cp.cinitialPoint3.width - moveAmt
         cp.cinitialPoint4.width = cp.cinitialPoint4.width - moveAmt
         
         setFlagToResetOffset()
        
         onCurveHandlerChanged()
     }
   
     //handles become jumpy after move
     func curveEditMoveRight()
     {
         let moveAmt = 0.1
        
         
         cp.cinitialPoint0.width = cp.cinitialPoint0.width + moveAmt
         cp.cinitialPoint1.width = cp.cinitialPoint1.width + moveAmt
         cp.cinitialPoint2.width = cp.cinitialPoint2.width + moveAmt
         cp.cinitialPoint3.width = cp.cinitialPoint3.width + moveAmt
         cp.cinitialPoint4.width = cp.cinitialPoint4.width + moveAmt
         
         
         setFlagToResetOffset()
        
         onCurveHandlerChanged()
     }

}

