//
//  AnimatableGraph.swift
//  AnimationExamples
//
//  Created by Luke Smith on 23/09/2021.
//

import Foundation
import SwiftUI

struct AnimatableGraph: Shape {
    
    var controlPoints: AnimatableVector
    var closedArea: Bool
    var curved: Bool
    
    var animatableData: AnimatableVector {
        set { self.controlPoints = newValue }
        get { return self.controlPoints }
    }
    
    func point(index: Int, rect: CGRect) -> CGPoint {
        let value = self.controlPoints.values[index]
        let x = Double(index)/Double(self.controlPoints.values.count)*Double(rect.width)
        let y = Double(rect.height)*value
        return CGPoint(x: x, y: y)
    }
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            
            var point1 = self.point(index: 0, rect: rect)
            path.move(to: point1)
            
            var i = 1
            if curved {
                
                while i < self.controlPoints.values.count {
                    let point2 = self.point(index: i, rect: rect)
                    let midPoint = CGPoint.midPointForPoints(point1: point1, point2: point2)
                    path.addQuadCurve(to: midPoint, control: CGPoint.controlPointForPoints(point1: midPoint, point2: point1))
                    path.addQuadCurve(to: point2, control: CGPoint.controlPointForPoints(point1: midPoint, point2: point2))
                    point1 = point2
                    i += 1
                }
            } else {
                while i < self.controlPoints.values.count {
                    path.addLine(to:  self.point(index: i, rect: rect))
                    i += 1
                }
            }
            
            if (self.closedArea) { // closed area below the chart line
                path.addLine(to: CGPoint(x: rect.width, y: rect.height))
                path.addLine(to: CGPoint(x: 0, y: rect.height))
                path.addLine(to: point1)
            }
        }
    }
}
