//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

@main
@available(iOS 15.0, *)
struct NodefApp: App {
    var body: some Scene {
        WindowGroup {

            PhotoMainViewX()
                .environmentObject(PageSettings(image: UIImage(named: "PhotoImage")!))
        }
    }
}
