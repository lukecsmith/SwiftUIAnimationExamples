//
//  DraggableBetweenTwoVerticalPositions.swift
//  DraggingTest
//
//  Created by Luke Smith on 13/02/2022.
//

import SwiftUI

extension View {
    func draggableBetweenTwoVerticalPositions(min: CGFloat, max: CGFloat) -> some View {
        self.modifier(DraggableBetweenTwoVerticalPositions(yMin: min, yMax: max))
    }
}

struct DraggableBetweenTwoVerticalPositions: ViewModifier {
    
    var yMin: CGFloat
    var yMax: CGFloat
    
    @State private var yOffset: CGFloat = 0
    @State private var yPosBeforeDrag: CGFloat = 0
    
    func body(content: Content) -> some View {
        content
            // initially set view y position to max (bottom)
            .onAppear {
                withAnimation(Animation.easeOut(duration: 0.3)) {
                    yOffset = yMax
                    yPosBeforeDrag = yMax
                }
            }
            .offset(x: 0, y: yOffset)
            .gesture(DragGesture()
                // when dragging, fix position of view within min and max y
                .onChanged({ value in
                    let change = value.translation.height
                    let newYOffset = yPosBeforeDrag + change
                    if newYOffset < yMax && newYOffset > yMin {
                        yOffset = newYOffset
                    }
                })
                // gesture finished.  if overall drag was downwards,
                // animate view to max pos (bottom), otherwise animate to min (top)
                .onEnded { value in
                    withAnimation(Animation.easeOut(duration: 0.2)) {
                        let directionDown = value.translation.height > 0
                        if directionDown {
                            yOffset = yMax
                        } else {
                            yOffset = yMin
                        }
                        yPosBeforeDrag = yOffset
                    }
                }
            )
    }
}
