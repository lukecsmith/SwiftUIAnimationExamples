//
//  ColorPalette.swift
//  AnimationExamples
//
//  Created by Luke Smith on 17/01/2021.
//

import Foundation
import UIKit
import SwiftUI

enum ColorPalette: String {
    case gradient1a
    case gradient1b
    case gradient2a
    case gradient2b
    case gradient3a
    case gradient3b
    
    var uiColor: UIColor {
        if let color = UIColor(named: self.rawValue) {
            return color
        } else {
            assertionFailure("Tried to create a color that was missing from Assets")
            return UIColor.white
        }
    }
    
    var swiftUIColor: Color {
        return Color(self.uiColor)
    }
    
    var cgColor: CGColor {
        return self.uiColor.cgColor
    }
}
