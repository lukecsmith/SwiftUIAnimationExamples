//
//  RandomBoxShape.swift
//  AnimationExamples
//
//  Created by Luke Smith on 11/01/2021.
//

import SwiftUI

struct RandomBoxShape: View {
    
    @State var points = RandomBoxPointData(rect: CGRect.zero)
    var gradientColors: [Color]
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
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
                .fill(LinearGradient(gradient: Gradient(colors: gradientColors),
                                      startPoint: .top,
                                      endPoint: .bottom))
                .onAppear {
                    let rect = CGRect(x: 0, y: 0, width: geometry.size.width * 2, height: geometry.size.height)
                    self.updatePoints(rect: rect)
                }
            }
        }
    }
    
    func updatePoints(rect: CGRect) {
        self.points = RandomBoxPointData(rect: rect)
    }
}

struct BoxWithRandomTopLine_Previews: PreviewProvider {
    
    static let pointData = RandomBoxPointData(rect: CGRect.zero)
    
    static var previews: some View {
        
        RandomBoxShape(gradientColors: [.red, .blue])
    }
}
