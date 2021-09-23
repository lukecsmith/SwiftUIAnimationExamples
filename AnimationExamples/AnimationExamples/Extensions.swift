//
//  Extensions.swift
//  AnimationExamples
//
//  Created by Luke Smith on 23/09/2021.
//

import Foundation
import UIKit

extension CGPoint {
    static func midPointForPoints(point1: CGPoint, point2: CGPoint) -> CGPoint {
        return CGPoint(x: (point1.x + point2.x) / 2, y: (point1.y + point2.y) / 2)
    }
    
    static func controlPointForPoints(point1: CGPoint, point2: CGPoint) -> CGPoint {
        var controlPoint = CGPoint.midPointForPoints(point1: point1, point2: point2)
        let diffY = abs(point2.y - controlPoint.y)
        
        if point1.y < point2.y {
            controlPoint.y += diffY
        } else if point1.y > point2.y {
            controlPoint.y -= diffY
        }
        return controlPoint
    }
}


