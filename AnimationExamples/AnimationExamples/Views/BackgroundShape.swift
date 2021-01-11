//
//  BackgroundShape.swift
//  AnimationExamples
//
//  Created by Luke Smith on 01/01/2021.
//

import SwiftUI

struct BackgroundShape: Shape {
    //creates a path and returns it.
    func path(in rect: CGRect) -> Path {
        
        print("Creating path")
        
        let points = createTopLinePoints(rect: rect, noOfPointsInTopLine: 5, verticalRandomization: 60, horizontalRandomization: 20)
        
        //create control points for each point
        let cubicCurveAlgorithm = CubicCurveAlgorithm()
        let segments = cubicCurveAlgorithm.controlPointsFromPoints(dataPoints: points)
        
        var path = Path()
        //go to origin
        path.move(to: points[0])
        
        //add the curve points
        for i in 1...(points.count - 1) {
            let point = points[i]
            let segment = segments[i-1]
            path.addCurve(to: point, control1: segment.controlPoint1, control2: segment.controlPoint2)
        }
        
        //complete the box
        path.addLine(to: CGPoint(x: rect.size.width, y: rect.size.height))
        path.addLine(to: CGPoint(x: 0, y: rect.size.height))
        path.addLine(to: points[0])
        
        return path
    }
    
    func createTopLinePoints(rect: CGRect, noOfPointsInTopLine: Int, verticalRandomization: Int, horizontalRandomization: Int) -> [CGPoint] {
        
        guard noOfPointsInTopLine > 0 else {
            return []
        }
        
        var points = [CGPoint]()
        
        //first point - always on left side, but a vertically random distance from the top
        let firstPoint = self.randomlyAdjustPoint(start: CGPoint(x: 0,y: 0), xRange: 0...0, yRange: 0...verticalRandomization)
        points.append(firstPoint)
        
        //create the random points along the top of the shape
        if noOfPointsInTopLine > 1 {
            
            if noOfPointsInTopLine > 2 {
                
                let xGap = rect.size.width / CGFloat(noOfPointsInTopLine - 1)
                
                for i in 1...noOfPointsInTopLine - 2 {
                    let midPoint = self.randomlyAdjustPoint(start: CGPoint(x: CGFloat(i) * xGap,y: 0), xRange: 0...horizontalRandomization, yRange: 0...verticalRandomization)
                    points.append(midPoint)
                }
                
                let topRight = self.randomlyAdjustPoint(start: CGPoint(x: rect.size.width,y: 0), xRange: 0...0, yRange: 0...verticalRandomization)
                points.append(topRight)
            }
        }
        
        //print("Created points: \(points)")
        
        return points
        
    }
    
    func randomlyAdjustPoint(start: CGPoint, xRange: ClosedRange<Int>, yRange: ClosedRange<Int>) -> CGPoint {
        let xAdjust = Int.random(in: xRange)
        let yAdjust = Int.random(in: yRange)
        let adjustedPoint = CGPoint(x: start.x + CGFloat(xAdjust), y: start.y + CGFloat(yAdjust))
        return adjustedPoint
    }
    
    func curvedPoints(points: [CGPoint]) {
        
        let cubicCurveAlgorithm = CubicCurveAlgorithm()
        
        let controlPoints = cubicCurveAlgorithm.controlPointsFromPoints(dataPoints: points)
        
        
        let linePath = UIBezierPath()
        
        for i in 0..<points.count {
            let point = points[i];
            
            if i==0 {
                linePath.move(to: point)
            } else {
                let segment = controlPoints[i-1]
                linePath.addCurve(to: point, controlPoint1: segment.controlPoint1, controlPoint2: segment.controlPoint2)
            }
        }
    }
}

struct BackgroundShape_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundShape()
    }
}
