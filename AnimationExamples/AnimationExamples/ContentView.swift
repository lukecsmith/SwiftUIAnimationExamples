//
//  ContentView.swift
//  AnimationExamples
//
//  Created by Luke Smith on 23/11/2020.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        NavigationView {
            List {
                NavigationLink(destination: AnimatingCirclesView(duration: 4.0,
                                                                 noCircles: 4,
                                                                 color: Color.blue,
                                                                 initialScale: 0.01,
                                                                 finalScale: 1.0)) {
                    Text("Circles view")
                }
                NavigationLink(destination: DemoAnimatingShapesAsBackground()) {
                    Text("Random Shapes")
                }
                NavigationLink(destination: TestErrorView()) {
                    Text("Transitioning Error View")
                }
                /*
                NavigationLink(destination: LineDrawingTest()) {
                    Text("Line Drawing")
                }*/
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
