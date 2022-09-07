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
    //@Published var count: Int = 0
    
    //@Published var contactsX: ContactsX=ContactsX()
    
    func clearContactsX()
    {
        /*
        contacts=[CNContact]()
        contactCounter=0
        //count=0
        contactsX=ContactsX()
         */
    }
    
    func setupContactsX()
    {
        /*
        contactsX=ContactsX()
        //count=0
        contacts.forEach { contact in
            let contactX=ContactX()
            contactX.givenName=contact.givenName
            contactX.middleName=contact.middleName
            contactX.familyName=contact.familyName
            contactX.namePrefix=contact.namePrefix
            //contactX.previousFamilyName=contact.previousFamilyName
            contactX.nameSuffix=contact.nameSuffix
            //contactX.nickname=contact.nickname
            
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
            //count=count+1
        }
         */
    }
    
}
