//
//  Favorite.swift
//  RecommendRecipe
//
//  Created by 宮永祐介 on 2020/10/18.
//  Copyright © 2020 Miyanaga. All rights reserved.
//

import Foundation
import RealmSwift

class Favorite: Object {
    
    @objc dynamic var recipeId = ""
    @objc dynamic var recipeTitle = ""
    @objc dynamic var recipeImageUrl = ""
    @objc dynamic var recipeUrl = ""
    @objc dynamic var categoryType = ""
    @objc dynamic var time = ""
    
    override static func primaryKey() -> String? {
        return "recipeId"
    }
}
