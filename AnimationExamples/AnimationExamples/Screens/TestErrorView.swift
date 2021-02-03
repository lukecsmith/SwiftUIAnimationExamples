//
//  TestErrorView.swift
//  AnimationExamples
//
//  Created by Luke Smith on 29/01/2021.
//

import SwiftUI

struct TestErrorView: View {
    
    @State var errorText = ""
    
    var body: some View {
        ZStack {
            VStack {
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

struct TestErrorView_Previews: PreviewProvider {
    static var previews: some View {
        TestErrorView()
    }
}
