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
    let boxHeight:CGFloat = 200.0
    @State var zIndexes : [Double] = [0, 1, 2, 3, 4]
    @State var yPositions: [CGFloat] = [0, 0, 0, 0, 0]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0 ..< noBoxes) { i in
                    RandomBoxShape()
                        .frame(width: geometry.size.width, height: boxHeight)
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
        yPositions[boxNo] = screenHeight
        let startDelay = (duration / Double(noBoxes)) * Double(boxNo)
        //delay the start so the boxes are staggered (one shot delay)
        Timer.scheduledTimer(withTimeInterval: startDelay, repeats: false) { _ in
            //main timer so the box repeatedly animates from bottom to top
            Timer.scheduledTimer(withTimeInterval: duration, repeats: true) { _ in
                //move all box z indexes so the box below always overlaps the box above it
                self.incrementZIndexes()
                //move box to below bottom of screen
                yPositions[boxNo] = screenHeight
                withAnimation(Animation.linear(duration: duration)) {
                    //animate box up until its past the top of the screen
                    yPositions[boxNo] = 0 - boxHeight * 1.75
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
