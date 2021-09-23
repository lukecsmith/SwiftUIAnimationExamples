//
//  AllPointsAnimatingLineView.swift
//  AnimationExamples
//
//  Created by Luke Smith on 23/09/2021.
//

import Foundation
import SwiftUI

struct AllPointsAnimatingLineView: View {
    
    let areaGradient = LinearGradient(gradient: Gradient(colors: [Color.red.opacity(0.1), Color.blue.opacity(0.4)]), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 0, y: 1))
    let lineGradient = LinearGradient(gradient: Gradient(colors: [Color.white, Color.orange]), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 1, y: 0))
    
    @State var vector: AnimatableVector = AnimatableVector()
    @State var chartNo = 0
    @State var decimalDataSets: [[Double]] = [
        [0.4,1.0,0.2,0.8,0.9,0.2,0.4,0.6,0.6,0.2,0.2,0.9,0.3,0.5,0.8,0.7,0.1],
        [0.6,0.2,0.2,0.9,0.3,0.5,0.8,0.7,0.1,0.4,1.0,0.2,0.8,0.9,0.2,0.4,0.6]]
    
    var body: some View {
        let overlayLine = AnimatableGraph(controlPoints: self.vector, closedArea: true, curved: true)
            .stroke(lineGradient, lineWidth: 3)
        
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
            AnimatableGraph(controlPoints: self.vector, closedArea: true, curved: true)
                        .fill(areaGradient)
                        .overlay(overlayLine)
        }.onAppear {
            self.updateData()
        }
    }
    
    func updateData() {
        withAnimation(.easeInOut(duration: 2)) {
            self.vector = AnimatableVector(with: decimalDataSets[chartNo])
        }
    }
}
