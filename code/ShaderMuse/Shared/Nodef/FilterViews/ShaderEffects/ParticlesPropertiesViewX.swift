//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI
@available(iOS 15.0, *)
struct ParticlesPropertiesViewX: View {
    //@Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    //@Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @EnvironmentObject var appSettings: AppSettings
    @ObservedObject var fx: ParticlesFX = ParticlesFX()
    var parent: FilterPropertiesViewX

    var body: some View {

        Section(header: Text("Options")){
            HStack{
                Text("Time Elapsed*")
                Spacer()
                Text(String(format: "%.2f", fx.timeElapsed))
            }
            
            Slider(value: $fx.timeElapsed, in: 0...appSettings.videoDuration, onEditingChanged: {editing in
                if editing == false{
                    fx.regenerate=true
                    timeElapsedX = Double(fx.timeElapsed)
                    applyFilter(editing)
                }
            })
                .onChange(of: fx.timeElapsed) { newValue in
                    //print("id",colorControlsFX.id)
                    //applyFilter()
                    //timeElapsedX = Double(fx.timeElapsed)
                    //fx.regenerate=true
                    //parent.applyFilter()
                    
                }

            HStack{
                Text("Animation Type")
                Spacer()
                Text(String(format: "%.2f", fx.animType))
            }
            
            Slider(value: $fx.animType, in: 0...5, step:1, onEditingChanged: {editing in
                if editing == false{
                    fx.regenerate=true
                    applyFilter(editing)
                }
            })
                .onChange(of: fx.animType) { newValue in
                    //print("id",colorControlsFX.id)
                    //applyFilter()
                    //fx.regenerate=true
                    //parent.applyFilter()
                }
            
            Group {
                HStack{
                    Text("Initial Location X")
                    Spacer()
                    Text(String(format: "%.2f", fx.initlocationx))
                }
                
                Slider(value: $fx.initlocationx, in: 0...1, onEditingChanged: {editing in
                    if editing == false{
                        fx.regenerate=true
                        applyFilter(editing)
                    }
                })
                    .onChange(of: fx.initlocationx) { newValue in
              
                    }
                
                HStack{
                    Text("Initial Location Y")
                    Spacer()
                    Text(String(format: "%.2f", fx.initlocationy))
                }
                
                Slider(value: $fx.initlocationy, in: 0...1, onEditingChanged: {editing in
                    if editing == false{
                        fx.regenerate=true
                        applyFilter(editing)
                    }
                })
                    .onChange(of: fx.initlocationy) { newValue in
              
                    }
                
                HStack{
                    Text("Initial Velocity X")
                    Spacer()
                    Text(String(format: "%.2f", fx.initvelocityx))
                }
                
                Slider(value: $fx.initvelocityx, in: 0...1, onEditingChanged: {editing in
                    if editing == false{
                        fx.regenerate=true
                        applyFilter(editing)
                    }
                })
                    .onChange(of: fx.initvelocityx) { newValue in
              
                    }
                
                HStack{
                    Text("Initial Velocity Y")
                    Spacer()
                    Text(String(format: "%.2f", fx.initvelocityy))
                }
                
                Slider(value: $fx.initvelocityy, in: 0...1, onEditingChanged: {editing in
                    if editing == false{
                        fx.regenerate=true
                        applyFilter(editing)
                    }
                })
                    .onChange(of: fx.initvelocityy) { newValue in
              
                    }
                



            }
            
            Group{
                HStack{
                    Text("Velocity Scale X")
                    Spacer()
                    Text(String(format: "%.2f", fx.vscalingx))
                }
                
                Slider(value: $fx.vscalingx, in: -1...1, onEditingChanged: {editing in
                    if editing == false{
                        fx.regenerate=true
                        applyFilter(editing)
                    }
                })
                    .onChange(of: fx.initlocationy) { newValue in
              
                    }
                
                HStack{
                    Text("Velocity Scale Y")
                    Spacer()
                    Text(String(format: "%.2f", fx.vscalingy))
                }
                
                Slider(value: $fx.vscalingy, in: -1...1, onEditingChanged: {editing in
                    if editing == false{
                        fx.regenerate=true
                        applyFilter(editing)
                    }
                })
                    .onChange(of: fx.initlocationy) { newValue in
              
                    }
            }
            
            Group{
                HStack{
                    Text("Acceleration X")
                    Spacer()
                    Text(String(format: "%.2f", fx.accelerationx))
                }
                
                Slider(value: $fx.accelerationx, in: -1...1, onEditingChanged: {editing in
                    if editing == false{
                        fx.regenerate=true
                        applyFilter(editing)
                    }
                })
                    .onChange(of: fx.accelerationx) { newValue in
              
                    }
                
                HStack{
                    Text("Acceleration Y")
                    Spacer()
                    Text(String(format: "%.2f", fx.accelerationy))
                }
                
                Slider(value: $fx.accelerationy, in: -1...1, onEditingChanged: {editing in
                    if editing == false{
                        fx.regenerate=true
                        applyFilter(editing)
                    }
                })
                    .onChange(of: fx.accelerationy) { newValue in
              
                    }
                
                HStack{
                    Text("Time Scale Forward")
                    Spacer()
                    Text(String(format: "%.2f", fx.timescalingForward))
                }
                
                Slider(value: $fx.timescalingForward, in: 3...6, onEditingChanged: {editing in
                    if editing == false{
                        fx.regenerate=true
                        applyFilter(editing)
                    }
                })
                    .onChange(of: fx.timescalingForward) { newValue in
              
                    }
                
                HStack{
                    Text("Time Scale Return (Match Return)")
                    Spacer()
                    Text(String(format: "%.2f", fx.timescalingRemainder))
                }
                
                Slider(value: $fx.timescalingRemainder, in: 1.5...6, onEditingChanged: {editing in
                    if editing == false{
                        fx.regenerate=true
                        applyFilter(editing)
                    }
                })
                    .onChange(of: fx.timescalingRemainder) { newValue in
              
                    }

            }
            
        }
        .onAppear(perform: setupViewModel)
        //Section(header: Text(""), footer: Text("")){
        //}
    }
    func applyFilter(_ editing: Bool) {
        print(editing,appSettings.imageRes)
        if editing == true
        {
            //if appSettings.imageRes != "High Resolution"
            //{
                //parent.applyFilter()
            //}
        }
        else{
            parent.applyFilter()
        }
    }
    
    func applyFilter() {
        if appSettings.imageRes != "High Resolution"
        {
            parent.applyFilter()
        }
    }
    func setupViewModel()
    {
        //colorControlsFX.brightness=

    }
}

