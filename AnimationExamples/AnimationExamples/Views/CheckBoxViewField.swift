//
//  CheckBoxViewField.swift
//  PlatformMotif-debug
//
//  Created by Luke Smith on 26/11/2020.
//  Copyright © 2020 uMotif. All rights reserved.
//

import SwiftUI

struct CheckBoxViewField: View {
    
    var labelText: String
    var onTapped: (Bool) -> Void
    
    var body: some View {
        HStack {
            CheckBoxView(onTapped: onTapped)
            Text(labelText)
            Spacer()
        }
    }
}

struct CheckBoxViewField_Previews: PreviewProvider {
    
    static var previews: some View {
        CheckBoxViewField(labelText: "test") { _ in }
    }
}
