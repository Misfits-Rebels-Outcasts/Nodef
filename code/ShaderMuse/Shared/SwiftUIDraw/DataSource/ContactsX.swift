//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI

class ContactsX: Codable, ObservableObject{
    @Published var contactList = [ContactX]()

    init() {
        
    }
    
    func add(contact: ContactX)
    {
        contactList.append(contact)
    }
    
    enum CodingKeys: String, CodingKey {
      case contactList
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        var contactsArrayForType = try container.nestedUnkeyedContainer(forKey: CodingKeys.contactList)
        var newContactList = [ContactX]()

        while(!contactsArrayForType.isAtEnd)
        {
            newContactList.append(try contactsArrayForType.decode(ContactX.self))
        }
        self.contactList = newContactList
    }

    func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
      try container.encode(contactList, forKey: .contactList)
    }
}
