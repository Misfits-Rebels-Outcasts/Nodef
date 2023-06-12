//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI
import Contacts
@available(iOS 15.0, *)
struct CountersViewX: View {
  
    @EnvironmentObject var optionSettings: OptionSettings
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var pageSettings: PageSettings
    @EnvironmentObject var dataSettings: DataSettings
    @EnvironmentObject var shapes: ShapesX
    
    @StateObject var counterPropertiesViewModel: CounterPropertiesViewModel
    @State var counterSamples: String = ""
    
    var body: some View {

        NavigationView {
            Form {
                Section(header: Text("Counters")){
                    
                    Picker("Counter Field", selection: $counterPropertiesViewModel.counterFieldType) {
                        ForEach(counterTypes, id: \.self) {
                            Text($0).font(.custom($0, size: 17.0))
                            
                        }
                    }
                    .onChange(of: counterPropertiesViewModel.counterFieldType) { newValue in
                        counterSamples=""
                        self.dataSettings.countersX.counterList.forEach
                        {
                            print("XX:"+$0.counterFieldType+":"+newValue)
                            if $0.counterFieldType == newValue {
                                //set up properties
                                counterPropertiesViewModel.startValue = String($0.startValue)
                                counterPropertiesViewModel.stepValue = String($0.stepValue)
                                counterPropertiesViewModel.counterLength = String($0.counterLength)

                                counterPropertiesViewModel.prefix = $0.prefix
                                counterPropertiesViewModel.suffix = $0.suffix
                                counterPropertiesViewModel.padding = $0.padding
                                //counterPropertiesViewModel.skipSetPadding = true
                                counterPropertiesViewModel.stepOperation = $0.stepOperation
                                if counterPropertiesViewModel.padding == "No Padding"
                                {
                                    counterPropertiesViewModel.padCharacter=" "
                                }
                                else if counterPropertiesViewModel.padding == "Pad Zeros"
                                {
                                    counterPropertiesViewModel.padCharacter="0"
                                }
                                else if counterPropertiesViewModel.padding == "Pad Spaces"
                                {
                                    counterPropertiesViewModel.padCharacter=" "
                                }
                                else if counterPropertiesViewModel.padding == "Custom Padding"
                                {
                                    counterPropertiesViewModel.padCharacter=$0.padCharacter
                                }
                               
                                counterPropertiesViewModel.rollOverMinimum = String($0.rollOverMinimum)
                                counterPropertiesViewModel.rollOverMaximum = String($0.rollOverMaximum)

                            }
                        }
                    }
                    
                
                    
                }
                Section(header: Text("Properties")){
                    HStack{
                        Text("Start Value")
                        Spacer()
                        TextField("Start Value", text: $counterPropertiesViewModel.startValue)
                            .foregroundColor(Color.gray)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 100)
                            .fixedSize()
                            .onChange(of: counterPropertiesViewModel.startValue) { newValue in
                                self.dataSettings.countersX.counterList.forEach
                                {
                                    if $0.counterFieldType == counterPropertiesViewModel.counterFieldType {
                                        
                                        if newValue == "-"{
                                            $0.startValue=0
                                            return
                                        }
                                        
                                        var trimValue=newValue
                                        if trimValue.count>$0.counterLength{
                                            trimValue.removeLast()
                                        }
                                        
                                        var parseValue = Int(trimValue) ?? 1
                                        
                                        if parseValue < -999999999{
                                            parseValue = 0-999999999
                                        }
                                        
                                        if parseValue > 999999999{
                                            parseValue = 999999999
                                        }

                                        $0.startValue=parseValue
                                        counterPropertiesViewModel.startValue=String(parseValue)
                                    }
                                }
                            }
                    }
                    
                    Picker("Step Operation", selection: $counterPropertiesViewModel.stepOperation) {
                        ForEach(stepOperationTypes, id: \.self) {
                            Text($0).font(.custom($0, size: 17.0))
                        }
                    }
                    .onChange(of: counterPropertiesViewModel.stepOperation) { newValue in
                       
                        self.dataSettings.countersX.counterList.forEach
                        {
                            if $0.counterFieldType == counterPropertiesViewModel.counterFieldType {
                                $0.stepOperation = newValue
                            }
                        }
                    }
                    
                    HStack{
                        Text("Step Value")
                        Spacer()
                        TextField("Step Value", text: $counterPropertiesViewModel.stepValue)
                            .foregroundColor(Color.gray)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 100)
                            .fixedSize()
                            .onChange(of: counterPropertiesViewModel.stepValue) { newValue in
                                self.dataSettings.countersX.counterList.forEach
                                {
                                    if $0.counterFieldType == counterPropertiesViewModel.counterFieldType {
                                        
                                        var trimValue=newValue
                                        if trimValue.count>5{
                                            trimValue.removeLast()
                                        }
                                        
                                        var parseValue = Int(trimValue) ?? 1
                                        
                                        if parseValue > 99999{
                                            parseValue = 99999
                                        }
                                        
                                        if parseValue < 1 {
                                            parseValue = 1
                                        }
                                        
                                        $0.stepValue=parseValue
                                        counterPropertiesViewModel.stepValue=String(parseValue)
                                    }
                                }
                            }
                    }
                    
                    HStack{
                        Text("Roll Over Minimum")
                        Spacer()
                        TextField("Roll Over Minimum", text: $counterPropertiesViewModel.rollOverMinimum)
                            .foregroundColor(Color.gray)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 100)
                            .fixedSize()
                            .onChange(of: counterPropertiesViewModel.rollOverMinimum) { newValue in
                                self.dataSettings.countersX.counterList.forEach
                                {
                                    if $0.counterFieldType == counterPropertiesViewModel.counterFieldType {
                                        
                                        if newValue == "-"{
                                            $0.rollOverMinimum=0
                                            return
                                        }
                                        
                                        var trimValue=newValue
                                        if trimValue.count>$0.counterLength{
                                            trimValue.removeLast()
                                        }
                                        
                                        var parseValue = Int(trimValue) ?? 1
                                        
                                        if parseValue < -999999999{
                                            parseValue = 0-999999999
                                        }
                                        
                                        if parseValue > 999999999{
                                            parseValue = 999999999
                                        }
                                        
                                        $0.rollOverMinimum=parseValue
                                        counterPropertiesViewModel.rollOverMinimum=String(parseValue)
                                    }
                                }
                            }
                    }
                    
                    HStack{
                        Text("Roll Over Maximum")
                        Spacer()
                        TextField("Roll Over Maximum", text: $counterPropertiesViewModel.rollOverMaximum)
                            .foregroundColor(Color.gray)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 100)
                            .fixedSize()
                            .onChange(of: counterPropertiesViewModel.rollOverMaximum) { newValue in
                                self.dataSettings.countersX.counterList.forEach
                                {
                                    if $0.counterFieldType == counterPropertiesViewModel.counterFieldType {
                                        
                                        if newValue == "-"{
                                            $0.rollOverMaximum=0
                                            return
                                        }
                                        
                                        var trimValue=newValue
                                        if trimValue.count>$0.counterLength{
                                            trimValue.removeLast()
                                        }
                                        
                                        var parseValue = Int(trimValue) ?? 1
                                        
                                        if parseValue < -999999999{
                                            parseValue = 0-999999999
                                        }
                                        
                                        if parseValue > 999999999{
                                            parseValue = 999999999
                                        }
                                        
                                        $0.rollOverMaximum=parseValue
                                        counterPropertiesViewModel.rollOverMaximum=String(parseValue)
                                    }
                                }
                            }
                    }
                    
