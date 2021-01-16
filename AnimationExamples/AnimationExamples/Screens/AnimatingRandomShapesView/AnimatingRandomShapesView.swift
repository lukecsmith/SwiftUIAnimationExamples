//
//  AnimatingRandomShapesView.swift
//  AnimationExamples
//
//  Created by Luke Smith on 11/01/2021.
//

import SwiftUI

struct AnimatingRandomShapesView: View {
    
    let noBoxes = 5
    let duration: Double = 10.0
    @State var zIndexes : [Double] = [0, 1, 2, 3, 4]
    @State var yPositions: [CGFloat] = [0, 0, 0, 0, 0]
    
    var body: some View {
        
        
        GeometryReader { geometry in
            
            ZStack {
                ForEach(0 ..< noBoxes) { i in
                    RandomBoxShape()
                        .frame(width: geometry.size.width, height: 200)
                        .position(x: 0, y: yPositions[i])
                        .zIndex(zIndexes[i])
                        .onAppear {
                            self.createAnimations(boxNo: i, screenHeight: geometry.size.height)
                        }
                }
            }
        }
    }
    
    func createAnimations(boxNo: Int, screenHeight: CGFloat) {
        let startDelay = (duration / Double(noBoxes)) * Double(boxNo)
        Timer.scheduledTimer(withTimeInterval: startDelay, repeats: false) { _ in
            Timer.scheduledTimer(withTimeInterval: duration, repeats: true) { _ in
                self.incrementZIndexes()
                yPositions[boxNo] = screenHeight
                withAnimation(Animation.linear(duration: duration)) {
                    yPositions[boxNo] = 0
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
    }
}
