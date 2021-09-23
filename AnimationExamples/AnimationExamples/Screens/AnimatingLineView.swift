//
//  AnimatingLineView.swift
//  AnimationExamples
//
//  Created by Luke Smith on 22/09/2021.
//

import Foundation
import SwiftUI

struct AnimatingLineView: View {
    
    @State var selectedPoints: [CGFloat] = []
    @State var chartNo = 0
    @State var on = true
    @State var decimalDataSets: [[CGFloat]] = [
        [0.4,1.0,0.2,0.8,0.9,0.2,0.4,0.6,0.6,0.2,0.2,0.9,0.3,0.5,0.8,0.7,0.1],
        [0.6,0.2,0.2,0.9,0.3,0.5,0.8,0.7,0.1,0.4,1.0,0.2,0.8,0.9,0.2,0.4,0.6]]
    
    var body: some View {
        VStack {
            Button("Next") {
                if chartNo == decimalDataSets.count - 1 {
                    chartNo = 0
                    updateData()
                } else {
                    chartNo += 1
                    updateData()
                }
            }
            LineGraph(dataPoints: $selectedPoints)
                .trim(to: on ? 1 : 0)
                .stroke(Color.red, lineWidth: 2)
                .aspectRatio(16/9, contentMode: .fit)
                .border(Color.gray, width: 1)
                .padding()
        }.onAppear {
            updateData()
        }
    }
    
    func updateData() {
        self.on = false
        withAnimation(.easeInOut(duration: 2)) {
            selectedPoints = decimalDataSets[chartNo]
            self.on = true
        }
    }
}

struct LineGraph: Shape {
    @Binding var dataPoints: [CGFloat]
    
    var animatableData: [CGFloat] {
        get { return dataPoints }
        set { self.dataPoints = newValue }
    }

    func path(in rect: CGRect) -> Path {
        func point(at ix: Int) -> CGPoint {
            let point = dataPoints[ix]
            let x = rect.width * CGFloat(ix) / CGFloat(dataPoints.count - 1)
            let y = (1-point) * rect.height
            return CGPoint(x: x, y: y)
        }

        return Path { p in
            guard dataPoints.count > 1 else { return }
            let start = dataPoints[0]
            var point1 = CGPoint(x: 0, y: (1-start) * rect.height)
            p.move(to: point1)
            
            for idx in dataPoints.indices {
                let point2 = point(at: idx)
                let midPoint = CGPoint.midPointForPoints(point1: point1, point2: point2)
                p.addQuadCurve(to: midPoint, control: CGPoint.controlPointForPoints(point1: midPoint, point2: point1))
                p.addQuadCurve(to: point2, control: CGPoint.controlPointForPoints(point1: midPoint, point2: point2))
                point1 = point2
            }
        }
    }
}
