//
//  RealmManager.swift
//  RecommendRecipe
//
//  Created by 宮永祐介 on 2020/10/18.
//  Copyright © 2020 Miyanaga. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager {
    
    let realm = try! Realm()
    let realmFilePath =  NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "/default.realm"
    
    func favorireWrite(recipeId:String,
                       recipeTitle:String,
                       recipeImageUrl:String,
                       recipeUrl:String,
                       categoryType:String)
    {
        let favorite = Favorite()
        
        favorite.recipeId = recipeId
        favorite.recipeTitle = recipeTitle
        favorite.recipeImageUrl = recipeImageUrl
        favorite.recipeUrl = recipeUrl
        favorite.categoryType = categoryType
        favorite.time = Date().getCurrentTime()
        
        try! realm.write {
            realm.add(favorite, update: .all)
        }
    }
    
    func deleteDbDataWithRecipeId<Element: Object>(realmObject: Element.Type, recipeId:String) {
        if(isExistRecipeId(realmObject: Element.self, recipeId: recipeId)) {
            try! realm.write {
                let condition:String = "recipeId == '\(recipeId)'"
                let results = realm.objects(Element.self).filter(condition).first!
                realm.delete(results)
            }
        }
    }
    
    func isExistRecipeId<Element: Object>(realmObject: Element.Type, recipeId:String)-> Bool {
        if(!FileManager.default.fileExists(atPath: realmFilePath)){
            return false
        }
        
        let results = realm.object(ofType: Element.self, forPrimaryKey: recipeId)
        if(results == nil){
            return false
        }
        
        return true
    }
    
}
