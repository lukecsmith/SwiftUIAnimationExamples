//
//  AnimatingRandomShapesView.swift
//  AnimationExamples
//
//  Created by Luke Smith on 11/01/2021.
//

import SwiftUI

struct AnimatingRandomShapesView: View {
    
    let noBoxes = 10
    let duration: Double = 5.0
    
    
    var body: some View {
        
        let delayInterval = duration / Double(noBoxes)
        
        GeometryReader { geometry in
            ZStack {
                ForEach(0 ..< noBoxes) { i in
                    RandomBoxShape(rect: CGRect(x: 0, y: 0, width: geometry.size.width * 2, height: geometry.size.height),
                                   delay: Double(i) * delayInterval, duration: duration)
                }
                
            }
        }
        
    }
}
