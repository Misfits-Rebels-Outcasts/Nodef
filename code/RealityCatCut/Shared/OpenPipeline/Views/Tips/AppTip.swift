//
//  Copyright © 2022-2023 James Boo. All rights reserved.
//

import TipKit

struct GenerateVideoTip: Tip {
    var title: Text {
        Text("Generate Video")
    }
    
    var message: Text? {
        Text("Add (") + Text(Image(systemName: "plus")).foregroundColor(.blue) + Text(") one or more filter steps and generate the video when you are ready.")
    }
    
    //var image: Image? {
    //    Image(systemName: "plus")
    //}
}
