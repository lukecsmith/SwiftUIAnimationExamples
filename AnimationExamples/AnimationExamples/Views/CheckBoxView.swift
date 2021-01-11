//
//  CheckBoxView.swift
//  PlatformMotif-debug
//
//  Created by Luke Smith on 26/11/2020.
//  Copyright © 2020 uMotif. All rights reserved.
//

import SwiftUI

struct CheckBoxView: View {
    
    @State private var checked: Bool = false
    @State private var trimVal: CGFloat = 0
    
    private var animatableData: CGFloat {
        get { trimVal }
        set { trimVal = newValue }
    }
    
    var onTapped: (Bool) -> Void
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .trim(from: 0, to: trimVal)
                .stroke(style: StrokeStyle(lineWidth: 1))
                .frame(width: 30, height: 30)
                .foregroundColor(checked ? Color.green : Color.gray.opacity(0.2))
            RoundedRectangle(cornerRadius: 6)
                .trim(from: 0, to: 1)
                .fill(checked ? Color.green : Color.gray.opacity(0.2))
                .frame(width: 26, height: 26)
            if checked {
                Image(systemName: "checkmark")
                    .foregroundColor(Color.white)
            }
        }.onTapGesture {
            withAnimation(Animation.easeIn(duration: 0.2)) {
                self.trimVal = self.checked ? 0 : 1
                self.checked.toggle()
            }
            onTapped(checked)
        }
    }
}

struct CheckBoxView_Previews: PreviewProvider {
    static var previews: some View {
        CheckBoxView() { _ in
            print("tapped")
        }
    }
}
