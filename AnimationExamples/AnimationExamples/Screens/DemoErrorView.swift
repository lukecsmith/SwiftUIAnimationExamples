//
//  DemoErrorView.swift
//  AnimationExamples
//
//  Created by Luke Smith on 29/01/2021.
//

import SwiftUI

struct DemoErrorView: View {
    
    @State var errorText = ""
    
    var body: some View {
        ZStack {
            VStack(spacing: 20.0) {
                Button("Error 1") {
                    self.errorText = "First Error"
                }
                Button("Error 2") {
                    self.errorText = "Second Error"
                }
                Button("Error 3") {
                    self.errorText = "Third Error"
                }
            }
            .errorView(text: $errorText)
        }
    }
}

struct DemoErrorView_Previews: PreviewProvider {
    static var previews: some View {
        DemoErrorView()
    }
}
