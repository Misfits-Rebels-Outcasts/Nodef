//
//  Copyright © 2022 James Boo. All rights reserved.
//


import Foundation
import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins
import UniformTypeIdentifiers

class PageSettings: Codable, ObservableObject, Identifiable, Equatable {
    
    static func == (lhs: PageSettings, rhs: PageSettings) -> Bool {
        return lhs.id==rhs.id
    }
    
    var id = UUID()

    @Published var backgroundImage: UIImage?
    @Published var filters:FiltersX = FiltersX()

    init() {
        
        let filePath = Bundle.main.url(forResource: "Mona_Lisa_by_Leonardo_da_Vinci", withExtension: "jpeg")!

        if let data = try? Data(contentsOf: filePath) {
            backgroundImage = UIImage(data: data)
            var filterXHolder=filters.getFilterWithHolder("Terrian")
            filters.add(filterHolder: filterXHolder)
            
             //filterXHolder=filters.getFilterWithHolder("Waves")
            //filters.add(filterHolder: filterXHolder)
            filters.initNodeIndex()
            _=filters.applyFilters(image: backgroundImage!)
         
        }
         
      

    }

    init(image: UIImage) {

    }
    required init(from decoder: Decoder) throws {


    }

    func encode(to encoder: Encoder) throws {

    }


}



