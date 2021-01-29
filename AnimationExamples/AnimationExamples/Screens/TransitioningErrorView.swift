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
                if self.showError == false {
                    self.triggerErrorAnim(completion: { print("complete")})
                }
            }
            ErrorView(text: "The server appears to be unavailable.  Please try again later", showError: $showError)
        }
    }
    
    func triggerErrorAnim(completion: @escaping () -> Void) {
        withAnimation {
            self.showError = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                withAnimation {
                    self.showError = false
                    completion()
                }
            }
        }
    }
}

struct TransitioningErrorView_Previews: PreviewProvider {
    static var previews: some View {
        TransitioningErrorView()
    }
}
