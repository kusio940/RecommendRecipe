//
//  Date+Extension.swift
//  RecommendRecipe
//
//  Created by 宮永祐介 on 2020/10/19.
//  Copyright © 2020 Miyanaga. All rights reserved.
//

import Foundation

extension Date {
    
    func getCurrentTime() -> String {
        let now = Date()
        let dateFormatter = DateFormatter()
        // DateFormatter を使用して書式とロケールを指定する
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yMMMdHmsSSS", options: 0, locale: Locale(identifier: "ja_JP"))
        return dateFormatter.string(from: now)
    }
    
}
