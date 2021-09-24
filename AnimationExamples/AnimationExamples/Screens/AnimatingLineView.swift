//
//  AnimatingLineView.swift
//  AnimationExamples
//
//  Created by Luke Smith on 22/09/2021.
//

import Foundation
import SwiftUI

struct AnimatingLineView: View {
    
    @State var selectedPoints: [Double] = []
    @State var chartNo = 0
    @State var on = true
    @State var decimalDataSets: [[Double]] = [
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
            LineGraph(normalizedYValues: $selectedPoints)
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
    
    @Binding var normalizedYValues: [Double]
    
    var animatableData: [Double] {
        get { return normalizedYValues }
        set { self.normalizedYValues = newValue }
    }

    func path(in rect: CGRect) -> Path {
        func point(at idx: Int) -> CGPoint {
            let point = normalizedYValues[idx]
            let x = rect.width * CGFloat(idx) / CGFloat(normalizedYValues.count - 1)
            let y = (1-CGFloat(point)) * rect.height
            return CGPoint(x: x, y: y)
        }

        return Path { path in
            guard normalizedYValues.count > 1 else { return }
            let start = normalizedYValues[0]
            var point1 = CGPoint(x: 0, y: (1-CGFloat(start)) * rect.height)
            path.move(to: point1)
            
            for idx in normalizedYValues.indices {
                let point2 = point(at: idx)
                let midPoint = CGPoint.midPointForPoints(point1: point1, point2: point2)
                let firstControl = CGPoint.controlPointForPoints(point1: midPoint, point2: point1)
                path.addQuadCurve(to: midPoint, control: firstControl)
                let secondControl = CGPoint.controlPointForPoints(point1: midPoint, point2: point2)
                path.addQuadCurve(to: point2, control: secondControl)
                point1 = point2
            }
        }
    }
}
