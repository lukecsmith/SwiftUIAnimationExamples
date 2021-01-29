//
//  ErrorView.swift
//  ErrorView
//
//  Created by Luke Smith on 29/10/2020.
//

import SwiftUI

struct ErrorView: View {
    
    var text: LocalizedStringKey
    @Binding var showError: Bool
    let completion: () -> Void
    let animTime = 0.4
    
    var body: some View {
        VStack {
            if showError {
                
                Text(text)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(5.0)
                    .background(Color.red)
                    .cornerRadius(10)
                    .shadow(radius: 24)
                    .transition(.asymmetric(insertion: AnyTransition.opacity.combined(with: AnyTransition.move(edge: .top)),
                                            removal: AnyTransition.opacity.combined(with: AnyTransition.move(edge: .top))))
            }
            Spacer()
        }
    }
    
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(text: "The server appears to be unavailable.  Please try again later", showError: .constant(true)) {
            print("Complete")
        }
    }
}
