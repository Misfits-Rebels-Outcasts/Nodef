//
//  Copyright © 2022 James Boo. All rights reserved.
//



import SwiftUI


@available(iOS 15.0, *)

class CurvePoints: ObservableObject{

    @Published var pointX0:CGFloat = 0
    @Published var pointY0:CGFloat = 0

    @Published var pointX1:CGFloat = 0.25
    @Published var pointY1:CGFloat = 0.25
    
    @Published var pointX2:CGFloat = 0.5
    @Published var pointY2:CGFloat = 0.5
    
    @Published var pointX3:CGFloat = 0.75
    @Published var pointY3:CGFloat = 0.75
    
    @Published var pointX4:CGFloat = 1
    @Published var pointY4:CGFloat = 1
    
    @Published public  var cinitialPoint0: CGSize = .init(width: 0.0, height: 1.0)
    @Published public  var cinitialPoint1: CGSize = .init(width: 0.25, height: 0.75)
    @Published public  var cinitialPoint2: CGSize = .init(width: 0.5, height: 0.5)
    @Published public  var cinitialPoint3: CGSize = .init(width: 0.75, height: 0.25)
    @Published public  var cinitialPoint4: CGSize = .init(width: 1.0, height: 0.0)
    
    @Published public var coffsetPoint0: CGSize = .zero
    @Published public var coffsetPoint1: CGSize = .zero
    @Published public var coffsetPoint2: CGSize = .zero
    @Published public var coffsetPoint3: CGSize = .zero
    @Published public var coffsetPoint4: CGSize = .zero
    
    @Published public var extFnHasResetOffset0: Bool = false
    @Published public var extFnHasResetOffset1: Bool = false
    @Published public var extFnHasResetOffset2: Bool = false
    @Published public var extFnHasResetOffset3: Bool = false
    @Published public var extFnHasResetOffset4: Bool = false
    /*
    public finalPointX() ->  {
        
    }
      */
}

struct ToneCurvePropertiesViewX: View, NodeProperties {

    
    var channelModeTypes = ["RGB All","RGB","RGB Red","RGB Green","RGB Blue","HSV"]
    var rgbChannelTypes = ["Red","Green","Blue"]
    var hsvChannelTypes = ["Hue","Saturation","Value"]

    //@State public var selectedRGBChannel: String = "Red"
    
    @ObservedObject var fx: ToneCurveFX = ToneCurveFX()

    var parent: FilterPropertiesViewX?
    var body: some View {
        
        Section(header: Text("Channel"), footer:Text("Changing the Channel Mode will reset the Tone Curve.")){
            
            Picker("Channel Mode", selection: $fx.channelMode) {
                ForEach(channelModeTypes, id: \.self) {
                    Text($0)
                }
            }.pickerStyle(.menu)
            .onChange(of: fx.channelMode) { oldValue, newValue in
                fx.cp=CurvePoints()
                fx.rcp=CurvePoints()
                fx.gcp=CurvePoints()
                fx.bcp=CurvePoints()
                fx.channel="Red"
                if fx.channelMode == "HSV" {
                    fx.channel="Hue"
                }
                fx.ciFilter=nil //remove cache as RGB and Single uses different filters
                applyFilterC()
      
                
            }
            if fx.channelMode == "RGB"{
                Picker("Channel", selection: $fx.channel) {
                    ForEach(rgbChannelTypes, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
            }
            else if fx.channelMode == "HSV"{
                Picker("Channel", selection: $fx.channel) {
                    ForEach(hsvChannelTypes, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
            }
        }
        
        if fx.channelMode == "RGB"{

            if fx.channel=="Red" {
                PhotoCurvePropertiesViewX(fx: fx, cp: fx.rcp,  parent: parent)
                    //.environmentObject(appSettings)
            }
            else if fx.channel=="Green" {
                PhotoCurvePropertiesViewX(fx: fx, cp: fx.gcp,  parent: parent)
                    //.environmentObject(appSettings)
            }
            else if fx.channel=="Blue" {
                PhotoCurvePropertiesViewX(fx: fx, cp: fx.bcp,  parent: parent)
                    //.environmentObject(appSettings)
            }

        }
        else if fx.channelMode == "HSV"{

            if fx.channel=="Hue" {
                PhotoCurvePropertiesViewX(fx: fx, cp: fx.rcp,  parent: parent)
                    //.environmentObject(appSettings)
            }
            else if fx.channel=="Saturation" {
                PhotoCurvePropertiesViewX(fx: fx, cp: fx.gcp,  parent: parent)
                    //.environmentObject(appSettings)
            }
            else if fx.channel=="Value" {
                PhotoCurvePropertiesViewX(fx: fx, cp: fx.bcp,  parent: parent)
                    //.environmentObject(appSettings)
            }

        } else if fx.channelMode == "RGB All"{
                PhotoCurvePropertiesViewX(fx: fx, cp: fx.cp,  parent: parent)
                    //.environmentObject(appSettings)
            } else if fx.channelMode == "RGB Red"{
                PhotoCurvePropertiesViewX(fx: fx, cp: fx.rcp,  parent: parent)
                    //.environmentObject(appSettings)
            }
            else if fx.channelMode == "RGB Green"{
                PhotoCurvePropertiesViewX(fx: fx, cp: fx.gcp,  parent: parent)
                    //.environmentObject(appSettings)
            }
            else if fx.channelMode == "RGB Blue"{
                PhotoCurvePropertiesViewX(fx: fx, cp: fx.bcp,  parent: parent)
                    //.environmentObject(appSettings)
            }
    }

    func applyFilterC() {
        applyFilter()
        //applyFilter(appSettings.mode,appSettings.imageRes,parent)
    }
  
}


