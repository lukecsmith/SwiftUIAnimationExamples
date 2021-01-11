//
//  RandomBoxPointData.swift
//  AnimationExamples
//
//  Created by Luke Smith on 11/01/2021.
//

import Foundation
import SwiftUI

struct RandomBoxPointData {
    var topLinePoints = [CGPoint]()
    var topLineControlPoints = [CubicCurveSegment]()
    var bottomRight: CGPoint
    var bottomLeft: CGPoint
    
    init(rect: CGRect) {
        self.bottomRight = CGPoint(x: rect.size.width, y: rect.size.height)
        self.bottomLeft = CGPoint(x: 0, y: rect.size.height)
        self.topLinePoints = self.createTopLinePoints(rect: rect, noOfPointsInTopLine: 7, verticalRandomization: 50, horizontalRandomization: 0)
        self.topLineControlPoints = CubicCurveAlgorithm().controlPointsFromPoints(dataPoints: self.topLinePoints)
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
        
        print("Created points: \(points)")
        
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
