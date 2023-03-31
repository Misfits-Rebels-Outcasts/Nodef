//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI
@available(iOS 15.0, *)

struct ReciprocalPropertiesViewX: View {
    
    @EnvironmentObject var appSettings: AppSettings
    @ObservedObject var fx: ReciprocalFX = ReciprocalFX()
    var parent: FilterPropertiesViewX

    var body: some View {

        Section(header: Text("Options")){
            HStack{
                Text("Numerator 1 (n1)")
                Spacer()
                Text(String(format: "%.2f", fx.n1))
            }
            
            Slider(value: $fx.n1, in: 0.1...5, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.n1) { newValue in
                    applyFilter()
                }
            
            HStack{
                Text("Exponent 1 (exp1)")
                Spacer()
                Text(String(format: "%.2f", fx.exp1))
            }
            
            Slider(value: $fx.exp1, in: 0.1...10, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.exp1) { newValue in
                    applyFilter()
                }
            
            HStack{
                Text("Numerator 2 (n2)")
                Spacer()
                Text(String(format: "%.2f", fx.n2))
            }
            
            Slider(value: $fx.n2, in: 0.1...5, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.n2) { newValue in
                    applyFilter()
                }
            
            HStack{
                Text("Exponent 2 (exp2)")
                Spacer()
                Text(String(format: "%.2f", fx.exp2))
            }
            
            Slider(value: $fx.exp2, in: 0.1...10, onEditingChanged: {editing in
                applyFilter(editing)
            })
                .onChange(of: fx.exp2) { newValue in
                    applyFilter()
                }
            
        }

    }
    
    func applyFilter(_ editing: Bool) {
        print(editing,appSettings.imageRes)
        if editing == true
        {
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

}

