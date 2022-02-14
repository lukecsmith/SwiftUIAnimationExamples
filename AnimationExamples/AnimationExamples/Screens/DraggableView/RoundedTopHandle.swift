//
//  RoundedTopHandle.swift
//  DraggingTest
//
//  Created by Luke Smith on 14/02/2022.
//

import SwiftUI

struct RoundedTopHandle: View {
    var body: some View {
        tabHandle()
            .background(
                Color.black
                // There is a bug in iOS that messes with ScrollView and clipedShape:
                // https://stackoverflow.com/questions/64259513/swiftui-issue-on-ios-14
                // Howeever, if it is in background, it works fine
                
                .clipShape(RoundedCorner(radius: 45, corners: [.topLeft]))
                .shadow(color: Color.gray.opacity(0.2),
                        radius: 10,
                        x: 0,
                        y: 0)
            )
    }
    
    private func tabHandle() -> some View {
        HStack {
            Spacer()
            SlidableHandle()
                .padding(.top, 20)
            Spacer()
        }
        .contentShape(Rectangle())
    }
}

struct SlidableHandle: View {
    private let handleThickness = CGFloat(7.0)
    var body: some View {
        RoundedRectangle(cornerRadius: handleThickness / 2.0)
            .frame(width: 30,
                   height: handleThickness)
            .foregroundColor(Color(UIColor.lightGray))
            .padding(5)
    }
}


struct RoundedTopHandle_Previews: PreviewProvider {
    static var previews: some View {
        RoundedTopHandle()
    }
}
