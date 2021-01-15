//
//  AnimatingCurvedBoxesView.swift
//  AnimationExamples
//
//  Created by Luke Smith on 11/01/2021.
//

import SwiftUI

struct AnimatingCurvedBoxesView: View {
    
    let noBoxes = 5
    let duration: Double = 20.0
    @State var zIndexes : [Double] = [0, 1, 2, 3, 4]
    
    var body: some View {
        
        let delayInterval = duration / Double(noBoxes)
        
        ZStack {
            ForEach(0 ..< noBoxes) { i in
                
                AnimationContainerView(delay: Double(i) * delayInterval,
                               duration: duration,
                               onTimerEnd: { shapeNo in
                                self.incrementZIndexes()
                               },
                               shapeNo: i).zIndex(zIndexes[i])
            }
        }
    }
    
    func incrementZIndexes() {
        
        for i in 0...zIndexes.count - 1 {
            zIndexes[i] = zIndexes[i] - 1
            if zIndexes[i] < 0 {
                zIndexes[i] = 4
            }
        }
    }
}
