//
//  AnimatingShapesAsMenuBackground.swift
//  AnimationExamples
//
//  Created by Luke Smith on 11/01/2021.
//

import SwiftUI

struct AnimatingShapesAsMenuBackground: View {
    var body: some View {
        ZStack {
            AnimatingRandomShapesView()
            VStack {
                Cell(text: "Option 1").padding()
                Cell(text: "Option 2").padding()
                Cell(text: "Option 3").padding()
            }.padding()
        }
    }
}

struct AnimatingShapesAsMenuBackground_Previews: PreviewProvider {
    static var previews: some View {
        AnimatingShapesAsMenuBackground()
    }
}
