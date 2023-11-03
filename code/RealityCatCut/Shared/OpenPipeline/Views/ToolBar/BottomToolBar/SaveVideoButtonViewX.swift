//
//  Copyright © 2022 James Boo. All rights reserved.
//


import SwiftUI
import Foundation
import Photos
@available(iOS 15.0, *)

struct SaveVideoButtonViewX: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var pageSettings: PageSettings
    @EnvironmentObject var optionSettings: OptionSettings

    var body: some View {
                
        Button(action: {

            Task {
                do {
                    try await PhotoLibrary.saveVideoToCameraRoll(url: pageSettings.filters.getCurrentNode()!.assetURL1)
                } catch {
                    // Handle error
                }
            
                optionSettings.showingAlertMessage=true
                optionSettings.alertMessage="Video saved successfully."

            }
            
            }, label: {
                /*
                Image(systemName: "square.and.arrow.down")
                    .font(.system(size: 23))
                    .foregroundColor(colorScheme == .dark ? Color(UIColor(red: 0.9569, green: 0.9569, blue: 0.9569, alpha: 0.5) ) : Color.black)
                 */
                Label("Save Video",systemImage: "arrow.down.left.video")

        }).foregroundColor(.black).disabled(!pageSettings.isStopped)

        
    }

}


class PhotoLibrary {

    class func requestAuthorizationIfNeeded() async -> PHAuthorizationStatus {
        let status = PHPhotoLibrary.authorizationStatus(for: .addOnly)

        if status == .notDetermined {
            return await PHPhotoLibrary.requestAuthorization(for: .addOnly)
        } else {
            return status
        }
    }

    enum PhotoLibraryError: Error {
        case insufficientPermissions
        case savingFailed
    }

    class func saveVideoToCameraRoll(url: URL) async throws {

        let authStatus = await requestAuthorizationIfNeeded()

        guard authStatus == .authorized else {
            throw PhotoLibraryError.insufficientPermissions
        }

        do {
            try await PHPhotoLibrary.shared().performChanges {
                PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: url)
            }
        } catch {
            throw PhotoLibraryError.savingFailed
        }
    }
}
