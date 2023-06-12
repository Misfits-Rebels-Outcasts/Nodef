//
//  Copyright © 2022 James Boo. All rights reserved.
//


import Foundation
import SwiftUI
//import Contacts

class OptionSettings: ObservableObject, Identifiable, Equatable {
    
    static func == (lhs: OptionSettings, rhs: OptionSettings) -> Bool {
        return lhs.id==rhs.id
    }
    
    var id = UUID()
    
    @Published var action: String = ""
    @Published var showPropertiesView: Int = 0
    @Published var showPagePropertiesView: Int = 0
    @Published var showPropertiesSheet: Bool = false
    @Published var previewBorderWidth: Double = 4.0
    @Published var showAlert = false //display aleart for entering label name the textfield alert
    
    @Published var skipScrollingX: Bool = false
    @Published var skipScrollingY: Bool = false

    //@Published var showSaveAlert = false
    //@Published var showLabelSave = true
    //@Published var alertInput = ""
    //@Published var imagePickingFirstTime = true
    //@Published var category: String = ""
    //@Published var vendor: String = ""
    @Published var labelName: String = ""
    
    @Published var jsonLabelStringForSave: String = ""
    
    @Published var isExporting: Bool = false
    @Published var isImporting: Bool = false
    
    //@Published var showingAlertSave = false
    @Published var showingAlertMessage = false
    
    @Published var existingLabelExist = false
    @Published var enteredSaveFileName: String? // this is updated as the user types in the text field
    @Published var alertMessage: String? //"Label saved successfully." in AlertWrapper
    @Published var subscribeMessage: String = "Subscribe to support more than 3 Nodes."
    
    //@Published var highPerformancePrinting: Bool = false
    @Published var actualPrinting: Bool = false
    @Published var showContactPicker = false
    @Published var showCSVPicker = false


    //@Published var addingNodesPromptSubscription = false

    //@Published var contacts: [CNContact]=[CNContact]()
    /*
    init(_ action: String) {
        self.action=action
    }
     */
    
    //For Photo Select image
    @Published var useCamera: Bool = false
    @Published var square: Bool = false
    
    
    @Published var selectedItem: String? = "Add"
    
    @Published var pagePropertiesHeight: CGFloat = 95
}
