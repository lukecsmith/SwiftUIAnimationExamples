//
//  PendulumView.swift
//  AnimationExamples
//
//  Created by Luke Smith on 22/03/2022.
//

import SwiftUI

struct Pendulum: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.height/2))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        return path
    }
}

struct PendulumView: View {
    
    //angle pendulum points to: 180 is East, 0 is West
    var angle: Double {
        return isMax ? maxSwing : minSwing
    }
    @State var timer: Timer?
    @State var animDuration = 2.0
    @State var isMax = false
    //size of swing area in degrees
    var swingSizeDegrees: Double = 120
    //when at min on left, angle for that (0 is West, 90 is North)
    var minSwing: Double {
        return (180 - swingSizeDegrees) / 2
    }
    //when at max on right, angle for that (180 is fully East)
    var maxSwing: Double {
        return 180 - minSwing
    }
    
    var body: some View {
        Pendulum()
            .fill(Color.red)
            .frame(width: 140, height: 6)
            .rotationEffect(Angle(degrees: angle))
            .onAppear {
                createAnimation()
            }
    }
    
    /**
     Animate the isMax bool, which moves the angle for rotation effect, between min and max settings
     */
    func createAnimation() {
        timer?.invalidate()
        withAnimation(Animation.easeInOut(duration: animDuration)) {
            self.isMax.toggle()
        }
        timer = Timer.scheduledTimer(withTimeInterval: self.animDuration, repeats: true) { _ in
            withAnimation(Animation.easeInOut(duration: animDuration)) {
                print("Animating")
                self.isMax.toggle()
            }
        }
    }
}

struct PendulumView_Previews: PreviewProvider {
    static var previews: some View {
        PendulumView()
    }
}
