//
//  ErrorView.swift
//  ErrorView
//
//  Created by Luke Smith on 29/10/2020.
//

import SwiftUI

/**
 ViewModifier that allows us to apply this errorview to any view using .errorView(text:..)
 */
extension View {
    func errorView(text: Binding<String>) -> some View {
        self.modifier(ErrorViewModifier(text: text))
    }
}

struct ErrorViewModifier: ViewModifier {
    
    @Binding var text: String
    func body(content: Content) -> some View {
        ZStack {
            content
            ErrorView(text: $text)
        }
    }
}

/**
 The error text is passed in via the @Binding text property.  when passed in, the .onChange closure is fired below, which sets the visibleErrorText property with the incoming text, in turn making the red text box appear and show the text.  At this time a timer starts, which will clear the visible text and the passed in text property too so that the red box disappears.
 */
struct ErrorView: View {
    
    @Binding var text: String
    @State var visibleErrorText: String = ""
    let padding: CGFloat = 5.0
    @State var timer: Timer?
    
    var body: some View {
        VStack {
            if visibleErrorText.count > 0 {
                HStack(alignment: .center) {
                    Spacer()
                    Text(visibleErrorText)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                        .padding(15)
                    Spacer()
                }
                .background(Color.red)
                .cornerRadius(10)
                .shadow(radius: 24)
                .padding(.vertical, 5)
                .padding(.horizontal, 24)
                //this transition dictates how the box appears and disappears.  The animation is described in .onChange below
                .transition(.asymmetric(insertion: AnyTransition.opacity
                                                .combined(with: AnyTransition.move(edge: .top)),
                                            removal: AnyTransition.opacity
                                                .combined(with: AnyTransition.move(edge: .top))))
            }
            Spacer()
        }.onChange(of: text) { newValue in
            withAnimation {
                self.visibleErrorText = newValue
                self.timer?.invalidate()
                self.timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { _ in
                    withAnimation {
                        self.visibleErrorText = ""
                        self.text = ""
                    }
                }
            }
            
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(text: .constant("Test Error Text"))
    }
}
