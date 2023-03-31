//
//  Copyright © 2022 James Boo. All rights reserved.
//



import SwiftUI
@available(iOS 15.0, *)
struct BlendPropertiesViewX: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?

    @ObservedObject var fx: ColorDodgeBlendModeFX = ColorDodgeBlendModeFX()
    var parent: FilterPropertiesViewX

    var body: some View {

        Section(header: Text("Image"), footer: Text("Specify an Alias to use the output of a specific filter instead of the previous.")){
            HStack{
                Text("Input Image")
                Spacer()
                TextField("Alias", text: $fx.inputImageAlias)
                    .foregroundColor(Color.gray)
                    .multilineTextAlignment(.trailing)
                    .frame(width: 150)
                    .fixedSize()
                    .onChange(of: fx.inputImageAlias) { newValue in
                        applyFilter()
                    }
                }
            
            HStack{
                Text("Background Image")
                Spacer()
                TextField("Alias", text: $fx.backgroundImageAlias)
                    .foregroundColor(Color.gray)
                    .multilineTextAlignment(.trailing)
                    .frame(width: 150)
                    .fixedSize()
                    .onChange(of: fx.backgroundImageAlias) { newValue in
                        applyFilter()
                    }
                }
            
        }
        .onAppear(perform: setupViewModel)

    }
    func applyFilter() {

        parent.applyFilter()
    }
    func setupViewModel()
    {
        //colorControlsFX.brightness=

    }
}

