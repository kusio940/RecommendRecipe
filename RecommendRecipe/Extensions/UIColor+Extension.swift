//
//  UIColor+Extension.swift
//  RecommendRecipe
//
//  Created by 宮永祐介 on 2020/09/18.
//  Copyright © 2020 Miyanaga. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
     
    static let baseColor = 0xFEF3D2
    static let undoButtonColor = 0x49E1B9

    convenience init(rgb: Int) {
        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0x00FF00) >>  8) / 255.0
        let b = CGFloat( rgb & 0x0000FF       ) / 255.0
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
     
    convenience init(rgba: Int) {
        let r: CGFloat = CGFloat((rgba & 0xFF000000) >> 24) / 255.0
        let g: CGFloat = CGFloat((rgba & 0x00FF0000) >> 16) / 255.0
        let b: CGFloat = CGFloat((rgba & 0x0000FF00) >>  8) / 255.0
        let a: CGFloat = CGFloat( rgba & 0x000000FF       ) / 255.0
        self.init(red: r, green: g, blue: b, alpha: a)
    }
}