                    HStack{
                        Text("Counter Length")
                        Spacer()
                        TextField("Counter Length", text: $counterPropertiesViewModel.counterLength)
                            .foregroundColor(Color.gray)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 100)
                            .fixedSize()
                            .onChange(of: counterPropertiesViewModel.counterLength) { newValue in
                                self.dataSettings.countersX.counterList.forEach
                                {
                                    if $0.counterFieldType == counterPropertiesViewModel.counterFieldType {
                                        
                                        var parseValue = Int(newValue) ?? 1
                                        
                                        if parseValue > 9{
                                            parseValue = 9
                                        }
                                        
                                        if parseValue < 1 {
                                            parseValue = 1
                                        }
                                                                                
                                        $0.counterLength=parseValue
                                        counterPropertiesViewModel.counterLength=String(parseValue)
                                        $0.resetRollOver()
                                        counterPropertiesViewModel.rollOverMinimum=String($0.rollOverMinimum)
                                        counterPropertiesViewModel.rollOverMaximum=String($0.rollOverMaximum)
                                    }
                                }
                            }
                    }
                    
                    Picker("Padding", selection: $counterPropertiesViewModel.padding) {
                        ForEach(paddingTypes, id: \.self) {
                            Text($0).font(.custom($0, size: 17.0))
                        }
                    }
                    .onChange(of: counterPropertiesViewModel.padding) { newValue in
                       
                        print("Into Padding")
                        /*
                        if counterPropertiesViewModel.skipSetPadding{
                            counterPropertiesViewModel.skipSetPadding=false
                            return
                        }
                         */
                        print("Padding Continue")
                        self.dataSettings.countersX.counterList.forEach
                        {
                            if $0.counterFieldType == counterPropertiesViewModel.counterFieldType {
                                $0.padding = newValue
                                if newValue == "No Padding"
                                {
                                    $0.padCharacter=" "
                                    counterPropertiesViewModel.padCharacter=" "
                                }
                                else if newValue == "Pad Zeros"
                                {
                                    $0.padCharacter="0"
                                    counterPropertiesViewModel.padCharacter="0"
                                }
                                else if newValue == "Pad Spaces"
                                {
                                    $0.padCharacter=" "
                                    counterPropertiesViewModel.padCharacter=" "
                                }
                                else if newValue == "Custom Padding"
                                {
                                    //$0.padCharacter="X"
                                    //counterPropertiesViewModel.padCharacter="X"
                                    counterPropertiesViewModel.padCharacter=$0.padCharacter
                                }

                            }
                        }
                    }
                    
                    HStack{
                        Text("Pad Character")
                        Spacer()
                        TextField("Pad", text: $counterPropertiesViewModel.padCharacter)
                            .foregroundColor(Color.gray)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 100)
                            .fixedSize()
                            .disabled(counterPropertiesViewModel.padding != "Custom Padding" ? true : false)
                            .onChange(of: counterPropertiesViewModel.padCharacter) { newValue in
                                self.dataSettings.countersX.counterList.forEach
                                {
                                    if $0.counterFieldType == counterPropertiesViewModel.counterFieldType {
                                        
                                        var trimValue=newValue
                                        if trimValue.count>1{
                                            trimValue.removeLast()
                                        }
                                        $0.padCharacter=trimValue
                                        counterPropertiesViewModel.padCharacter=trimValue
                                    }
                                }
                            }
                    }
                    
                    HStack{
                        Text("Prefix")
                        Spacer()
                        TextField("Prefix", text: $counterPropertiesViewModel.prefix)
                            .foregroundColor(Color.gray)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 100)
                            .fixedSize()
                            .onChange(of: counterPropertiesViewModel.prefix) { newValue in
                                self.dataSettings.countersX.counterList.forEach
                                {
                                    if $0.counterFieldType == counterPropertiesViewModel.counterFieldType {
                                        
                                        var trimValue=newValue
                                        if trimValue.count>10{
                                            trimValue.removeLast()
                                        }
                                        
                                        $0.prefix=trimValue
                                        counterPropertiesViewModel.prefix=trimValue
                                    }
                                }
                            }
                    }
                    
                    HStack{
                        Text("Suffix")
                        Spacer()
                        TextField("Suffix", text: $counterPropertiesViewModel.suffix)
                            .foregroundColor(Color.gray)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 100)
                            .fixedSize()
                            .onChange(of: counterPropertiesViewModel.suffix) { newValue in
                                self.dataSettings.countersX.counterList.forEach
                                {
                                    if $0.counterFieldType == counterPropertiesViewModel.counterFieldType {
                                        
                                        var trimValue=newValue
                                        if trimValue.count>10{
                                            trimValue.removeLast()
                                        }
                                        
                                        $0.suffix=trimValue
                                        counterPropertiesViewModel.suffix=trimValue
                                    }
                                }
                            }
                    }
                    
                    
                }
                
                Section(header: Text("Samples")){
                    HStack{
                        Text("Action")
                        Spacer()
                        Button("Generate"){
                            counterSamples=""
                            var cx = 0
                            
                            if counterPropertiesViewModel.counterFieldType=="Counter: 01" {
                                cx = 0
                            }
                            else if counterPropertiesViewModel.counterFieldType=="Counter: 02" {
                                cx = 1
                            }
                            else if counterPropertiesViewModel.counterFieldType=="Counter: 03" {
                                cx = 2
                            }
                            else if counterPropertiesViewModel.counterFieldType=="Counter: 04" {
                                cx = 3
                            }
                            else if counterPropertiesViewModel.counterFieldType=="Counter: 05" {
                                cx = 4
                            }
                            
                            dataSettings.countersX.counterList[cx].initCounterValues()
                            dataSettings.countersX.counterList[cx].generateCounterValues(numLabels: 10)
                            for x in 0...9{
                                counterSamples=counterSamples+String(dataSettings.countersX.counterList[cx].getCounterValue(x))+"\n"
                            }

                        }
                    }
                    TextEditor(text: $counterSamples).multilineTextAlignment(TextAlignment.trailing)
                }
                
            }
            .navigationTitle("Counters")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                        Button("Done") {
                            optionSettings.showPropertiesView=0 //set back to 0
                            optionSettings.showPropertiesSheet=false
                            //optionSettings.showContactPicker = false
                        }
                }
                /*
                ToolbarItem(placement: .cancellationAction) {
                        Button("Clear") {

                            dataSettings.clearCountersX()

                        }
                }
                 */
            }
        }

        .onAppear(perform: setupViewModel)
       
    }
    func share()
    {
        
    }

    
    func setupViewModel()
    {
        self.dataSettings.countersX.counterList.forEach
        {
            if $0.counterFieldType == counterPropertiesViewModel.counterFieldType {
                counterPropertiesViewModel.startValue=String($0.startValue)
                counterPropertiesViewModel.stepValue=String($0.stepValue)
                counterPropertiesViewModel.counterLength=String($0.counterLength)
                counterPropertiesViewModel.prefix=$0.prefix
                counterPropertiesViewModel.suffix=$0.suffix
                counterPropertiesViewModel.padding=$0.padding
                counterPropertiesViewModel.stepOperation=$0.stepOperation

                if counterPropertiesViewModel.padding == "No Padding"
                {
                    counterPropertiesViewModel.padCharacter=" "
                }
                else if counterPropertiesViewModel.padding == "Pad Zeros"
                {
                    counterPropertiesViewModel.padCharacter="0"
                }
                else if counterPropertiesViewModel.padding == "Pad Spaces"
                {
                    counterPropertiesViewModel.padCharacter=" "
                }
                else if counterPropertiesViewModel.padding == "Custom Padding"
                {
                    counterPropertiesViewModel.padCharacter=$0.padCharacter
                }

                counterPropertiesViewModel.rollOverMinimum=String($0.rollOverMinimum)
                counterPropertiesViewModel.rollOverMaximum=String($0.rollOverMaximum)

            }
        }
        
    }
}

