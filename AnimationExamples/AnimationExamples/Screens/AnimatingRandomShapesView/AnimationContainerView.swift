//
//  AnimationContainerView.swift
//  AnimationExamples
//
//  Created by Luke Smith on 15/01/2021.
//

import SwiftUI

struct AnimationContainerView: View {
    
    @State var position: CGFloat = 200
    let delay: Double
    let duration: Double
    let onTimerEnd: (Int) -> Void
    let shapeNo: Int
    
    var body: some View {
        RandomBoxShape()
            .position(x: 0, y: position)
            .onAppear {
                position = -300
                Timer.scheduledTimer(withTimeInterval: self.delay, repeats: false) { _ in
                    timerAction()
                    Timer.scheduledTimer(withTimeInterval: self.duration, repeats: true) { _ in
                        timerAction()
                    }
                }
            }
    }
    
    func timerAction() {
        self.onTimerEnd(shapeNo)
        //position = rect.size.height * 1.3
        withAnimation(Animation.linear(duration: self.duration)) {
            position = -300
        }
    }
}
/*
struct AnimationContainerView_Previews: PreviewProvider {
    static var previews: some View {
        AnimationContainerView()
    }
}*/
