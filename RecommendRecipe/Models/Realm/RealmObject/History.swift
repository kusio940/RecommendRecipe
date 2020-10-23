//
//  History.swift
//  RecommendRecipe
//
//  Created by 宮永祐介 on 2020/10/21.
//  Copyright © 2020 Miyanaga. All rights reserved.
//

import Foundation
import RealmSwift

class History: Object {
 
    @objc dynamic var recipeId = ""
    @objc dynamic var recipeTitle = ""
    @objc dynamic var recipeImageUrl = ""
    @objc dynamic var recipeUrl = ""
    @objc dynamic var time = ""
    
    override static func primaryKey() -> String? {
        return "recipeId"
    }
}
