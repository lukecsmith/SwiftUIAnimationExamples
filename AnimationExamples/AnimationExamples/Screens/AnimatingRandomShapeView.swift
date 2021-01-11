//
//  AnimatingRandomShapeView.swift
//  AnimationExamples
//
//  Created by Luke Smith on 11/01/2021.
//

import SwiftUI

struct AnimatingRandomShapeView: View {
    
    let duration: Double
    let noBoxes: Int
    
    @State var position: CGFloat = 200
    @State var shapeData = RandomBoxPointData(rect: CGRect.zero)
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0 ..< noBoxes) { i in
                    RandomBoxShape(points: shapeData)
                        .position(x: 0, y: position)
                }
                
            } .onAppear {
                position = geometry.size.height
                shapeData = RandomBoxPointData(rect: CGRect(x: 0, y: 0, width: geometry.size.width * 2, height: geometry.size.height))
                withAnimation(Animation.easeInOut(duration: 5.0)) {
                    position = -100
                }
            }
        }
        
    }
}
