//
//  DraggableView.swift
//  AnimationExamples
//
//  Created by Luke Smith on 14/02/2022.
//

import SwiftUI

struct DraggableView: View {
    
    let items = ["Transaction 1", "Transaction 2", "Transaction 3", "Transaction 4", "Transaction 5", "Transaction 6"]
    
    var body: some View {
        ZStack {
            VStack {
                RoundedTopHandle()
                List(items, id: \.self) { item in
                    Text(item)
                }
            }.draggableBetweenTwoVerticalPositions(min: 0.2, max: 0.7)
        }
    }
}

struct DraggableView_Previews: PreviewProvider {
    static var previews: some View {
        DraggableView()
    }
}
