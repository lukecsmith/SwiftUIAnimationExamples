//
//  RandomBoxShape.swift
//  AnimationExamples
//
//  Created by Luke Smith on 11/01/2021.
//

import SwiftUI

struct RandomBoxShape: View {
    
    @State var points = RandomBoxPointData(rect: CGRect.zero)
    @State var position: CGFloat = 200
    var rect: CGRect
    let delay: Double
    let duration: Double
    let onTimerEnd: (Int) -> Void
    let shapeNo: Int
    
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
        .position(x: 0, y: position)
        .onAppear {
            position = -300
            self.updatePoints(rect: rect)
            Timer.scheduledTimer(withTimeInterval: self.delay, repeats: false) { _ in
                timerAction()
                Timer.scheduledTimer(withTimeInterval: self.duration, repeats: true) { _ in
                    timerAction()
                }
            }
        }
    }
    
    func timerAction() {
        self.onTimerEnd(shapeNo)
        position = rect.size.height * 1.3
        withAnimation(Animation.linear(duration: self.duration)) {
            position = -300
        }
    }
    
    func updatePoints(rect: CGRect) {
        self.points = RandomBoxPointData(rect: rect)
    }
}

struct BoxWithRandomTopLine_Previews: PreviewProvider {
    
    static let pointData = RandomBoxPointData(rect: CGRect.zero)
    
    static var previews: some View {
        
        RandomBoxShape(rect: CGRect.zero, delay: 0, duration: 5.0, onTimerEnd: {_ in }, shapeNo: 0)
    }
}
