//
//  AnimatingCirclesView.swift
//  BloomlifePlus
//
//  Created by Luke Smith on 29/01/2020.
//  Copyright © 2020 Bloomlife. All rights reserved.
//

import SwiftUI

struct AnimatingCirclesView: View {
    let duration: Double
    let noCircles: Int
    let color: Color
    let initialScale: CGFloat
    let finalScale: CGFloat
    
    var body: some View {
        let interval: Double = self.duration / Double(noCircles)
        
        return ZStack {
            ForEach(0 ..< noCircles) { i in
                AnimatingCircleView(color: self.color,
                                    delay: Double(i) * interval,
                                    initialScale: self.initialScale,
                                    finalScale: self.finalScale,
                                    duration: self.duration)
            }
        }
    }
}

struct AnimatingCircleView: View {
    let color: Color
    let delay: Double
    let initialScale: CGFloat
    let finalScale: CGFloat
    let duration: Double
    @State var large: Bool = false
    var body: some View {
        Circle()
            .opacity(self.large ? 0.0 : 1.0)
            .scaleEffect(self.large ? self.finalScale : self.initialScale)
            .foregroundColor(self.color)
            .onAppear {
                //first timer is just a one-shot delay to the start of animating - this varies per circle, allowing the overlapping effect.
                //these scheduled timers are more accurate than doing a 'DispatchQueue.main.asyncAfter(deadline: .now() + x)'
                Timer.scheduledTimer(withTimeInterval: self.delay, repeats: false) { _ in
                    self.animate()
                    //second timer is the repeating one, which sets large back to false, then animates it to true
                    Timer.scheduledTimer(withTimeInterval: self.duration, repeats: true) { _ in
                        self.animate()
                    }
                }
            }
    }
    
    func animate() {
        self.large = false
        //using the 'withAnimation' call ensures that only this parameter is getting animated, and nothing else in the view hierarchy
        withAnimation(Animation.easeInOut(duration: duration)) {
            self.large = true
        }
    }
}

struct AnimatingCirclesView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            AnimatingCirclesView(duration: 4.0, noCircles: 4, color: Color.blue, initialScale: 0.3, finalScale: 1.0)
            AnimatingCirclesView(duration: 2.0, noCircles: 8, color: Color.red, initialScale: 0.0, finalScale: 1.0)
            AnimatingCirclesView(duration: 8.0, noCircles: 8, color: Color.green, initialScale: 0.3, finalScale: 1.0)
        }
    }
}
