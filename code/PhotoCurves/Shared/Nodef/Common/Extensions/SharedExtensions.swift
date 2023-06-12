//
//  Copyright © 2023 James Boo. All rights reserved.
//
import SwiftUI
import CoreImage

extension String {
    func sizeNoConstraint(font: UIFont) -> CGSize {
    let attrString = NSAttributedString(string: self, attributes: [NSAttributedString.Key.font: font])
        let bounds = attrString.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin , context: nil)
        let size = CGSize(width: bounds.width, height: bounds.height)
        return size
    }
}
