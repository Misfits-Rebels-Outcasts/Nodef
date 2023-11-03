//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class DocumentsViewModel: ObservableObject {

    @Published var files: [String] = []
    @Published var selectedFileName: String = ""

    func setupSelectedProperties()
    {

    }
    
}
