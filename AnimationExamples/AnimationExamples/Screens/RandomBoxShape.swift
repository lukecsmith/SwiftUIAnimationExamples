//
//  RandomBoxShape.swift
//  AnimationExamples
//
//  Created by Luke Smith on 11/01/2021.
//

import SwiftUI

struct RandomBoxShape: View {
    
    var points: RandomBoxPointData
    
    var body: some View {
        Path { path in
            path.move(to: points.topLinePoints[0])
            
            for i in 1...points.topLinePoints.count - 1 {
                let point = points.topLinePoints[i]
                let segment = points.topLineControlPoints[i - 1]
                path.addCurve(to: point, control1: segment.controlPoint1, control2: segment.controlPoint2)
            }
            path.addLine(to: points.bottomRight)
            path.addLine(to: points.bottomLeft)
            path.addLine(to: points.topLinePoints[0])
        }
        .fill(LinearGradient(gradient: Gradient(colors: [.red, .blue]),
                              startPoint: .top,
                              endPoint: .bottom))
    }
}

struct BoxWithRandomTopLine_Previews: PreviewProvider {
    
    static let pointData = RandomBoxPointData(rect: CGRect.zero)
    
    static var previews: some View {
        
        RandomBoxShape(points: pointData)
    }
}
