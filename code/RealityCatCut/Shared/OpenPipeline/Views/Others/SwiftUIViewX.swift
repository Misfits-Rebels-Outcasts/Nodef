//
//  SwiftUIView.swift
//  Pipeline
//
//  Created by Chin Pin Boo on 24/5/23.
//

import SwiftUI

struct SwiftUIViewX: View {
/*https://developer.apple.com/forums/thread/707673
    struct Donut: View {
        var body: some View {
            VStack {
                Button("Tap me", action: {
                    debugPrint("button tapped")
                })
                .offset(y: 30)
                .foregroundColor(.white)
                
                
                Circle()
                    .frame(width: 200, height: 200)
                    .foregroundColor(.yellow)
                    .padding(.top, 72)
                    .padding(.bottom, 200)
            }
        }
    }

    struct NavBar: View {
        var body: some View {
            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: 30)
                .background(.white)
        }
    }

    struct Feed: View {
        var body: some View {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(0...14) { _ in
                        Text("Feed view")
                    }
                }
                
            }
            .padding(.top, 20)
        }
    }
    var body: some View {
        ZStack(alignment: .top) {
            NavBar()
            Donut()
        }
        .sheet(isPresented: .constant(true)) {
            Feed()
                .interactiveDismissDisabled(true)
                .presentationDetents([.fraction(0.4), .large])
                .presentationDragIndicator(.visible) // will always be true when you have 2 detents
                //.presentationBackgroundInteraction(.enabled(upThrough: .medium)) //&#x2F;&#x2F; &lt;- this is the magic property
        }
        .background(.green)
    }
*/
    
    @State var presentSheet = false
    
    var body: some View {
        NavigationView {
            Button("Modal") {
                presentSheet = true
            }
            .navigationTitle("Main")
        }.sheet(isPresented: $presentSheet) {
            Text("Detail")
                .presentationDetents([.medium, .large])

        }
    }
     
}
