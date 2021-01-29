//
//  TransitioningErrorView.swift
//  AnimationExamples
//
//  Created by Luke Smith on 29/01/2021.
//

import SwiftUI

struct TransitioningErrorView: View {
    
    @State var showError = false
    
    var body: some View {
        ZStack {
            Button("Show Error") {
                withAnimation {
                    self.showError.toggle()
                }
            }
            ErrorView(text: "The server appears to be unavailable.  Please try again later", showError: $showError) {
             print("Complete")
            }
        }
    }
}

struct TransitioningErrorView_Previews: PreviewProvider {
    static var previews: some View {
        TransitioningErrorView()
    }
}
