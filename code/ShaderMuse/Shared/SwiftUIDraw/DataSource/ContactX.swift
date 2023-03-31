//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class ContactX: Codable, ObservableObject, Identifiable, Equatable {
    static func == (lhs: ContactX, rhs: ContactX) -> Bool {
        return lhs.id==rhs.id
    }
    
    @Published var givenName: String = ""
    @Published var middleName: String = ""
    @Published var familyName: String = ""
    
    @Published var namePrefix: String = ""
    @Published var nameSuffix: String = ""

    //@Published var previousFamilyName: String = ""
    //@Published var nickname: String = ""
    
    @Published var phoneNumber: String = ""
    @Published var emailAddress: String = ""
    @Published var street: String = ""
    @Published var city: String = ""
    @Published var state: String = ""
    @Published var postalCode: String = ""
    @Published var country: String = ""
    
    @Published var jobTitle: String = ""
    @Published var departmentName: String = ""
    @Published var organizationName: String = ""


    var id = UUID()
    
    init()
    {
        
    }
        
    enum CodingKeys: String, CodingKey {
        case givenName
        case middleName
        case familyName
        case namePrefix
        //case previousFamilyName
        case nameSuffix
        //case nickname
        case phoneNumber
        case emailAddress
        case street
        case city
        case state
        case postalCode
        case country
        case jobTitle
        case departmentName
        case organizationName
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        givenName = try values.decodeIfPresent(String.self, forKey: .givenName) ?? ""
        middleName = try values.decodeIfPresent(String.self, forKey: .middleName) ?? ""
        familyName = try values.decodeIfPresent(String.self, forKey: .familyName) ?? ""
        namePrefix = try values.decodeIfPresent(String.self, forKey: .namePrefix) ?? ""
        //previousFamilyName = try values.decodeIfPresent(String.self, forKey: .previousFamilyName) ?? ""
        nameSuffix = try values.decodeIfPresent(String.self, forKey: .nameSuffix) ?? ""
        //nickname = try values.decodeIfPresent(String.self, forKey: .nickname) ?? ""
        phoneNumber = try values.decodeIfPresent(String.self, forKey: .phoneNumber) ?? ""
        emailAddress = try values.decodeIfPresent(String.self, forKey: .emailAddress) ?? ""
        street = try values.decodeIfPresent(String.self, forKey: .street) ?? ""
        city = try values.decodeIfPresent(String.self, forKey: .city) ?? ""
        state = try values.decodeIfPresent(String.self, forKey: .state) ?? ""
        postalCode = try values.decodeIfPresent(String.self, forKey: .postalCode) ?? ""
        country = try values.decodeIfPresent(String.self, forKey: .country) ?? ""
        jobTitle = try values.decodeIfPresent(String.self, forKey: .jobTitle) ?? ""
        departmentName = try values.decodeIfPresent(String.self, forKey: .departmentName) ?? ""
        organizationName = try values.decodeIfPresent(String.self, forKey: .organizationName) ?? ""
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(givenName, forKey: .givenName)
        try container.encode(middleName, forKey: .middleName)
        try container.encode(familyName, forKey: .familyName)
        try container.encode(namePrefix, forKey: .namePrefix)
        //try container.encode(previousFamilyName, forKey: .previousFamilyName)
        try container.encode(nameSuffix, forKey: .nameSuffix)
        //try container.encode(nickname, forKey: .nickname)
        try container.encode(phoneNumber, forKey: .phoneNumber)
        try container.encode(emailAddress, forKey: .emailAddress)
        try container.encode(street, forKey: .street)
        try container.encode(city, forKey: .city)
        try container.encode(state, forKey: .state)
        try container.encode(postalCode, forKey: .postalCode)
        try container.encode(country, forKey: .country)
        try container.encode(jobTitle, forKey: .jobTitle)
        try container.encode(departmentName, forKey: .departmentName)
        try container.encode(organizationName, forKey: .organizationName)
    }
    
}
