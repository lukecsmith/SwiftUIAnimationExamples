//
//  LineDrawingTest.swift
//  AnimationExamples
//
//  Created by Luke Smith on 30/12/2020.
//

import SwiftUI

struct LineDrawingTest: View {
    
    @State private var endPoint: CGPoint?
    @State private var controlPoint: CGPoint?
    
    @State var curvedLines: [CurvedLine] = []
    
    var body: some View {
        
        GeometryReader { geometry in
            VStack {
                ZStack  {
                    Path { path in
                        path.move(to: CGPoint(x: 0, y: 0))
                        
                        curvedLines.forEach { curvedLine in
                            
                            path.addQuadCurve(
                                to: CGPoint(
                                    x: curvedLine.endPoint.x,
                                    y: curvedLine.endPoint.y
                                ),
                                control: CGPoint(
                                    x: curvedLine.controlPoint.x,
                                    y: curvedLine.controlPoint.y
                                )
                            )
                        }
                    }.stroke(Color.red,lineWidth: 3)
                    .foregroundColor(Color(red: 103/255, green: 183/255, blue: 164/255))
                    
                    if let end = endPoint {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 50, height: 50)
                            .position(x: end.x, y: end.y)
                    }
                    
                    if let control = controlPoint {
                        Circle()
                            .fill(Color.green)
                            .frame(width: 50, height: 50)
                            .position(x: control.x, y: control.y)
                    }
                    
                    VStack {
                        Spacer()
                        Button("Add") {
                            if let end = endPoint, let control = controlPoint {
                                curvedLines.append(CurvedLine(endPoint: end, controlPoint: control))
                                endPoint = nil
                                controlPoint = nil
                            }
                        }
                    }
                }
            }
        }.contentShape(Rectangle()).gesture(
            DragGesture(minimumDistance: 0, coordinateSpace: .global)
                .onChanged { _ in
                    
                }
                .onEnded { value in
                    self.tappedAt(point: value.location)
                }
        )
    }
    
    func tappedAt(point: CGPoint) {
        print("tapped at \(point)")
        if endPoint == nil {
            endPoint = point
            return
        }
        if controlPoint == nil {
            controlPoint = point
        }
    }
}

struct CurvedLine {
    let endPoint: CGPoint
    let controlPoint: CGPoint
}

struct LineDrawingTest_Previews: PreviewProvider {
    static var previews: some View {
        LineDrawingTest()
    }
}
