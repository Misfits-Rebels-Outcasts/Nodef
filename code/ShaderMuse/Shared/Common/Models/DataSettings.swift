//
//  Copyright © 2022 James Boo. All rights reserved.
//


import Foundation
import SwiftUI
import Contacts

class DataSettings: ObservableObject, Identifiable, Equatable {
    
    static func == (lhs: DataSettings, rhs: DataSettings) -> Bool {
        return lhs.id==rhs.id
    }
    
    var id = UUID()
    
    @Published var contacts: [CNContact]=[CNContact]()
    @Published var contactCounter: Int = 0
    @Published var contactsX: ContactsX=ContactsX()
    @Published var countersX: CountersX=CountersX()
    //@Published var csvsX: CSVsX=CSVsX()
    @Published var csvx: CSVX=CSVX()
    @Published var restricted: Bool = true
    @Published var csvHeader: CSVRowX=CSVRowX()

    func clearCountersX()
    {
        countersX=CountersX()
        for i in 1...10 {
            let counterX = CounterX("Counter: 0"+String(i))
            countersX.counterList.append(counterX)
        }
    }
    
    func getCounterValue(counterNumber: Int, labelCounter: Int)->String
    {
        //labelCounter starts from 0
        if restricted {
            if labelCounter>=50 {
                return ""
                //return countersX.counterList[counterNumber].getCounterValue(49)
            }
            //if labelCounter>=2 {
            //    return countersX.counterList[counterNumber].getCounterValue(2)
            //}
            else {
                return countersX.counterList[counterNumber].getCounterValue(labelCounter)
            }
        }
        else {
            return countersX.counterList[counterNumber].getCounterValue(labelCounter)
        }
    }
    
    func clearCSVX()
    {
        csvx=CSVX()
        csvHeader=CSVRowX()

        for x in 0...textTypes.count-1 {
            
            if textTypes[x].starts(with: "CSV Column: 01")
            {
                textTypes[x]="CSV Column: 01"
            }
            else if textTypes[x].starts(with: "CSV Column: 02")
            {
                textTypes[x]="CSV Column: 02"
            }
            else if textTypes[x].starts(with: "CSV Column: 03")
            {
                textTypes[x]="CSV Column: 03"
            }
            else if textTypes[x].starts(with: "CSV Column: 04")
            {
                textTypes[x]="CSV Column: 04"
            }
            else if textTypes[x].starts(with: "CSV Column: 05")
            {
                textTypes[x]="CSV Column: 05"
            }
            else if textTypes[x].starts(with: "CSV Column: 06")
            {
                textTypes[x]="CSV Column: 06"
            }
            else if textTypes[x].starts(with: "CSV Column: 07")
            {
                textTypes[x]="CSV Column: 07"
            }
            else if textTypes[x].starts(with: "CSV Column: 08")
            {
                textTypes[x]="CSV Column: 08"
            }
            else if textTypes[x].starts(with: "CSV Column: 09")
            {
                textTypes[x]="CSV Column: 09"
            }
            else if textTypes[x].starts(with: "CSV Column: 10")
            {
                textTypes[x]="CSV Column: 10"
            }

        }
        
        for x in 0...barcodeInputTypes.count-1 {
            
            if barcodeInputTypes[x].starts(with: "CSV Column: 01")
            {
                barcodeInputTypes[x]="CSV Column: 01"
            }
            else if barcodeInputTypes[x].starts(with: "CSV Column: 02")
            {
                barcodeInputTypes[x]="CSV Column: 02"
            }
            else if barcodeInputTypes[x].starts(with: "CSV Column: 03")
            {
                barcodeInputTypes[x]="CSV Column: 03"
            }
            else if barcodeInputTypes[x].starts(with: "CSV Column: 04")
            {
                barcodeInputTypes[x]="CSV Column: 04"
            }
            else if barcodeInputTypes[x].starts(with: "CSV Column: 05")
            {
                barcodeInputTypes[x]="CSV Column: 05"
            }
            else if barcodeInputTypes[x].starts(with: "CSV Column: 06")
            {
                barcodeInputTypes[x]="CSV Column: 06"
            }
            else if barcodeInputTypes[x].starts(with: "CSV Column: 07")
            {
                barcodeInputTypes[x]="CSV Column: 07"
            }
            else if barcodeInputTypes[x].starts(with: "CSV Column: 08")
            {
                barcodeInputTypes[x]="CSV Column: 08"
            }
            else if barcodeInputTypes[x].starts(with: "CSV Column: 09")
            {
                barcodeInputTypes[x]="CSV Column: 09"
            }
            else if barcodeInputTypes[x].starts(with: "CSV Column: 10")
            {
                barcodeInputTypes[x]="CSV Column: 10"
            }

        }
        
    }
    
    func clearContactsX()
    {
        contacts=[CNContact]()
        contactCounter=0
        contactsX=ContactsX()
        
    }
    
    //compilation
    func setupCSVX(url: URL){

    }
    
    func setupContactsX()
    {
        contactsX=ContactsX()
        contacts.forEach { contact in
            let contactX=ContactX()
            contactX.givenName=contact.givenName
            contactX.middleName=contact.middleName
            contactX.familyName=contact.familyName
            contactX.namePrefix=contact.namePrefix
            contactX.nameSuffix=contact.nameSuffix
            
            contactX.phoneNumber=contact.phoneNumbers.count > 0 ? (contact.phoneNumbers[0].value as CNPhoneNumber).stringValue : ""
            contactX.emailAddress=contact.emailAddresses.count > 0 ? contact.emailAddresses[0].value as String : ""
            contactX.street=contact.postalAddresses.count > 0 ? "\(contact.postalAddresses[0].value.street)" : ""
            contactX.city=contact.postalAddresses.count > 0 ? "\(contact.postalAddresses[0].value.city)" : ""
            contactX.state=contact.postalAddresses.count > 0 ? "\(contact.postalAddresses[0].value.state)" : ""
            contactX.postalCode=contact.postalAddresses.count > 0 ? "\(contact.postalAddresses[0].value.postalCode)" : ""
            contactX.country=contact.postalAddresses.count > 0 ? "\(contact.postalAddresses[0].value.country)" : ""
            
            contactX.jobTitle=contact.jobTitle
            contactX.departmentName=contact.departmentName
            contactX.organizationName=contact.organizationName

            contactsX.add(contact: contactX)

        }
    }
    
}
