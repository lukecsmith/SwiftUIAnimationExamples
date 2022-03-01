//
//  RoundedTopHandle.swift
//  DraggingTest
//
//  Created by Luke Smith on 14/02/2022.
//

import SwiftUI

struct TopHandleBar: View {
    
    private let handleThickness = CGFloat(7.0)
    
    var body: some View {
        ZStack {
            TopHandleBarBackgroundShape()
                .foregroundColor(Color.green)
            VStack {
                Spacer()
                RoundedRectangle(cornerRadius: handleThickness / 2.0)
                    .frame(width: 30,
                           height: handleThickness)
                    .foregroundColor(Color(UIColor.lightGray))
                    .padding(5)
            }
        }
        .frame(height: 37.0)
    }
}

// a rectangle with the top left corner fully rounded off (cant be done with cornerRadius etc)
struct TopHandleBarBackgroundShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.height))
        let arcCentre = CGPoint(x: rect.height, y: rect.height)
        path.addArc(center: arcCentre,
                    radius: rect.height,
                    startAngle: .degrees(180),
                    endAngle: .degrees(270),
                    clockwise: false)
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        
        return path
    }
}

struct TopHandleBar_Previews: PreviewProvider {
    static var previews: some View {
        TopHandleBar()
            .preferredColorScheme(.dark)
        TopHandleBar()
            .preferredColorScheme(.light)
    }
}
