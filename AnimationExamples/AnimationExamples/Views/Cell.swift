//
//  Cell.swift
//  DCPFM-SUI
//
//  Created by Luke Smith on 29/09/2020.
//  Copyright © 2020 Luke Smith. All rights reserved.
//

// this work is ok

import SwiftUI

struct Cell: View {
    
    var text: String
    var backgroundColour = Color.gray
    var textColour = Color.blue
    var cornerRadius : CGFloat = 8.0
    var tapClosure : (() -> Void)?
    
    var body: some View {
        ZStack {
            backgroundColour.frame(height: 36.0)
                .cornerRadius(cornerRadius)
                    .onTapGesture {
                        if self.tapClosure != nil {
                            tapClosure!()
                        }
                }
            HStack {
                Text("\(text)")
                    .foregroundColor(self.textColour)
                    .lineLimit(1)
                Spacer()
            }
            .padding(.horizontal)
        }
    }
}

struct Cell_Previews: PreviewProvider {
    static var previews: some View {
        Cell(text: "test")
    }
}
