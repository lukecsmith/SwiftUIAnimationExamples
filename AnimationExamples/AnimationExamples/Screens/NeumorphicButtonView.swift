//
//  NeumorphicButtonView.swift
//  AnimationExamples
//
//  Created by Luke Smith on 11/07/2022.
//

import SwiftUI

struct NeumorphicView: View {
    var bgColor: Color
    @State private var isPressed: Bool = false
    
    var body: some View {
        VStack {
            Button("Hello, Neumorphism!", action: {
                self.isPressed.toggle()
            }).padding(20)
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .shadow(color: .white, radius: self.isPressed ? 7: 10, x: self.isPressed ? -5: -10, y: self.isPressed ? -5: -10)
                            .shadow(color: .black, radius: self.isPressed ? 7: 10, x: self.isPressed ? 5: 10, y: self.isPressed ? 5: 10)
                            .blendMode(.overlay)
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(bgColor)
                    }
            )
                .scaleEffect(self.isPressed ? 0.98: 1)
                .foregroundColor(.gray)
                .animation(.spring())
        }
    }
}
