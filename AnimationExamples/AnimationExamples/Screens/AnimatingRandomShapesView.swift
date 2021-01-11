//
//  AnimatingRandomShapesView.swift
//  AnimationExamples
//
//  Created by Luke Smith on 11/01/2021.
//

import SwiftUI

struct AnimatingRandomShapesView: View {
    
    let noBoxes = 5
    let duration: Double = 5.0
    @State var zIndexes : [Double] = [0, 1, 2, 3, 4]
    
    var body: some View {
        
        let delayInterval = duration / Double(noBoxes)
        
        GeometryReader { geometry in
            ZStack {
                ForEach(0 ..< noBoxes) { i in
                    RandomBoxShape(rect: CGRect(x: 0, y: 0, width: geometry.size.width * 2, height: geometry.size.height),
                                   delay: Double(i) * delayInterval, duration: duration, onTimerEnd: {
                                    self.incrementZIndexes()
                                   }).zIndex(zIndexes[i])
                }
                
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
        
        print("zIndexes: \(zIndexes)")
    }
}
